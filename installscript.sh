#!/bin/bash
############################
# This script is install script that creates symlinks from
# the home directory to any desired dotfiles in ~/dotfiles
#
# NOTE: There are some steps that are required to be done by youself:
#   - disable Dash on SUPER key:
#       - unity-tweak-tool -> Unity -> Launcher -> Switcher -> Switching shortcuts
#       - after this Launcher will be still available with Alt+F1 or CMD-s
#   - disable autograbbing keyboard in Virtualbox to allow switching
#     between host machine applications with shortcuts (such as CMD+TAB)
#     This could be done in VB Settings -> Input -> Autograbbing keyboard
#   - adjust video memory in Virtualbox settings
#   - share any folders in virtual machine
#   - turn off lock in ubuntu settings to never lock the screen
#   - turn off suspending host machine on battery and on in charge modes
############################

set -e
set -x

GITHUB=~/.ssh/github
DOTFILESDIR=~/dotfiles
SUDO="$USER  ALL=NOPASSWD: ALL"

# do not allow further execution until ssh-key is present
test -f $GITHUB || (echo Please provide SSH-key for github! && exit 1)

# get youserlf nopasswd sudo with line on dev machine
sudo grep -q  $USER  /etc/sudoers ||  (echo $SUDO | sudo tee -a /etc/sudoers)
# see if we are on Virtual Box and add  user to this group
# This hint allows using shared folders from
getent group vboxsf && (id | grep -q vboxsf || sudo usermod -aG vboxsf $USER)


############################ INSTALL PACKAGES #################################
pkgs="git vim terminator tmux ipython ipython3 unity-tweak-tool exuberant-ctags"
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
test -d $dst || git clone $src $dst
###############################################################################


############################## INSTALL DOTFILES ###############################
# GLOBAL variables:
#  DOTFILESDIR - directory  where are all stored all cloned files
####################
#
########## local variables
dir=$DOTFILESDIR
olddir=${DOTFILESDIR}_old
# in a format - src:dst, where src - is the filename in `dotfiles` repo and
# `dst` - full path and name of the symbolic link to `src`
destinations="gitconfig:~/.gitconfig vimrc:~/.vimrc latexmkrc:~/.latexmkrc "
destinations="$destinations bashrc:.bashrc inputrc:~/.inputrc dircolors:~/.dircolors"
destinations="$destinations terminator:~/.config/terminator/config"
destinations="$destinations ipython_config.py:~/.ipython/profile_default/ipython_config.py"
##########

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"


echo "Moving any existing dotfiles  $olddir"
# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks
# split by space
for pair in $destinations; do
    # split by colon
    IFS=':' read -r src dst <<< $pair
    echo "Moving $dst to $olddir"
    # here we use `eval` because `dst` could be in the form of ~/somefilename
    # there could not be one to move
    eval mv $dst $olddir/ || true
    echo "Creating directory $(dirname $dst) (if not already)"
    eval mkdir -p  $(dirname $dst)
    echo "Creating symlink $dst -> $dir/$src."
    eval ln -s $dir/$src $dst
done
###############################################################################



##########################  INSTALL VIM PLUGINS ###############################
vim +PluginInstall +qall now
###############################################################################


############################  GIT COMPLETION BASH #############################
URL=https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
# do not change place of git-completion.bash - it has links in bahrc file
wget $URL -O ~/.git-completion.bash
###############################################################################

