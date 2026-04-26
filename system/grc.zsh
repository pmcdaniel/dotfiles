# GRC colorizes unix tools all over the place
if (( $+commands[brew] )) && (( $+commands[grc] ))
then
  source `brew --prefix`/etc/grc.zsh
fi
