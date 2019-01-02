#!/bin/bash

nvim_config_path="$HOME/.config/nvim"

cp $nvim_config_path/init.vim $nvim_config_path/init.vim_old
cp config_files/init.vim $HOME
echo 'config_files/init.vim -> ~/.config/nvim/init.vim'
