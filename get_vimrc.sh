#!/bin/bash

cp config_files/.vimrc config_files/.vimrc_old 
cp $HOME/.vimrc config_files
echo '~/.vimrc -> config_files/.vimrc'
