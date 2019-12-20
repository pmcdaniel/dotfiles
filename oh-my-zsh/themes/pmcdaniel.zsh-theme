#!/usr/bin/env zsh

# Returns a colorized version of the branch based on whether it is dirty or not
function colorized_git_prompt_info() {
  local ref
  if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
    ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
    echo "$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

local time_of_day='%{$fg[blue]%}%D{[%I:%M:%S]}%{$reset_color%}'
local current_dir='%{$fg[white]%}[%~]%{$reset_color%}'
local git_prompt='$(colorized_git_prompt_info)'
local git_remote_status='$(git_remote_status)'

PROMPT="${time_of_day} ${current_dir} ${git_prompt}${git_remote_status} %{$fg[blue]%}->%{$reset_color%} "

ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_EQUAL_REMOTE=""
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE="%{$fg_bold[magenta]%}>%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE="%{$fg_bold[magenta]%}<%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE="%{$fg_bold[magenta]%}<>%{$reset_color%}"