# LS Colors
export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=1

# Load functions
fpath=($DOT_FILES/functions $fpath)
autoload -U $DOT_FILES/funtions/*(:t)

# History Configuration
setopt HISTFILE=~/.zsh_history
setopt HISTSIZE=10000
setopt SAVEHIST=10000

# History Behavior
setopt HIST_VERIFY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_IGNORE_SPACE

# Job Control
setopt NO_BG_NICE
setopt NO_HUP

# UI / Completion Behavior
setopt NO_LIST_BEEP
setopt PROMPT_SUBST
setopt CORRECT
setopt COMPLETE_IN_WORD
setopt IGNORE_EOF
setopt complete_aliases

# Scoping / Traps
setopt LOCAL_OPTIONS
setopt LOCAL_TRAPS

# Directory Navigation
setopt AUTO_CD
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS

# Auto Complete Behavior
zstyle ':completion:*' list-colors 'di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' insert-tab pending

# Keybinds
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^K' kill-line
bindkey '^U' backward-kill-line
bindkey '^R' hiistory-incremental-search-backward
