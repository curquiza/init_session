#!/bin/bash

GREEN='\033[0;32m'
DEF='\033[0;0m'

CONFIG_DIR='config_files'

ALIAS_FILE=$CONFIG_DIR/aliases.txt
ENV_VAR_FILE=$CONFIG_DIR/env_var.txt

FISH_CONFIG=$HOME/.config/fish/config.fish
ZSH_CONFIG=$HOME/.zshrc
GIT_CONFIG=$HOME/.gitconfig

# creating folders
printf "Creating usefull folders... "
mkdir -p $HOME/Documents/
mkdir -p $HOME/.config
mkdir -p $HOME/.config/fish
echo "$GREEN""OK$DEF"

# installing oh-my-zsh
#sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# configuring zsh
printf "Configuring zsh... "
echo "\n# Aliases :" >> $ZSH_CONFIG
cat $ALIAS_FILE >> $ZSH_CONFIG
echo "\n# Env var :" >> $ZSH_CONFIG
cat $ENV_VAR_FILE >> $ZSH_CONFIG
source $ZSH_CONFIG
echo "$GREEN""OK$DEF"

# vim
printf "Configuring vim... "
cp $CONFIG_DIR/.vimrc $HOME
echo "$GREEN""OK$DEF"

# git
printf "Configuring git... "
cp $CONFIG_DIR/.gitconfig $HOME
git config --global user.name "curquiza"
git config --global user.email clementine.urquizar@gmail.com
echo "$GREEN""OK$DEF"

# brew
printf "Installing and updating brew... "
rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew >> trace.txt 2>&1

echo "\n# Brew env var :" >> $ZSH_CONFIG
echo "\n# Brew env var :" >> $FISH_CONFIG
echo 'export PATH=$HOME/.brew/bin:$PATH' >> $ZSH_CONFIG && source $ZSH_CONFIG
echo 'set -x PATH $HOME/.brew/bin:$PATH' >> $FISH_CONFIG
brew update >> trace.txt 2>&1
echo "$GREEN""OK$DEF"

# installing packages
#echo "Installing other packages :"
#echo "docker machine..."
#brew install docker-machine
#echo "htop..."
#brew install htop

# installing fish shell
printf "Installing fish shell... "
brew install fish >> trace.txt 2>&1
echo "$GREEN""OK$DEF"

# configuring fish shell
# aliases
printf "Configuring fish shell... "
echo "\n# Aliases :" >> $FISH_CONFIG
cat $ALIAS_FILE >> $FISH_CONFIG
sed -i -e 's/=/ /g' $FISH_CONFIG
# env var
echo "\n# Env var :" >> $FISH_CONFIG
cat $ENV_VAR_FILE >> $FISH_CONFIG
sed -i -e 's/=/ /g' $FISH_CONFIG
sed -i -e 's/export/set -x/g' $FISH_CONFIG
# clean
rm -f "$FISH_FILE\-e"
echo "$GREEN""OK$DEF"
