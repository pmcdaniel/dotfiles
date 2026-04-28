autoload colors && colors

if (( $+commands[git] ))
then
  _dotfiles_git="$commands[git]"
else
  _dotfiles_git="/usr/bin/git"
fi

_dotfiles_prompt_escape() {
  print -r -- "${1//\%/%%}"
}

_dotfiles_git_branch() {
  local branch

  branch="$("$_dotfiles_git" symbolic-ref --quiet --short HEAD 2> /dev/null)" ||
    branch="$("$_dotfiles_git" rev-parse --short HEAD 2> /dev/null)" ||
    return 1

  _dotfiles_prompt_escape "$branch"
}

_dotfiles_git_dirty() {
  test -n "$("$_dotfiles_git" status --porcelain 2> /dev/null)"
}

_dotfiles_git_remote_status() {
  local behind ahead

  "$_dotfiles_git" rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' \
    > /dev/null 2>&1 || return 0

  read behind ahead <<< "$("$_dotfiles_git" rev-list --left-right --count \
    '@{upstream}...HEAD' 2> /dev/null)" || return 0

  if (( ahead > 0 && behind > 0 ))
  then
    print -r -- '%F{magenta}<>%f'
  elif (( ahead > 0 ))
  then
    print -r -- '%F{magenta}>%f'
  elif (( behind > 0 ))
  then
    print -r -- '%F{magenta}<%f'
  fi
}

_dotfiles_git_prompt() {
  local branch branch_color remote_status

  [[ -x "$_dotfiles_git" ]] || return 0
  "$_dotfiles_git" rev-parse --is-inside-work-tree > /dev/null 2>&1 ||
    return 0

  branch="$(_dotfiles_git_branch)" || return 0

  if _dotfiles_git_dirty
  then
    branch_color='red'
  else
    branch_color='green'
  fi

  remote_status="$(_dotfiles_git_remote_status)"
  print -r -- " %F{$branch_color}[$branch]%f$remote_status"
}

PROMPT='%F{blue}[%~]%f$(_dotfiles_git_prompt) -> '
