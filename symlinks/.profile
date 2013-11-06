# Build the ever growing PATH
if [ -d ~/.homebrew/bin ]; then
	PATH=~/.homebrew/bin:$PATH
fi

if [ -d ~/.homebrew/sbin ]; then
	PATH=~/.homebrew/sbin:$PATH
fi

export PATH

export LANG='en_US.UTF-8'

# Export NODE_PATH for Node.js
export NODE_PATH=~/.homebrew/lib/node

export EDITOR='vim'

# Use VIM for as SVN editor
export SVNEDITOR='vim'

# Sprinkle some color on those file names
export CLICOLOR=1
export LSCOLORS=FxGxdxhxcxbxexcxcxFxFx

# Alias for deleting Apple System Logs
alias termspeedup='sudo rm -f /private/var/log/asl/*.asl'

# Alias that deletes shared objects
alias dso='rm -rf ~/Library/Preferences/Macromedia/Flash\ Player/#SharedObjects/*'

# Short alias for clear
alias c='clear'

# LS
alias l='ls -al'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../'

# Use colorsvn instead of svn if present
if [ -x ~/.homebrew/bin/colorsvn ]; then
	alias svn=colorsvn
fi

# Source bash completion file
if [ -f `brew --prefix`/etc/bash_completion ]; then
  . `brew --prefix`/etc/bash_completion
fi

export SVN_BASH_COMPL_EXT='svnstatus recurse externals'

if [ -f ~/bin/svn_bash_completion/svn_bash_completion.sh ]; then
	# http://svn.apache.org/repos/asf/subversion/trunk/tools/client-side/bash_completion
	. ~/bin/svn_bash_completion/svn_bash_completion.sh
fi

red="\033[0;31m"
green="\033[0;32m"
black="\033[0m"

function smiley () {
	ret=$?
	if [ $ret -eq 0 ]; then
	   echo -e "${green} :) ${black}"
	else
		echo -e "${red} :( ${black}"
	fi
}
PS1="[\W] \`if [ \$? = 0 ]; then echo \[\e[32m\]:\)\[\e[0m\]; else echo \[\e[31m\]:\(\[\e[0m\]; fi\` "
