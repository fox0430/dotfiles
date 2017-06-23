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
set expandtab
set shiftwidth=4
set incsearch
set ignorecase
set smartcase
set clipboard=unnamed


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
call dein#add('Shougo/neocomplcache.vim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('w0ng/vim-hybrid')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes') 
call dein#add('thinca/vim-quickrun')
call dein#add('Yggdroot/indentLine')
call dein#add('zah/nim.vim')
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
call dein#add('davidhalter/jedi-vim')
call dein#add('andviro/flake8-vim')
call dein#add('hynek/vim-python-pep8-indent')
call dein#add('cohama/lexima.vim')


"Airline
set laststatus=2
set t_Co=256 
let g:airline_theme='papercolor'

"hybrid
let g:hybrid_custom_term_colors = 1
colorscheme hybrid
syntax on

"jedi
autocmd FileType python setlocal completeopt-=preview
let g:jedi#rename_command = "<leader>R" 

" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
"imap <expr><TAB>
" \ pumvisible() ? "\<C-n>" :
" \ neosnippet#expandable_or_jumpable() ?
" \    "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

