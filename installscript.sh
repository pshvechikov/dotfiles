#!/bin/bash
############################
# This script is install script that creates symlinks from
# the home directory to any desired dotfiles in ~/dotfiles
############################
set -e 
set -x 


############################ INSTALL PACKAGES #################################
pkgs="git vim terminator tmux ipython"
sudo apt-get update 
sudo apt-get install $pkgs
###############################################################################


######################### INSTALL VUNDLE FOR VIM  #############################
src="https://github.com/gmarik/Vundle.vim.git"
dst="~/.vim/bundle/Vundle.vim"
test -d $dst || git clone $src $dst
###############################################################################


######################## Install font for terminator ##########################
FONT_NAME="SourceCodePro"
URL="https://github.com/adobe-fonts/source-code-pro/archive/1.017R.tar.gz"
mkdir -p /tmp/$FONT_NAME
cd /tmp/$FONT_NAME
wget $URL -O "`echo $FONT_NAME`.tar.gz"
tar --extract --gzip --file ${FONT_NAME}.tar.gz
sudo mkdir /usr/share/fonts/truetype/$FONT_NAME
sudo cp -rf /tmp/$FONT_NAME/. /usr/share/fonts/truetype/$FONT_NAME/.
fc-cache -f -v
###############################################################################


########## Variables
dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="gitconfig"                 # list of all dotfiles in ~/
files="$files vimrc"
files="$files latexmkrc"
files="$files inputrc"

##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

#### Terminator section starts ####
dstfile="~/.config/terminator/config"
file="terminator"
mkdir -p ~/.config/terminator
mv $dstfile $olddir/$file
ln -s $dir/$file $dstfile
#### Terminator section  ends  ####
