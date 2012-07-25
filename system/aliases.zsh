# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
if $(gls &>/dev/null)
then
  alias ls="gls -F --color"
  alias l="gls -lAh --color"
  alias ll="gls -l --color"
  alias la='gls -A --color'
fi

# list directories only
alias ldir="ll -d */"

alias less="less -iMF"

alias more="less"
alias mroe="more"
alias m="more"
alias h="history"

alias ..='cd ..'
