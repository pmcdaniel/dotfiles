# Setup pyenv (https://github.com/pyenv/pyenv)
if (( $+commands[pyenv] ))
then
  export PYENV_ROOT="$HOME/.pyenv"
  eval "$(pyenv init - zsh)"
fi

# Disable Python virtual environment prompt changes.
# It is set better in zsh/prompt.zsh
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
