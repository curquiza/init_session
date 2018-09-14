#!/bin/bash

CONFIG_DIR='config_files'
FISH_FILE=$HOME/.config/fish/config.fish
ZSH_FILE=$HOME/.zshrc
ALIAS_FILE=$CONFIG_DIR/aliases.txt

# creating Documents folder
mkdir -p $HOME/Documents/

# installing oh-my-zsh and configuring zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
echo "\nAliases :" >> $ZSH_FILE
cat $ALIAS_FILE >> $ZSH_FILE && source $ZSH_FILE

# configuring fish shell
echo "\nAliases :" >> $FISH_FILE
cat $ALIAS_FILE >> $FISH_FILE
sed -i -e 's/=/ /g' $FILE_FILE
rm -f "$FILE_FILE-e"
source $FISH_FILE

# configuring vim
cp $CONFIG_DIR/.vimrc $HOME

# brew
rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew
echo "\nBrew env var :" | tee $ZSH_FILE $FISH_FILE
echo 'export PATH=$HOME/.brew/bin:$PATH' >> $ZSH_FILE && source $ZSH_FILE
echo 'env PATH=$HOME/.brew/bin:$PATH' >> $FISH_FILE && source $FISH_FILE
brew update

# installing packages
brew install fish
brew install docker-machine
brew install htop
