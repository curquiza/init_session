#!/bin/bash

cp config_files/init.vim config_files/init.vim_old
cp $HOME/.config/nvim/init.vim config_files
echo '~/.config/nvim/init.vim -> config_files/init.vim'
