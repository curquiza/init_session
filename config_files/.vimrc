" ------- VIM-PLUG -------

call plug#begin('~/.vim/plugged')

" Align part of code with = or ,
Plug 'junegunn/vim-easy-align'

" NERDTree
Plug 'scrooloose/nerdtree'

" Vim colorschemes
Plug 'flazz/vim-colorschemes'
" Hightlight syntax for multiple langages
Plug 'sheerun/vim-polyglot'

" Initialize plugin system
call plug#end()

" ------- PERSO -------

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

set relativenumber
set number
set colorcolumn=81

colorscheme Tomorrow-Night

inoremap return return<space>();<left><left>
inoremap ret0 return<space>(0);
inoremap ret1 return<space>(1);
inoremap ret-1 return<space>(-1);
inoremap ret; return<space>;
inoremap retnull return<space>(NULL);
inoremap /** /*<esc>o<esc>i**<return>*/<return><up><up><right><right><space>
inoremap (( ()<left>
inoremap ((; ();<left><left>
inoremap ((; ();<left><left>
inoremap [[ []<left>
inoremap "" ""<left>
inoremap '' ''<left>
inoremap {{ {<return>}<up><return>

" Select the current word
nnoremap <space> viw
" Delete the current word and pass in insert mode
nnoremap <space><space> viwd<esc>i
" Current word in uppercase
noremap <c-u> viwU
" Move the line up and down
nnoremap - dd<up><up>p
nnoremap + ddp
" Map switching of window with shift + arrow
nnoremap <silent> <S-Up> <c-w><up>
nnoremap <silent> <S-Down> <c-w><down>
nnoremap <silent> <S-Left> <c-w><left>
nnoremap <silent> <S-Right> <c-w><right>

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" remove automatically comment when new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Tabulation
set tabstop=4
set shiftwidth=4

" Open NERDTree when opening file
autocmd vimenter * NERDTree

" ------- VIMTUTOR ------

" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif


" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif
