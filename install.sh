#!/usr/bin/env bash

#Parent install script

echo "Copying bashrc files"
#Copy the bashrc, bash_aliases and backup if already present
if [ -e "$HOME/.bashrc" ] || [ -e "$HOME/.bash_aliases" ]; then
	echo "bashrc exists, backing up as $HOME/.bashrc_bkup"
	mv $HOME/.bashrc $HOME/.bashrc_bkup
	mv $HOME/.bash_aliases $HOME/.bash_aliases_bkup
	echo "Proceeding installation ..."
fi
cp -f ./bashrc $HOME/.bashrc
cp -f ./bash_aliases $HOME/.bash_aliases
cp -f ./bash_functions $HOME/.bash_functions

echo "Install and configure tmux"
#Call the tmux installation script
./tmux_config/install.sh

echo "Install vim configurations"
#Install vim configuration
if [ -d "$HOME/.vim" ]; then
	echo "Vim configuration already exists, backing up as $HOME/.vim_bkup"
	mv -f $HOME/.vim $HOME/.vim_bkup
	echo "Proceeding installation ..."
fi
cp -rf ./vim $HOME/.vim


