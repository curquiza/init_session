" ---- PLUG-IN -----------------------------------------------------------------
" Plug-in manager : Vim-Plug

call plug#begin('~/.vim/plugged')

" Align part of code with = or ,
Plug 'junegunn/vim-easy-align'

" NERDTree
Plug 'scrooloose/nerdtree'

" Vim colorschemes
Plug 'flazz/vim-colorschemes'
" Hightlight syntax for multiple langages
Plug 'sheerun/vim-polyglot'

" Status bar (bottom)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Current branch on status bar
Plug 'tpope/vim-fugitive'
" Side bar git (+/-/~)
Plug 'airblade/vim-gitgutter'

" Initialize plugin system
call plug#end()


" ---- BASICS ------------------------------------------------------------------

set nocompatible	" use Vim rathen than Vi settings

set ruler			" show the cursor position all the time
set mouse=a

set relativenumber
set number
set showcmd			" display incomplete commands
set wildmenu		" completion when typing command
set history=100
set colorcolumn=81
set hlsearch

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Themes
colorscheme Tomorrow-Night
let g:airline_theme='bubblegum'

" remove automatically comment char when new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Indent
set tabstop=4
set shiftwidth=4
autocmd FileType ocaml setlocal shiftwidth=2 tabstop=2 textwidth=0 " ocaml

" Invisible chars
set showbreak=↪
set listchars=eol:.,tab:+-,trail:~
set list

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif


" ---- MAPPING -----------------------------------------------------------------

inoremap ret; return<space>();<left><left>
inoremap /** /*<esc>o<esc>i**<return>*/<return><up><up><right><right><space>
inoremap (( ()<left>
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

" NERDTree open/close
nnoremap <c-c> :NERDTreeToggle<CR>

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>
