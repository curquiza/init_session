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
Plug 'tomtom/tcomment_vim'

" Buffers
Plug 'ap/vim-buftabline'
Plug 'corntrace/bufexplorer'

" HTML tag matching
Plug 'gregsexton/MatchTag'

" ALE : Asynchronous Lint Engine
Plug 'w0rp/ale'

" Editorconfig
Plug 'editorconfig/editorconfig-vim'

" Underscore and camelcase words
Plug 'chaoren/vim-wordmotion'


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
inoremap <leader><< <><left>
inoremap <leader>{{ {}<left><return><up><esc>o
autocmd FileType c inoremap /** /*<esc>o<esc>i**<return>*/<return><up><up><right><right><space>

" Insert newline in normal mode
nnoremap <leader>o o<esc><up>
nnoremap <leader>O O<esc><down>

" Map switching of window with shift + arrow
nnoremap <silent> <S-Up> <c-w><up>
nnoremap <silent> <S-Down> <c-w><down>
nnoremap <silent> <S-Left> <c-w><left>
nnoremap <silent> <S-Right> <c-w><right>

" CTRL-U in insert mode deletes a lot. Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Switch off highlight searching
nnoremap <C-H> :nohlsearch <CR>

" Move between buffers
nnoremap <C-J> :bprev<CR>
nnoremap <C-K> :bnext<CR>

" Resize window
"Alt + >
nnoremap ˘ :vertical resize +1 <CR>
"Alt + <
nnoremap ¯ :vertical resize -1 <CR>
"Alt + +
nnoremap ± :resize +1 <CR>
"Alt + -
nnoremap – :resize -1 <CR>

" Copy and paste from clipboard
" Alt + c
vnoremap ç "*y
" Alt + v
nnoremap √ "*p


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
let g:ale_set_highlights = 0


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


" == Word Motion ===============================================================

" Use leader
let g:wordmotion_prefix = '<Leader>'

" Remove a subword in insert mode.
" Otherwise ci<leader>w will do it in normal mode
" Doesn't work with inoremaq because uses the Plugin's mappings
imap <leader><C-w> <esc>v<leader>bc


" ------------------------------------------------------------------------------
" ---- USEFULL SHORTCUTS IN VIM ------------------------------------------------
" ------------------------------------------------------------------------------

" * + cgn + write word + esc + dot : replace a word everywhere in the file
" <C-W> in insert mode : delete a word
" D in normal node : delete from the cursor to the end of the line
" S in normal mode = 0D
" gh in normal mode : actives select mode -> like selection in classic editor


" ------------------------------------------------------------------------------
" ---- 42 HEADER SCRIPT --------------------------------------------------------
" ------------------------------------------------------------------------------

" s:Name -> only local scripting functions
" to test a fonction (si not local) -> :put =GetFileName()

function s:GetMail()
	if ($MAIL == '')
		return 'marvin@42.fr'
	else
		return $MAIL
	endif
endfunction

function s:GetUser()
	if ($USER == '')
		return 'marvin'
	else
		return $USER
	endif
endfunction

function s:GetFileName()
	return expand('%:t')
endfunction

function s:GetCreationDate()
	""let time = system('stat -f "%B" ' . s:GetFileName())
	return strftime("%Y/%m/%d %H:%M:%S")
endfunction

function s:GetLastModifDate()
	""return strftime("%Y/%m/%d %H:%M:%S", getftime(s:GetFileName()))
	return strftime("%Y/%m/%d %H:%M:%S")
endfunction

function s:HeaderFileLine(filename)
	let line = "/*   "
	let line .= printf("%-41.41s", a:filename)
	let line .= "          :+:      :+:    :+:   */"
	return line
endfunction

function s:HeaderUserMailLine(user, mail)
	let mail = printf("<%.25s>", a:mail)
	let user_mail = printf("%.9s %-27.27s", a:user, mail)
	return printf("/*   By: %-37s      +#+  +:+       +#+        */", user_mail)
endfunction

function s:HeaderCreationDate(creation_date, user)
	return printf("/*   Created: %s by %-9.9s         #+#    #+#             */", a:creation_date, a:user)
endfunction

function s:HeaderUpdatedDate(last_modif_date, user)
	return printf("/*   Updated: %s by %-9.9s        ###   ########.fr       */", a:last_modif_date, a:user)
endfunction

function CheckLine(line1, line2)
	if a:line1 == a:line2
		return 0
	else
		return 1
	endif
endfunction

function CheckLength(line, l)
	if strlen(a:line) == a:l
		return 0
	else
		return 1
	endif
endfunction

function s:CheckHeader()
	let rslt = 0
	let rslt += CheckLine(getline(1), "/* ************************************************************************** */")
	let rslt += CheckLine(getline(2), "/*                                                                            */")
	let rslt += CheckLine(getline(3), "/*                                                        :::      ::::::::   */")
	let rslt += CheckLength(getline(4), 80)
	let rslt += CheckLine(getline(5), "/*                                                    +:+ +:+         +:+     */")
	let rslt += CheckLength(getline(6), 80)
	let rslt += CheckLine(getline(7), "/*                                                +#+#+#+#+#+   +#+           */")
	let rslt += CheckLength(getline(8), 80)
	let rslt += CheckLength(getline(9), 80)
	let rslt += CheckLine(getline(10), "/*                                                                            */")
	let rslt += CheckLine(getline(11), "/* ************************************************************************** */")
	return rslt
endfunction

function Insert42Header()
	let user             = s:GetUser()
	let mail             = s:GetMail()
	let filename        = s:GetFileName()
	let creation_date     = s:GetCreationDate()
	let last_modif_date = s:GetLastModifDate()

	if (s:CheckHeader() != 0)
		call append(0, "/* ************************************************************************** */")
		call append(1, "/*                                                                            */")
		call append(2, "/*                                                        :::      ::::::::   */")
		call append(3, s:HeaderFileLine(filename))
		call append(4, "/*                                                    +:+ +:+         +:+     */")
		call append(5, s:HeaderUserMailLine(user, mail))
		call append(6, "/*                                                +#+#+#+#+#+   +#+           */")
		call append(7, s:HeaderCreationDate(creation_date, user))
		call append(8, s:HeaderUpdatedDate(last_modif_date, user))
		call append(9, "/*                                                                            */")
		call append(10, "/* ************************************************************************** */")
		call append(11, "")
	endif
endfunction

function UpdateLastModifDate()

	if &mod != 0 " If the file was modified

		let user            = s:GetUser()
		let last_modif_date = strftime("%Y/%m/%d %H:%M:%S")

		let line_from_file = getline(9)
		let updated_line   = s:HeaderUpdatedDate(last_modif_date, user)
		let part_line_from_file = strpart(line_from_file, 0, 13)

		" If the header updated line is present AND  both lines aren't identical
		if (s:CheckHeader() == 0)
			call setline (9, updated_line)
		endif

	endif
endfunction


" Shortcut to add header
nnoremap <silent><C-c><C-h> :call Insert42Header()<CR>
" Update line of header (if necessary) when registering
autocmd BufWritePre * call UpdateLastModifDate ()
