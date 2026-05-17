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
