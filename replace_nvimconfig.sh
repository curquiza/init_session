#!/bin/bash

cp $HOME/.config/nvim/init.vim $HOME/.config./nvim/init.vim_old
cp config_files/init.vim $HOME
echo 'config_files/init.vim -> ~/.config/nvim/init.vim'
