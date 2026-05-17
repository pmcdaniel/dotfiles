term_title() {
  local short_tab_title long_window_title

  if (( $# < 1 || $# > 2 ))
  then
    print -u2 "usage: term_title short_tab_title [long_window_title]"
    return 2
  fi

  short_tab_title="$1"
  long_window_title="${2:-$short_tab_title}"

  case "$TERM" in
    screen*|tmux*)
      printf '\033k%s\033\\' "$short_tab_title"
      ;;
    *)
      printf '\033]1;%s\007' "$short_tab_title"
      printf '\033]2;%s\007' "$long_window_title"
      ;;
  esac
}

_dotfiles_window_truncate_left() {
  local value max start

  value="$1"
  max="$2"

  if (( ${#value} <= max ))
  then
    print -r -- "$value"
    return 0
  fi

  start=$(( ${#value} - max + 1 ))
  print -r -- "..${value[$start,-1]}"
}

_dotfiles_window_truncate_right() {
  local value max

  value="$1"
  max="$2"

  print -r -- "${value[1,$max]}"
}

_dotfiles_window_command_name() {
  local line cmd
  local -a words

  line="$1"
  words=("${(z)line}")
  cmd="$words[1]"

  case "$cmd" in
    sudo|ssh|mosh|rake)
      cmd="$words[2]"
      ;;
  esac

  print -r -- "${cmd:-$line}"
}

_dotfiles_window_precmd() {
  local current_directory machine_name short_tab_title

  current_directory="$(print -P '%~')"
  machine_name="$(print -P '%m')"
  short_tab_title="$(_dotfiles_window_truncate_left "$current_directory" 30)"

  term_title "$short_tab_title" "$machine_name: $current_directory"
}

_dotfiles_window_preexec() {
  local command_name current_directory line machine_name short_tab_title

  line="$2"
  command_name="$(_dotfiles_window_command_name "$line")"
  current_directory="$(print -P '%~')"
  machine_name="$(print -P '%m')"
  short_tab_title="$(_dotfiles_window_truncate_right "$line" 100)"

  term_title "$short_tab_title" "$machine_name: $current_directory - $command_name"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _dotfiles_window_precmd
add-zsh-hook preexec _dotfiles_window_preexec
