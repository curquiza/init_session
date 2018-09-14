#!/bin/bash

CONFIG_DIR='config_files'

ALIAS_FILE=$CONFIG_DIR/aliases.txt
ENV_VAR_FILE=$CONFIG_DIR/aliases.txt

FISH_CONFIG=$HOME/.config/fish/config.fish
ZSH_CONFIG=$HOME/.zshrc
GIT_CONFIG=$HOME/.gitconfig

# creating Documents folder
echo "Creating Documents folder..."
mkdir -p $HOME/Documents/

# installing oh-my-zsh
#sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
# configuring zsh
echo "Configuring zsh..."
echo "\n# Aliases :" >> $ZSH_CONFIG
cat $ALIAS_FILE >> $ZSH_CONFIG
echo "\n# Env var :" >> $ZSH_CONFIG
cat $ENV_VAR_FILE >> $ZSH_CONFIG
source $ZSH_CONFIG

# brew
echo "Installing and updating brew..."
rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew
echo "\nBrew env var :" | tee $ZSH_CONFIG $FISH_CONFIG
echo 'export PATH=$HOME/.brew/bin:$PATH' >> $ZSH_CONFIG && source $ZSH_CONFIG
echo 'set -x PATH $HOME/.brew/bin:$PATH' >> $FISH_CONFIG && source $FISH_CONFIG
brew update

# installing fish shell and configuring
echo "Installing and configuring fish shell..."
brew install fish
# aliases
echo "\nAliases :" >> $FISH_CONFIG
cat $ALIAS_FILE >> $FISH_CONFIG
sed -i -e 's/=/ /g' $FISH_CONFIG
# env var
echo "\nEnv var :" >> $FISH_CONFIG
cat $ENV_VAR_FILE >> $FISH_CONFIG
sed -i -e 's/=/ /g' $FISH_CONFIG
sed -i -e 's/export/set -x/g' $FISH_CONFIG
# clean and run
rm -f "$FILE_FILE-e"
source $FISH_CONFIG

# vim
echo "Configuring vim..."
cp $CONFIG_DIR/.vimrc $HOME

# git
echo "Configuring git..."
cp $CONFIG_DIR/.gitconfig $HOME
git config --global user.name "curquiza"
git config --global user.email clementine.urquizar@gmail.com

# installing packages
echo "Installing other packages :"
#echo "docker machine..."
#brew install docker-machine
#echo "htop..."
#brew install htop
