# Quick Directory tab completions
c() { cd ~/Development/$1; }
_c() { _files -W ~/Development -/; }
compdef _c c

h() { cd ~/$1; }
_h() { _files -W ~/ -/; }
compdef _h h

# My aliases
alias reload!='. ~/.zshrc' # Reloads my zsh configurion
alias cls='clear' # Clear screen
alias pubkey="clipcopy ~/.ssh/id_rsa.pub | echo '=> Public key copied to pasteboard.'"

# Convert vi and vim to nvim
alias vi="nvim"
alias vim="nvim"
