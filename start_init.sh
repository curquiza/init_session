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

function put_title() { printf "%s\n" "$1"; }
function put_subtitle() { printf "%5s%-35s" "> " "$1"; }
function put_done() { printf "$GREEN%s$DEF\n" '✔'; }
function quiet_cmd() {
	echo "COMMAND : $@" >> $TRACE_FILE
	$@ >> $TRACE_FILE 2>&1
}

rm -f "$TRACE_FILE"

printf "What kind of session do you want to initialize ?\n   1) 42\n   2) Personnal MacBook\n"
read -p "Your answer (1 or 2) : " answer
while [[ "$answer" != "1" ]] && [[ "$answer" != "2" ]]; do
    printf "Not a valid answer\n"
    read -p "Your answer (1 or 2) : " answer
done
if [[ "$answer" == "1" ]]; then
    session="42"
    printf "Let's start configuring your 42 session !\n"
else
    printf "Let's start configuring your personnal session !\n"
    session="Personnal"
fi
printf "\n"

## creating folders
put_title 'Usefull folders :'
put_subtitle 'Creating ~/Documents' &&  mkdir -p "$HOME/Documents" && put_done
put_subtitle 'Creating ~/.config' && mkdir -p "$HOME/.config" && put_done

## Zsh configuration
# installing oh-my-zsh
put_title "Zsh"
put_subtitle 'Installing oh-my-zsh' \
    && sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed 's:env zsh .*$::g' | sed 's:chsh -s .*$::g')" >> $TRACE_FILE 2>&1 \
    && put_done
# configuring zsh
put_subtitle 'Configuring' \
    && echo "\n# Aliases :" >> "$ZSH_CONFIG" \
    && cat "$ALIAS_FILE" >> "$ZSH_CONFIG" \
    && echo "\n# Env var :" >> "$ZSH_CONFIG" \
    && cat "$ENV_VAR_FILE" >> "$ZSH_CONFIG" \
    && put_done

## nvim
put_title 'Neovim'
put_subtitle 'Installing neovim' \
    && quiet_cmd "brew install neovim" \
    && put_done
put_subtitle 'Installing vim-plug' \
    && quiet_cmd "curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" \
    && put_done
put_subtitle 'Settings file' \
    && mkdir -p "$NVIM_CONFIG_PATH" \
    && cp "$CONFIG_DIR/init.vim" "$NVIM_CONFIG_PATH" \
    && put_done

## git
put_title 'Git'
put_subtitle 'Creating .gitconfig' \
    && cp "$CONFIG_DIR/.gitconfig" "$HOME" \
    && put_done

## brew
put_title "Brew"
# install
if [[ "$session" == "42" ]]; then
    put_subtitle 'Installing' \
        && rm -rf "$HOME/.brew && git clone --depth=1 https://github.com/Homebrew/brew" "$HOME/.brew" >> "$TRACE_FILE" 2>&1 \
        && echo "\n# Brew env var :\nexport PATH=$HOME/.brew/bin:$PATH" >> "$ZSH_CONFIG" \
        && mkdir -p "$HOME/.config/fish" \
        && echo "\n# Brew env var :\nset PATH $HOME/.brew/bin \$PATH" >> "$FISH_CONFIG" \
        && quiet_cmd "source $ZSH_CONFIG" \
        && put_done
fi
# update
put_subtitle 'Updating' && quiet_cmd 'brew update -y' && put_done

## installing packages
put_title "Packages installation"
if [[ "$session" == "42" ]]; then
    put_subtitle 'docker-machine' && quiet_cmd 'brew install docker-machine' && put_done
    put_subtitle 'docker' && quiet_cmd 'brew install docker' && put_done
fi
put_subtitle 'htop' && quiet_cmd 'brew install htop' && put_done
put_subtitle 'fd' && quiet_cmd 'brew install htop' && put_done

## Fish shell
## installing fish shell
put_title "Fish shell"
put_subtitle 'Installing' && quiet_cmd 'brew install fish' && put_done
## configuring fish shell
put_subtitle 'Creating config folder' \
    && mkdir -p "$HOME/.config/fish" \
    && mkdir -p "$HOME/.config/fish/functions" \
    && put_done
# custom prompt functions
put_subtitle 'Custom functions' \
    && cp "$CONFIG_DIR/functions/fish_prompt.fish" "$HOME/.config/fish/functions" \
    && cp "$CONFIG_DIR/functions/fish_right_prompt.fish" "$HOME/.config/fish/functions" \
    && put_done
# aliases
put_subtitle 'Aliases' \
    && echo "\n# Aliases :" >> "$FISH_CONFIG" \
    && cat $ALIAS_FILE >> "$FISH_CONFIG" \
    && sed -i -e 's/=/ /g' "$FISH_CONFIG" \
    && put_done
# env var
put_subtitle 'Env variables' \
    && echo "\n# Env var :" >> "$FISH_CONFIG" \
    && cat $ENV_VAR_FILE >> "$FISH_CONFIG" \
    && sed -i -e 's/=/ /g' "$FISH_CONFIG" \
    && sed -i -e 's/export/set -x/g' "$FISH_CONFIG" \
    && put_done
# clean
rm -f "$FISH_CONFIG""-e"
