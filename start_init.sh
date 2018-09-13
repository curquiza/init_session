#!/bin/bash

# copying config files
cp config_files/.vimrc $HOME
cp config_files/.zshrc $HOME
cp config_files/config.fish $HOME/.config/fish

# brew
rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew
echo 'export PATH=$HOME/.brew/bin:$PATH' >> $HOME/.zshrc && source $HOME/.zshrc
echo 'env PATH=$HOME/.brew/bin:$PATH' >> $HOME/.config/fish/config.fish && source $HOME/.config/fish/config.fish
brew update

# installing packages
brew install fish
brew install docker-machine
brew install htop
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
