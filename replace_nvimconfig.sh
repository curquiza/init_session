#!/bin/bash

nvim_config_path="$HOME/.config/nvim"

if [[ -f "$nvim_config_path/init.vim" ]]; then
    cp $nvim_config_path/init.vim $nvim_config_path/init.vim_old
fi
cp config_files/init.vim $nvim_config_path/
echo 'config_files/init.vim -> ~/.config/nvim/init.vim'
