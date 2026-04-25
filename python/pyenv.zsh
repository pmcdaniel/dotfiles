# Setup pyenv (https://github.com/pyenv/pyenv)
if (( $+commands[pyenv] ))
then
  export PYENV_ROOT="$HOME/.pyenv"
  eval "$(pyenv init - zsh)"
fi
