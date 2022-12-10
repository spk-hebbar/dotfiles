#!/usr/bin/env bash

set -e
set -u
set -o pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
#Parent install script
#-------------------------------------------------------------------------------
echo "Copying bashrc files"
if [ -e "$HOME/.bashrc" ] || [ -e "$HOME/.bash_aliases" ]; then
	echo "bashrc exists, backing up as $HOME/.bashrc_bkup"
	mv $HOME/.bashrc $HOME/.bashrc_bkup
	mv $HOME/.bash_aliases $HOME/.bash_aliases_bkup
fi

ln -sf $DIR/bashrc $HOME/.bashrc
ln -sf $DIR/bash_aliases $HOME/.bash_aliases
ln -sf $DIR/bash_functions $HOME/.bash_functions
echo "OK: Completed"
#-------------------------------------------------------------------------------

echo "Install and configure tmux"
#Call the tmux installation script
./tmux_config/install.sh
#-------------------------------------------------------------------------------

echo "Install vim configurations"
#Install vim configuration
if [ -d "$HOME/.vim" ]; then
	echo "Vim configuration already exists, backing up as $HOME/.vim_bkup"
    if [ -d $HOME/.vim_bkup ]; then
        echo "Attention! Backup folder exists, removing it!"
        rm -rf $HOME/.vim_bkup
    fi
	mv -f $HOME/.vim $HOME/.vim_bkup
fi
cp -rf $DIR/vim $HOME/.vim
echo "OK: Completed"

#-------------------------------------------------------------------------------

echo "Include script to display network hardware information"
ln -sf $DIR/net-hw.sh $HOME/.local/bin/
echo "OK: Completed"

#-------------------------------------------------------------------------------

echo "Install ctags"
ln -sf $DIR/gentags /usr/local/bin/gentags
echo "OK: Completed"

#Mount the file system from CSB laptop to current server
#sshfs -o allow_other,IdentityFile=/root/.ssh/id_rsa spk@10.74.18.55:/home/spk/work/ /mnt/spk
