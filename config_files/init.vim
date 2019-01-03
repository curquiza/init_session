" ------------------------------------------------------------------------------
" ---- VIM-PLUG ----------------------------------------------------------------
" ------------------------------------------------------------------------------

" Plug-in manager : Vim-Plug

call plug#begin('~/.vim/plugged')

" NERDTree
Plug 'scrooloose/nerdtree'

" FuzzyFinder
Plug 'junegunn/fzf'

" Status bar (bottom)
Plug 'itchyny/lightline.vim'
" Vim colorschemes
Plug 'drewtempelmeyer/palenight.vim'
" Hightlight and indent syntax for multiple langages
Plug 'sheerun/vim-polyglot'

" Current branch on status bar
Plug 'tpope/vim-fugitive'
" Side bar git (+/-/~)
Plug 'airblade/vim-gitgutter'

" Easy comment (and manage multiple filetype in one file like Vue files)
"Plug 'scrooloose/nerdcommenter'
Plug 'tomtom/tcomment_vim'

" Multiple cursor (/!\ not stable)
"Plug 'terryma/vim-multiple-cursors'

" Buffers
Plug 'ap/vim-buftabline'
Plug 'corntrace/bufexplorer'

" HTML tag matching
Plug 'gregsexton/MatchTag'

" Easy surround
"Plug 'tpope/vim-surround'

" ALE : Asynchronous Lint Engine
Plug 'w0rp/ale'

" Initialize plugin system
call plug#end()


" ------------------------------------------------------------------------------
" ---- SETTINGS ----------------------------------------------------------------
" ------------------------------------------------------------------------------

set nocompatible                      " use Vim rathen than Vi settings
set ruler                             " show the cursor position all the time
set mouse=a
set relativenumber
set number
set showcmd                           " display incomplete commands
set wildmenu                          " completion when typing command
set history=100
autocmd FileType c set colorcolumn=81 " highlight column for 42 project in C
set hlsearch
set backspace=indent,eol,start        " allow backspacing over everything in insert mode

" Consider .h files as c filetype
autocmd BufNewFile,BufRead *.h set ft=c

" Indent
set expandtab
set tabstop=4
set shiftwidth=4
autocmd FileType vim        setlocal expandtab shiftwidth=2 softtabstop=2          " vim
autocmd FileType c          setlocal noexpandtab shiftwidth=4 tabstop=4            " c
autocmd FileType ocaml      setlocal expandtab shiftwidth=2 tabstop=2 textwidth=0  " ocaml
autocmd FileType vue        setlocal expandtab shiftwidth=2 softtabstop=2          " vuejs
autocmd FileType javascript setlocal expandtab shiftwidth=2 softtabstop=2          " js
autocmd FileType html       setlocal expandtab shiftwidth=2 softtabstop=2          " vim

" Invisible chars
set showbreak=↪
set listchars=tab:+-,trail:~
set list

" When editing a file, always jump to the last known cursor position.
autocmd BufReadPost *
  \ if line("'\"") > 1 && line("'\"") <= line("$") |
  \   exe "normal! g`\"" |
  \ endif

" Remove automatically comment char when new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o


" ------------------------------------------------------------------------------
" ---- MAPPING -----------------------------------------------------------------
" ------------------------------------------------------------------------------

" Easy escape
inoremap jj <esc>

" Basic shortcuts
inoremap ret; return<space>();<left><left>
inoremap (( ()<left>
inoremap ((; ();<left><left>
inoremap [[ []<left>
inoremap "" ""<left>
inoremap '' ''<left>
inoremap {{ {}<left>
inoremap <leader>{{ {}<left><return><up><esc>o
autocmd FileType c inoremap /** /*<esc>o<esc>i**<return>*/<return><up><up><right><right><space>

" Insert newline in normal mode
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" Map switching of window with shift + arrow
nnoremap <silent> <S-Up> <c-w><up>
nnoremap <silent> <S-Down> <c-w><down>
nnoremap <silent> <S-Left> <c-w><left>
nnoremap <silent> <S-Right> <c-w><right>

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch off highlight searching
nnoremap <silent> <C-H> :nohlsearch <CR>

" Move between buffers
nnoremap <C-J> :bprev<CR>
nnoremap <C-K> :bnext<CR>

" Resize window
nnoremap ˘ <C-w>> "Alt + >
nnoremap ¯ <C-w>< "Alt + <

" Copy and paste from clipboard
" Alt + c
vnoremap ç "*y
" Alt + v
noremap √ "*p


" ------------------------------------------------------------------------------
" ---- PLUGGINS CONFIGURATION --------------------------------------------------
" ------------------------------------------------------------------------------

" == NERDTree ==================================================================

" open/close
nnoremap <C-O> :NERDTreeToggle<CR>

let NERDTreeShowHidden=1        " Show hidden files
let NERDTreeIgnore=['\.swp$']   " Ignore these files


" == Polyglot ==================================================================

" Vuejs highlight
autocmd BufRead,BufNewFile *.vue setlocal filetype=vue  " Use configuration/pluggin for Vue
autocmd FileType vue syntax sync fromstart              " avoid syntax highlight to stop randmonly
let g:vue_disable_pre_processors=1                      " avoid slow down


" == ALE =======================================================================

let g:ale_sign_column_always = 1  " always display gutter
let g:ale_c_parse_makefile = 1    " use makefile
" run linter only on save
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'


" == FuzzyFinder ===============================================================

nnoremap <leader>FF :FZF<space>
nnoremap <leader>ff :FZF<CR>

" ignores files in gitignore
let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git' " fd binary needs to be installed

" Hide status line
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

"set rtp+=/Users/curquiza/.brew/opt/fzf


" == Color schemes =============================================================

set background=dark
colorscheme palenight

" to have the good colors
if (has("termguicolors"))
  set termguicolors
endif

" == Lightline =================================================================

let g:lightline = { 'colorscheme': 'palenight' }

" == T Comment =================================================================

nnoremap <space><space> :: :TComment<CR>
vnoremap <space><space> :: :TComment<CR>
" to comment only a part in visual mode : <leader>__


" == Buffexplorer ==============================================================

nnoremap <leader>bx :BufExplorerHorizontalSplit<CR>
nnoremap <leader>bv :BufExplorerVerticalSplit<CR>
nnoremap <leader>bb :BufExplorer<CR>

" == BuffTabline ===============================================================

let g:buftabline_separators=1       " separator between buffors

" Custom highlight
hi link BufTabLineActive NONE
hi link BufTabLineCurrent PmenuSel

