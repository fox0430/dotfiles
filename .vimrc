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
"set clipboard& clipboard^=unnamedplus
set clipboard=unnamed,autoselect
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

" Plugin manager
call dein#add('Shougo/dein.vim')
" LSP client
call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})

" Color scheme
call dein#add('w0ng/vim-hybrid')
call dein#add('jonathanfilip/vim-lucius')
call dein#add('altercation/vim-colors-solarized')
call dein#add('crater2150/vim-theme-chroma')
call dein#add('raphamorim/lucario')

" Status line
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')

call dein#add('gorodinskiy/vim-coloresque')

" Quickrun
call dein#add('thinca/vim-quickrun')

"Indentatio line
"call dein#add('Yggdroot/indentLine')

" Auto close paren
call dein#add('cohama/lexima.vim')

" Syntax checker
"call dein#add('w0rp/ale')
"
" Paren highlighting
call dein#add('luochen1990/rainbow')

" Scroll motion
call dein#add('yuttie/comfortable-motion.vim')

" git
call dein#add('tpope/vim-fugitive')
call dein#add('airblade/vim-gitgutter')

" Highlighting current word
call dein#add('RRethy/vim-illuminate')

" JavaScript
call dein#add('othree/yajs.vim')
" Nim
call dein#add('zah/nim.vim')

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

"comfortable-motion.vim
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"
