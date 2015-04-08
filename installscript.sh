#!/bin/bash
############################
# This script is install script that creates symlinks from
# the home directory to any desired dotfiles in ~/dotfiles
#
# NOTE: There are some steps that are required to be done by youself:
#   - disable Dash on SUPER key:
#       - unity-tweak-tool -> Unity -> Launcher -> Switcher -> Switching shortcuts
#       - after this Launcher will be still available with Alt+F1 press
#   - disable autograbbing keyboard in Virtualbox to allow switching
#     between host machine applications with shortcuts (such as CMD+TAB)
#     This could be done in VB Settings -> Input -> Autograbbing keyboard
#   - adjust video memory in Virtualbox settings
#   - share any folders in virtual machine
#   - install Vundle plugins inside Vim
#   -
############################

set -e
set -x

GITHUB=~/.ssh/github
DOTFILESDIR=~/dotfiles

# do not allow further execution until ssh-key is present
test -f $GITHUB || (echo Please provide SSH-key for github! && exit 1)

# get youserlf nopasswd sudo with line on dev machine
sudo $USER  ALL=NOPASSWD: ALL >> /etc/sudoers
# see if we are on Virtual Box and add  user to this group
# This hint allows using shared folders from
getent group vboxsf && sudo usermod -aG vboxsf $USER


############################ INSTALL PACKAGES #################################
pkgs="git vim terminator tmux ipython unity-tweak-tool"
sudo apt-get update
sudo apt-get install $pkgs
###############################################################################


######################### INSTALL VUNDLE FOR VIM  #############################
src="https://github.com/gmarik/Vundle.vim.git"
dst=~/.vim/bundle/Vundle.vim
test -d $dst || git clone $src $dst
###############################################################################


######################## INSTALL FONT FOR TERMINATOR ##########################
FONT_NAME="SourceCodePro"
URL="https://github.com/adobe-fonts/source-code-pro/archive/1.017R.tar.gz"
fontfoler=/usr/share/fonts/truetype/$FONT_NAME
mkdir -p /tmp/$FONT_NAME
cd /tmp/$FONT_NAME
wget $URL -O "`echo $FONT_NAME`.tar.gz"
tar --extract --gzip --file ${FONT_NAME}.tar.gz
sudo mkdir -p $fontfoler
test -d $fontfoler || sudo cp -rf /tmp/$FONT_NAME/. $fontfoler/.
fc-cache -f -v
###############################################################################


############################  CLONE DOT FILES  ################################
src=git@github.com:bestxolodec/dotfiles.git
dst=$DOTFILESDIR
test -d $dst | git clone $src $dst
###############################################################################


############################## INSTALL DOTFILES ###############################
########## Variables
dir=$DOTFILESDIR
olddir=$DOTFILESDIR_old
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
    # there could not be one to move
    mv ~/.$file ~/dotfiles_old/ || true
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

#### Terminator section starts ####
dstfile=~/.config/terminator/config
file="terminator"
mkdir -p ~/.config/terminator
mv $dstfile $olddir/$file || true
ln -s $dir/$file $dstfile
#### Terminator section  ends  ####
###############################################################################


