export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Development

brew_prefix=`brew --prefix`
test -e "${brew_prefix}/bin/virtualenvwrapper.sh" && source "${brew_prefix}/bin/virtualenvwrapper.sh"
