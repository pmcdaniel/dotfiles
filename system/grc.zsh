# GRC colorizes nifty unix tools all over the place
# This is mostly copied from https://github.com/garabik/grc/blob/master/grc.zsh
# I've left off commands that I did not care about or had other aliases for
if [[ "$TERM" != dumb ]] && (( $+commands[grc] )) ; then
	# Prevent grc aliases from overriding zsh completions.
	setopt COMPLETE_ALIASES

	# Commands to coloriz
	cmds=(diff dig ifconfig make netstat ping ping6 ps traceroute traceroute6 wdiff);

	# set alias for available commands.
	for cmd in $cmds ; do
		if (( $+commands[$cmd] )) ; then
			alias $cmd="grc --colour=auto $cmd"
		fi
	done

	# Clean up variables
	unset cmds cmd
fi
