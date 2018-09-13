#!/bin/bash

CONFIG_DIR='config_files'

# configuring zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
cat $CONFIG_DIR/.zshrc >> $HOME/.zshrc

# copying config files
cp $CONFIG_DIR/.vimrc $HOME
cp $CONFIG_DIR/.zshrc $HOME
cp $CONFIG_DIR/config.fish $HOME/.config/fish

# brew
rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew
echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc
echo 'env PATH=$HOME/.brew/bin:$PATH' >> $HOME/.config/fish/config.fish && source $HOME/.config/fish/config.fish
brew update

# installing packages
brew install fish
brew install docker-machine
brew install htop
