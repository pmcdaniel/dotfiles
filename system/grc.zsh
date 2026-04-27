# GRC colorizes unix tools all over the place
if (( $+commands[brew] )) && (( $+commands[grc] ))
then
  source `brew --prefix`/etc/grc.zsh

  _grc_unwrapped_commands=(
    ls
  )

  for _grc_unwrapped_command in $_grc_unwrapped_commands
  do
    if (( $+functions[$_grc_unwrapped_command] ))
    then
      unfunction "$_grc_unwrapped_command"
    fi
  done

  unset _grc_unwrapped_command _grc_unwrapped_commands
fi
