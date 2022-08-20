#!/usr/bin/env bash

#Parent install script

#Copy the bashrc, bash_aliases and backup if already present
if [ -e "~/.bashrc" ] || [ -e "~/.bash_aliases" ]; then
	echo "bashrc exists, backing up as ~/.bashrc_bkup"
	mv ~/.bashrc ~/.bashrc_bkup
	mv ~/.bash_aliases ~/.bash_aliases_bkup
	echo "Proceeding installation ..."
fi
mv ./bashrc ~/.bashrc
mv ./bash_aliases ~/.bash_aliases
mv ./bash_functions ~/.bash_functions

#Call the tmux installation script
./tmux_config/install.sh

#Install vim configuration
if [ -d "~/.vim" ]; then
	echo "Vim configuration already exists, backing up as ~/.vim_bkup"
	mv ~/.vim ~/.vim_bkup
	echo "Proceeding installation ..."
fi
cp -rf ./vim ~/.vim


