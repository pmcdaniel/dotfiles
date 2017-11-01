export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Development

brew_prefix=`brew --prefix`

# Manually setup python to our homebrewed python3 install
export VIRTUALENVWRAPPER_PYTHON=${brew_prefix}/bin/python3

test -e "${brew_prefix}/bin/virtualenvwrapper.sh" && source "${brew_prefix}/bin/virtualenvwrapper.sh"
