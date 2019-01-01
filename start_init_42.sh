#!/bin/bash

GREEN='\033[0;32m'
DEF='\033[0;0m'

CONFIG_DIR='config_files'

ALIAS_FILE=$CONFIG_DIR/aliases.txt
ENV_VAR_FILE=$CONFIG_DIR/env_var.txt
TRACE_FILE=trace.txt

FISH_CONFIG=$HOME/.config/fish/config.fish
ZSH_CONFIG=$HOME/.zshrc

NVIM_CONFIG_PATH=$HOME/.config/nvim

function put_title() { printf "%-40s" "$1"; }
function put_subtitle() { printf "%5s%-35s" "> " "$1"; }
function put_done() { printf "$GREEN%s$DEF\n" '✔'; }
function quiet_cmd() {
	echo "COMMAND : $@" >> $TRACE_FILE
	$@ >> $TRACE_FILE 2>&1
}


rm -f $TRACE_FILE

## creating folders
echo 'Usefull folders :'
put_subtitle 'Creating ~/Documents' &&  mkdir -p "$HOME/Documents" && put_done
put_subtitle 'Creating ~/.config' && mkdir -p "$HOME/.config" && put_done

## installing oh-my-zsh
echo "Zsh :"
put_subtitle 'Installing oh-my-zsh'
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh .*$::g' | sed 's:chsh -s .*$::g')" >> $TRACE_FILE 2>&1
put_done

## configuring zsh
put_subtitle 'Configuring'
echo "\n# Aliases :" >> "$ZSH_CONFIG"
cat "$ALIAS_FILE" >> "$ZSH_CONFIG"
echo "\n# Env var :" >> "$ZSH_CONFIG"
cat "$ENV_VAR_FILE" >> "$ZSH_CONFIG"
put_done

## nvim
put_title 'Configuring neovim'
put_subtitle 'Installing neovim' \
    && quiet_cmd "brew install neovim" \
    && put_done
put_subtitle 'Installing vim-plug' \
    && quiet_cmd "curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" \
    && put_done
put_subtitle 'Settings file' \
    && mkdir -p "$NVIM_CONFIG_PATH" \
    && cp "$CONFIG_DIR/init.vim" "$NVIM_CONFIG_PATH" \
    && put_done

## git
put_title 'Configuring git' \
    && cp "$CONFIG_DIR/.gitconfig" "$HOME" \
    && put_done

## brew
put_title "Brew :"
# install
put_subtitle 'Installing'
rm -rf $HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew $HOME/.brew >> trace.txt 2>&1
echo "\n# Brew env var :\nexport PATH=$HOME/.brew/bin:$PATH" >> $ZSH_CONFIG
mkdir -p $HOME/.config/fish && echo "\n# Brew env var :\nset PATH $HOME/.brew/bin \$PATH" >> $FISH_CONFIG
quiet_cmd "source $ZSH_CONFIG"
put_done
# update
put_subtitle 'Updating' && quiet_cmd 'brew update -y' && put_done

## installing packages
echo "Installing other packages :"
put_subtitle 'docker-machine' && quiet_cmd 'brew install docker-machine' && put_done
put_subtitle 'docker' && quiet_cmd 'brew install docker' && put_done
put_subtitle 'htop' && quiet_cmd 'brew install htop' && put_done
put_subtitle 'fd' && quiet_cmd 'brew install htop' && put_done

## Fish shell
## installing fish shell
echo "Fish shell :"
put_subtitle 'Installing' && quiet_cmd 'brew install fish' && put_done
## configuring fish shell
put_subtitle 'Configuring'
mkdir -p "$HOME/.config/fish"
mkdir -p "$HOME/.config/fish/functions"
# custom prompt functions
cp "$CONFIG_DIR/functions/fish_prompt.fish" "$HOME/.config/fish/functions"
cp "$CONFIG_DIR/functions/fish_right_prompt.fish" "$HOME/.config/fish/functions"
# aliases
echo "\n# Aliases :" >> "$FISH_CONFIG"
cat $ALIAS_FILE >> "$FISH_CONFIG"
sed -i -e 's/=/ /g' "$FISH_CONFIG"
# env var
echo "\n# Env var :" >> "$FISH_CONFIG"
cat $ENV_VAR_FILE >> "$FISH_CONFIG"
sed -i -e 's/=/ /g' "$FISH_CONFIG"
sed -i -e 's/export/set -x/g' "$FISH_CONFIG"
# clean
rm -f "$FISH_CONFIG""-e"
p
