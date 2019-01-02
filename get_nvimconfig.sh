#!/bin/bash

save_folder="z_save/"
nvim_config_path="$HOME/.config/nvim"

cp config_files/init.vim $save_folder/init.vim_old
cp $nvim_config_path/init.vim config_files
echo '~/.config/nvim/init.vim -> config_files/init.vim'
