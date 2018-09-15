#!/bin/bash

GREEN='\033[0;32m'
DEF='\033[0;0m'

CONFIG_DIR='config_files'

ALIAS_FILE=$CONFIG_DIR/aliases.txt
ENV_VAR_FILE=$CONFIG_DIR/env_var.txt

FISH_CONFIG=$HOME/.config/fish/config.fish
ZSH_CONFIG=$HOME/.zshrc
GIT_CONFIG=$HOME/.gitconfig

function put_title() { printf "%-40s" "$1"; }

function put_subtitle() { printf "%5s%-35s" "> " "$1"; }

function put_done() { printf "$GREEN%s$DEF\n" '✔'; }

rm -f trace.txt

## creating folders
echo 'Usefull folders :'
put_subtitle 'Creating ~/Documents' &&  mkdir -p $HOME/Documents/ && put_done
put_subtitle 'Creating ~/.config' && mkdir -p $HOME/.config && put_done

## installing oh-my-zsh
echo "Zsh :"
#put_subtitle 'Installing oh-my-zsh' && sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && put_done

## configuring zsh
put_subtitle 'Configuring'
echo "\n# Aliases :" >> $ZSH_CONFIG
cat $ALIAS_FILE >> $ZSH_CONFIG
echo "\n# Env var :" >> $ZSH_CONFIG
cat $ENV_VAR_FILE >> $ZSH_CONFIG
source $ZSH_CONFIG
put_done

## vim
put_title 'Configuring vim'
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cp $CONFIG_DIR/.vimrc $HOME
put_done

## git
put_title 'Configuring git'
cp $CONFIG_DIR/.gitconfig $HOME
git config --global user.name "curquiza"
git config --global user.email clementine.urquizar@gmail.com
put_done

## brew
echo "Brew :"
put_subtitle 'Installing'
rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew >> trace.txt 2>&1
echo "\n# Brew env var :" >> $ZSH_CONFIG
echo "\n# Brew env var :" >> $FISH_CONFIG
echo 'export PATH=$HOME/.brew/bin:$PATH' >> $ZSH_CONFIG && source $ZSH_CONFIG
echo 'set -x PATH $HOME/.brew/bin:$PATH' >> $FISH_CONFIG
put_done
put_subtitle 'Updating'
brew update >> trace.txt 2>&1
put_done

## installing packages
echo "Installing other packages :"
put_subtitle 'docker-machine'
#brew install docker-machine
put_done
put_subtitle 'htop'
#brew install htop
put_done

## installing fish shell
echo "Fish shell :"
put_subtitle 'Installing'
#brew install fish >> trace.txt 2>&1
put_done

## configuring fish shell
# aliases
put_subtitle 'Configuring'
mkdir -p $HOME/.config/fish
echo "\n# Aliases :" >> $FISH_CONFIG
cat $ALIAS_FILE >> $FISH_CONFIG
sed -i -e 's/=/ /g' $FISH_CONFIG
# env var
echo "\n# Env var :" >> $FISH_CONFIG
cat $ENV_VAR_FILE >> $FISH_CONFIG
sed -i -e 's/=/ /g' $FISH_CONFIG
sed -i -e 's/export/set -x/g' $FISH_CONFIG
# clean
rm -f "$FISH_CONFIG""-e"
put_done
