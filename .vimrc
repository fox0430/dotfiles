"Standard Settings
set background=dark
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 
set fileformats=unix,dos,mac
set ambiwidth=double
set wildmode=longest:full,full
set cursorline
set noswapfile
set number
set autoindent
set tabstop=4
set incsearch
set ignorecase
set smartcase
inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>
inoremap [ []<ESC>i
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap ' ''<ESC>i
inoremap '<Enter> ''<Left><CR><ESC><S-o>
inoremap " ""<ESC>i
inoremap "<Enter> ""<Left><CR><ESC><S-o>
inoremap < <><ESC>i
inoremap <<Enter> <><Left><CR><ESC><S-o>


"dein
augroup PluginInstall
	autocmd!
	autocmd VimEnter * if dein#check_install() | call dein#install() | endif
augroup END

"plugin install dir
let s:plugin_dir = expand('~/.vim/')

" dein.vim install pass add runtaim
let s:dein_dir = s:plugin_dir . 'repos/github.com/Shougo/dein.vim'
execute 'set runtimepath+=' . s:dein_dir

" if nothing dein.vim, first  git clone
if !isdirectory(s:dein_dir)
	call mkdir(s:dein_dir, 'p')
    silent execute printf('!git clone %s %s','https://github.com/Shougo/dein.vim', s:dein_dir)
endif

"dein plugin settings
if dein#load_state(s:plugin_dir)
		call dein#begin(s:plugin_dir)
endif

" Plugin list
call dein#add('Shougo/dein.vim')
call dein#add('w0ng/vim-hybrid')
call dein#add('w0ng/ale')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes') 
call dein#add('thinca/vim-quickrun')
call dein#add('Yggdroot/indentLine')
call dein#add('zah/nim.vim')
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
call dein#add('scrooloose/syntastic')
call dein#add('Shougo/neocomplete.vim')
call dein#add('justmao945/vim-clang')
call dein#add('Shougo/neoinclude.vim')
call dein#add('lervag/vimtex')
call dein#add('zah/nim.vim')

"syntastic
let g:syntastic_check_on_open=0
let g:syntastic_check_on_wq=0

"Airline
set laststatus=2
set t_Co=256 
let g:airline_theme='papercolor'

"hybrid
let g:hybrid_custom_term_colors = 1
colorscheme hybrid
syntax on


" 'Shougo/neocomplete.vim' {{{
let g:neocomplete#enable_at_startup = 1
if !exists('g:neocomplete#force_omni_input_patterns')
	let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
"""}}}

" disable auto completion for vim-clanG
let g:clang_auto = 0
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1

" default 'longest' can not work with neocomplete
let g:clang_c_completeopt   = 'menuone'
let g:clang_cpp_completeopt = 'menuone'

if executable('clang-3.6')
	let g:clang_exec = 'clang-3.6'
elseif executable('clang-3.5')
	let g:clang_exec = 'clang-3.5'
elseif executable('clang-3.4')
	let g:clang_exec = 'clang-3.4'
else
	let g:clang_exec = 'clang'
endif

if executable('clang-format-3.6')
	let g:clang_format_exec = 'clang-format-3.6'
elseif executable('clang-format-3.5')
	let g:clang_format_exec = 'clang-format-3.5'
elseif executable('clang-format-3.4')
	let g:clang_format_exec = 'clang-format-3.4'
else
	let g:clang_exec = 'clang-format'
endif

let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
