# Uses git's autocompletion for inner commands. Assumes an install of git's
# bash `git-completion` script at $completion below (this is where Homebrew
# tosses it, at least).
gitflowcompletion="$(brew --prefix)/share/zsh/site-functions/git-flow-completion.zsh"
if test -f $gitflowcompletion
then
  source $gitflowcompletion
fi
