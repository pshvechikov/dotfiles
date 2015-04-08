#!/bin/bash
############################
# This script is install script that creates symlinks from
# the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="gitconfig"                 # list of all dotfiles in ~/
files="$files vimrc"
files="$files latexmkrc"

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
