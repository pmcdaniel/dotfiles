# Quick Directory tab completions
c() { cd ~/Development/$1; }
_c() { _files -W ~/Development -/; }
compdef _c c

h() { cd ~/$1; }
_h() { _files -W ~/ -/; }
compdef _h h

# Switch Java Version function
# Usage: sjv <version>
# Description: Switches the version of Java currently referenced by java_home.  <version> should be of the form 1.7, 1.8
sjv () {
	local java_version=$1
	export JAVA_HOME=`/usr/libexec/java_home -v $java_version`
	java -version
}

# My aliases
alias reload!='. ~/.zshrc' # Reloads my zsh configurion
alias cls='clear' # Clear screen
alias pubkey="clipcopy ~/.ssh/id_rsa.pub | echo '=> Public key copied to pasteboard.'"

# Convert vi and vim to nvim
alias vi="nvim"
alias vim="nvim"
