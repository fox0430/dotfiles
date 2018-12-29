"Standard Settings
set background=dark
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 
set fileformats=unix,dos,mac
set ambiwidth=double
set wildmode=longest:full,full
set cursorline
set noswapfile
set number
set autoindent
set tabstop=2
set expandtab
set shiftwidth=2
set incsearch
set ignorecase
set smartcase
set clipboard& clipboard^=unnamedplus
set belloff=all
set spelllang=en,cjk

"Window keybind

nnoremap <C-k> <C-w>l
nnoremap <C-j> <C-w>h

"Search highlight
:set hlsearch
nmap <silent> <Esc><Esc> :nohlsearch<CR>

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
"call dein#add('Shougo/neocomplcache.vim')
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

"call dein#add('Shougo/deoplete.nvim')
"if !has('nvim')
"  call dein#add('roxma/nvim-yarp')
"  call dein#add('roxma/vim-hug-neovim-rpc')
"endif
"let g:deoplete#enable_at_startup = 1

" Color scheme
call dein#add('w0ng/vim-hybrid')
call dein#add('jonathanfilip/vim-lucius')
call dein#add('altercation/vim-colors-solarized')
call dein#add('crater2150/vim-theme-chroma')
call dein#add('raphamorim/lucario')

call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes') 
call dein#add('gorodinskiy/vim-coloresque') 
call dein#add('thinca/vim-quickrun')
"call dein#add('Yggdroot/indentLine')
call dein#add('zah/nim.vim')
call dein#add('davidhalter/jedi-vim')
"call dein#add('andviro/flake8-vim')
"call dein#add('hynek/vim-python-pep8-indent')
call dein#add('cohama/lexima.vim')
"call dein#add('justmao945/vim-clang')
call dein#add('othree/yajs.vim')
call dein#add('w0rp/ale')
call dein#add('luochen1990/rainbow')
call dein#add('yuttie/comfortable-motion.vim')
call dein#add('chrisbra/csv.vim')
call dein#add('tpope/vim-fugitive')
call dein#add('airblade/vim-gitgutter')
call dein#add('lervag/vimtex')
call dein#add('RRethy/vim-illuminate')


"vim-gitgutter
set updatetime=250

"Airline
set laststatus=2
set t_Co=256 
let g:airline_theme='papercolor'

"color
syntax on
let g:solarized_contrast="high"
let g:solarized_termcolors=256
colorscheme lucius

highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none

"jedi
" autocmd FileType python setlocal completeopt-=preview
" let g:jedi#rename_command = "<leader>R" 
" 
" autocmd FileType python setlocal omnifunc=jedi#completions
" let g:jedi#completions_enabled = 0
" let g:jedi#auto_vim_configuration = 0
" 
" if !exists('g:neocomplete#force_omni_input_patterns')
"         let g:neocomplete#force_omni_input_patterns = {}
" endif
" 
" let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'


" Plugin key-mappings.
" <TAB>: completion.                                         
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"   
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>" 

" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
"if has('conceal') set conceallevel=2 concealcursor=i

" 'Shougo/neocomplete.vim' {{{
"let g:neocomplete#enable_at_startup = 1
"
"if !exists('g:neocomplete#force_omni_input_patterns')
"  let g:neocomplete#force_omni_input_patterns = {}
"endif
"let g:neocomplete#force_overwrite_completefunc = 1
"let g:neocomplete#force_omni_input_patterns.c =
"      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
"let g:neocomplete#force_omni_input_patterns.cpp =
"      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
"" }}}
"
"" neosnippet
"let g:neosnippet#enable_completed_snippet = 1

"YCM
let g:ycm_server_python_interpreter = '/usr/bin/python'


"comfortable-motion.vim
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"
