alias cw="cd /home/spk/work"
#replaces lt with an ls command that displays the size of each item, and then
#sorts it by size, in a single column, with a notation to indicate the kind of
#file.
alias lt='ls --human-readable --size -1 -S --classify'

#View only mounted drives
alias mnt="mount | awk -F' ' '{ printf \"%s\t%s\n\",\$1,\$3; }' | column -t | egrep ^/dev/ | sort"

#Find a command in history
alias gh='history|grep'

#Sort by modification time, to know where you left your work
alias left='ls -t -1'

#Count files in directory
alias count='find . -type f | wc -l'

#Copy progress bar
alias cpv='rsync -ah --info=progress2'

#Don't use rm, use tr, this moves the files to ~/.local/share/Trash
alias trm='mv --force -t ~/.local/share/Trash '

#Just disable rm
alias rm='abc'

alias c='clear'

alias v='vim'
alias vi='vim'

#Go to top level of git project
alias cg='cd `git rev-parse --show-toplevel`'
alias gs='git status'
alias gb='git branch'
alias gc='git checkout'
#Show the latest log
alias gl='git log -1 HEAD'

#git diff
alias gd='git diff'

if [ -e $HOME/.bash_functions ]; then
	source $HOME/.bash_functions
fi
