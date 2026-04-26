#!/bin/sh

set -u

DOTFILES_DIR=$(CDPATH= cd "$(dirname "$0")" && pwd)
MANIFEST="$DOTFILES_DIR/.install-manifest"
GIT_TEMPLATE="$DOTFILES_DIR/git/gitconfig.local.symlink.template"
GIT_LOCAL="$DOTFILES_DIR/git/gitconfig.local.symlink"
XDG_CONFIG_DIR=${XDG_CONFIG_HOME:-"$HOME/.config"}

if [ -t 1 ]; then
  RED=$(printf '\033[31m')
  GREEN=$(printf '\033[32m')
  YELLOW=$(printf '\033[33m')
  BLUE=$(printf '\033[34m')
  BOLD=$(printf '\033[1m')
  RESET=$(printf '\033[0m')
else
  RED=''
  GREEN=''
  YELLOW=''
  BLUE=''
  BOLD=''
  RESET=''
fi

CONFLICT_CHOICE=''
PROMPT_ACTION=''

say() {
  printf '%s\n' "$*"
}

info() {
  say "${BLUE}🔧 $*${RESET}"
}

success() {
  say "${GREEN}✅ $*${RESET}"
}

warn() {
  say "${YELLOW}⚠️  $*${RESET}"
}

fail() {
  say "${RED}❌ $*${RESET}" >&2
  exit 1
}

manifest_add() {
  printf '%s\t%s\t%s\n' "$1" "$2" "$3" >> "$MANIFEST"
}

is_managed_link() {
  target=$1
  source=$2

  [ -L "$target" ] || return 1
  [ "$(readlink "$target")" = "$source" ]
}

prompt_conflict() {
  target=$1

  if [ -n "$CONFLICT_CHOICE" ]; then
    PROMPT_ACTION=$CONFLICT_CHOICE
    return
  fi

  while :; do
    say "${YELLOW}Conflict:${RESET} $target already exists."
    printf 'Choose [o]verwrite, [b]ackup, [s]kip, overwrite [a]ll, backup a[l]l, skip all [q]: '
    IFS= read -r choice

    case "$choice" in
      o|overwrite)
        PROMPT_ACTION=overwrite
        return
        ;;
      b|backup)
        PROMPT_ACTION=backup
        return
        ;;
      s|skip|'')
        PROMPT_ACTION=skip
        return
        ;;
      a|overwrite-all)
        CONFLICT_CHOICE=overwrite
        PROMPT_ACTION=overwrite
        return
        ;;
      l|backup-all)
        CONFLICT_CHOICE=backup
        PROMPT_ACTION=backup
        return
        ;;
      q|skip-all)
        CONFLICT_CHOICE=skip
        PROMPT_ACTION=skip
        return
        ;;
      *)
        warn "Please choose o, b, s, a, l, or q."
        ;;
    esac
  done
}

backup_target() {
  target=$1
  timestamp=$(date '+%Y%m%d%H%M%S')
  backup="${target}.backup.${timestamp}"
  counter=1

  while [ -e "$backup" ] || [ -L "$backup" ]; do
    backup="${target}.backup.${timestamp}.${counter}"
    counter=$((counter + 1))
  done

  mv "$target" "$backup" || fail "Could not back up $target"
  manifest_add BACKUP "$target" "$backup"
  success "Backed up $target to $backup"
}

remove_target() {
  target=$1

  if [ -d "$target" ] && [ ! -L "$target" ]; then
    rm -rf "$target" || fail "Could not remove $target"
  else
    rm -f "$target" || fail "Could not remove $target"
  fi
}

link_item() {
  source=$1
  target=$2
  parent=$(dirname "$target")

  mkdir -p "$parent" || fail "Could not create $parent"

  if is_managed_link "$target" "$source"; then
    info "Already linked $target"
    manifest_add LINK "$target" "$source"
    return
  fi

  if [ -e "$target" ] || [ -L "$target" ]; then
    prompt_conflict "$target"
    action=$PROMPT_ACTION

    case "$action" in
      overwrite)
        remove_target "$target"
        success "Removed existing $target"
        ;;
      backup)
        backup_target "$target"
        ;;
      skip)
        warn "Skipped $target"
        return
        ;;
    esac
  fi

  ln -s "$source" "$target" || fail "Could not link $target"
  manifest_add LINK "$target" "$source"
  success "Linked $target -> $source"
}

escape_sed_replacement() {
  printf '%s' "$1" | sed 's/[\/&]/\\&/g'
}

setup_gitconfig() {
  [ -f "$GIT_TEMPLATE" ] || fail "Missing $GIT_TEMPLATE"

  info "Setting up git author and commit signing config"

  printf 'Git author name: '
  IFS= read -r git_name
  while [ -z "$git_name" ]; do
    warn "Git author name is required."
    printf 'Git author name: '
    IFS= read -r git_name
  done

  printf 'Git author email: '
  IFS= read -r git_email
  while [ -z "$git_email" ]; do
    warn "Git author email is required."
    printf 'Git author email: '
    IFS= read -r git_email
  done

  printf 'SSH public key for commit signing [~/.ssh/id_ed25519.pub]: '
  IFS= read -r git_key
  git_key=${git_key:-'~/.ssh/id_ed25519.pub'}

  case "$(uname -s)" in
    Darwin)
      git_credential_helper=osxkeychain
      ;;
    *)
      git_credential_helper=cache
      ;;
  esac

  name_repl=$(escape_sed_replacement "$git_name")
  email_repl=$(escape_sed_replacement "$git_email")
  key_repl=$(escape_sed_replacement "$git_key")
  helper_repl=$(escape_sed_replacement "$git_credential_helper")

  sed \
    -e "s/AUTHOR_NAME/$name_repl/g" \
    -e "s/AUTHOR_EMAIL/$email_repl/g" \
    -e "s/AUTHOR_KEY/$key_repl/g" \
    -e "s/GIT_CREDENTIAL_HELPER/$helper_repl/g" \
    "$GIT_TEMPLATE" > "$GIT_LOCAL" ||
    fail "Could not create $GIT_LOCAL"

  success "Created $GIT_LOCAL with credential helper '$git_credential_helper'"
}

install_home_symlinks() {
  info "Linking dotfiles into $HOME"
  list_file="${TMPDIR:-/tmp}/dotfiles-install-home.$$"

  find "$DOTFILES_DIR" \
    \( -path "$DOTFILES_DIR/.git" -o -path "$DOTFILES_DIR/.git/*" \
    -o -path "$DOTFILES_DIR/xdg-config" -o -path "$DOTFILES_DIR/xdg-config/*" \) -prune \
    -o -type f -name '*.symlink' ! -name '*.template' -print > "$list_file" ||
    fail "Could not find dotfile symlinks"

  while IFS= read -r source <&3; do
    file_name=$(basename "$source")
    link_name=${file_name%.symlink}
    link_item "$source" "$HOME/.$link_name"
  done 3< "$list_file"

  rm -f "$list_file"
}

install_xdg_config() {
  [ -d "$DOTFILES_DIR/xdg-config" ] || return 0

  info "Linking XDG config directories into $XDG_CONFIG_DIR"
  mkdir -p "$XDG_CONFIG_DIR" || fail "Could not create $XDG_CONFIG_DIR"
  list_file="${TMPDIR:-/tmp}/dotfiles-install-xdg.$$"

  find "$DOTFILES_DIR/xdg-config" -mindepth 1 -maxdepth 1 -type d -print > "$list_file" ||
    fail "Could not find XDG config directories"

  while IFS= read -r source <&3; do
    link_item "$source" "$XDG_CONFIG_DIR/$(basename "$source")"
  done 3< "$list_file"

  rm -f "$list_file"
}

install_dotfiles() {
  : > "$MANIFEST" || fail "Could not write $MANIFEST"

  say "${BOLD}✨ Installing dotfiles from $DOTFILES_DIR${RESET}"
  setup_gitconfig
  install_home_symlinks
  install_xdg_config
  success "Install complete"
}

unlink_manifest_links() {
  manifest=$1

  awk -F '\t' '$1 == "LINK" { print $2 "\t" $3 }' "$manifest" |
  while IFS="$(printf '\t')" read -r target source; do
    if is_managed_link "$target" "$source"; then
      rm -f "$target" || fail "Could not unlink $target"
      success "Unlinked $target"
    else
      warn "Skipped $target because it is not a managed symlink"
    fi
  done
}

restore_manifest_backups() {
  manifest=$1

  awk -F '\t' '$1 == "BACKUP" { print $2 "\t" $3 }' "$manifest" |
  while IFS="$(printf '\t')" read -r target backup; do
    if [ ! -e "$backup" ] && [ ! -L "$backup" ]; then
      warn "Backup missing: $backup"
      continue
    fi

    if [ -e "$target" ] || [ -L "$target" ]; then
      warn "Could not restore $backup because $target exists"
      continue
    fi

    mv "$backup" "$target" || fail "Could not restore $backup"
    success "Restored $target from $backup"
  done
}

discover_and_unlink() {
  warn "No manifest found; unlinking symlinks that point into $DOTFILES_DIR"

  find "$DOTFILES_DIR" \
    \( -path "$DOTFILES_DIR/.git" -o -path "$DOTFILES_DIR/.git/*" \
    -o -path "$DOTFILES_DIR/xdg-config" -o -path "$DOTFILES_DIR/xdg-config/*" \) -prune \
    -o -type f -name '*.symlink' ! -name '*.template' -print |
  while IFS= read -r source; do
    file_name=$(basename "$source")
    link_name=${file_name%.symlink}
    target="$HOME/.$link_name"

    if is_managed_link "$target" "$source"; then
      rm -f "$target" || fail "Could not unlink $target"
      success "Unlinked $target"
    fi
  done

  find "$DOTFILES_DIR/xdg-config" -mindepth 1 -maxdepth 1 -type d -print 2>/dev/null |
  while IFS= read -r source; do
    target="$XDG_CONFIG_DIR/$(basename "$source")"

    if is_managed_link "$target" "$source"; then
      rm -f "$target" || fail "Could not unlink $target"
      success "Unlinked $target"
    fi
  done
}

uninstall_dotfiles() {
  say "${BOLD}🧹 Uninstalling dotfiles from $DOTFILES_DIR${RESET}"

  if [ -f "$MANIFEST" ]; then
    unlink_manifest_links "$MANIFEST"
    restore_manifest_backups "$MANIFEST"
    rm -f "$MANIFEST" || fail "Could not remove $MANIFEST"
  else
    discover_and_unlink
  fi

  success "Uninstall complete"
}

usage() {
  cat <<EOF
Usage: ./install.sh [install|uninstall]

Commands:
  install     Install dotfiles (default)
  uninstall   Unlink dotfiles and restore manifest backups
EOF
}

case "${1:-install}" in
  install)
    install_dotfiles
    ;;
  uninstall)
    uninstall_dotfiles
    ;;
  -h|--help|help)
    usage
    ;;
  *)
    usage
    exit 1
    ;;
esac
