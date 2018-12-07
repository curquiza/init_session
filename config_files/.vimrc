" ---- PLUG-IN -----------------------------------------------------------------
" Plug-in manager : Vim-Plug

call plug#begin('~/.vim/plugged')

" NERDTree
Plug 'scrooloose/nerdtree'

" FuzzyFinder
Plug 'junegunn/fzf'

" Vim colorschemes
Plug 'flazz/vim-colorschemes'
" Hightlight and indent syntax for multiple langages
Plug 'sheerun/vim-polyglot'

" Status bar (bottom)
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Current branch on status bar
Plug 'tpope/vim-fugitive'
" Side bar git (+/-/~)
Plug 'airblade/vim-gitgutter'

" Easy comment
Plug 'scrooloose/nerdcommenter'

" Multiple cursor (/!\ freezes sometimes)
Plug 'terryma/vim-multiple-cursors'

" Buffers
Plug 'ap/vim-buftabline'
Plug 'corntrace/bufexplorer'

" Easy surround
"Plug 'tpope/vim-surround'

" Align part of code with = or ,
"Plug 'junegunn/vim-easy-align'

" YCM : Autocompletion
" 1) Vim should be compiled with python3 (reinstall and link vim)
" 2) git submodule update --init --recursive in the YouCompleteMe repo
" 3) Then install all packages needed for each file extansion (c.f doc of YCM)
"    ex : ./install.py --clang-completer (for C and C++)
" 4) fill flag manually
"    ex : def Settings( **kwargs ):
"             return { 'flags': [ '-x', 'c++', '-Wall', '-Wextra', '-Werror' ] }
"    doc : https://github.com/Valloric/YouCompleteMe#option-2-provide-the-flags-manually
"Plug 'Valloric/YouCompleteMe'

" Tabnine : Autocompletion with machine learning
" type TabNine::sem/TabNine:no_sem to enable/disable semantic completion
" For semantic in C : follow the end of this doc (https://tabnine.com/semantic) -> use ccls instead of cquery
"Plug 'zxqfl/tabnine-vim'

" ALE : Asynchronous Lint Engine
Plug 'w0rp/ale'

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

" FZF ignores files in gitignore
"let $FZF_DEFAULT_COMMAND="git ls-tree -r --name-only HEAD || $FZF_INITIAL_COMMAND"

" YCM
" always load config file
"let g:ycm_confirm_extra_conf = 0
" path of config file
"let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

" TabNine
set rtp+=~/tabnine-vim

" ALE
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
"let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_c_parse_makefile = 1

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
"nnoremap <space> viw
" Delete the current word and pass in insert mode
nnoremap <space><space> ciw
" Current word in uppercase
"noremap <c-u> viwU
" Move the line up and down
"nnoremap - dd<up><up>p
"nnoremap + ddp

" Easy escape
inoremap jj <esc>

" Map switching of window with shift + arrow
nnoremap <silent> <S-Up> <c-w><up>
nnoremap <silent> <S-Down> <c-w><down>
nnoremap <silent> <S-Left> <c-w><left>
nnoremap <silent> <S-Right> <c-w><right>

" NERDTree open/close
nnoremap <C-O> :NERDTreeToggle<CR>

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch off highlight searching
nnoremap <silent> <C-H> :nohlsearch <CR>

" FuzzyFinder
nnoremap <leader>FF :FZF<space>
nnoremap <leader>ff :FZF<CR>
nnoremap <leader>fd :FZF ~/Documents<CR>

" Move between buffers
nnoremap <C-J> :bprev<CR>
nnoremap <C-K> :bnext<CR>

" Resize window
nnoremap ˘ <C-w>> "Alt + >
nnoremap ¯ <C-w>< "Alt + <
