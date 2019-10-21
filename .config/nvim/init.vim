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
set tabstop=2
set expandtab
set shiftwidth=2
set incsearch
set ignorecase
set smartcase
set clipboard=unnamed
set belloff=all
set spelllang=en,cjk
syntax enable

"Window keybind
nnoremap <C-k> <C-w>l
nnoremap <C-j> <C-w>h

"Search highlight
:set hlsearch
nmap <silent> <Esc><Esc> :nohlsearch<CR>

augroup PluginInstall
    autocmd!
    autocmd VimEnter * if dein#check_install() | call dein#install() | endif
augroup END
command! -nargs=0 PluginUpdate call dein#update()

let s:dein_dir = expand('~/.config/nvim/dein')

if &runtimepath !~# '/dein.vim'
    let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo.dein.vim'

    if !isdirectory(s:dein_repo_dir)
        execute printf('!git clone %s %s', 'https://github.com/Shougo/dein.vim', s:dein_repo_dir)
    endif

    execute 'set runtimepath^=' . s:dein_repo_dir
endif

let g:dein#install_pax_processed = 48

let s:toml_file = '~/.config/nvim/dein.toml'
"let s:toml_lazy_file = '~/.config/nvim/dein_lazy.toml'
if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    call dein#load_toml(s:toml_file, {'lazy': 0})
    "call dein#load_toml(s:toml_lazy_file, {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on

"vim-gitgutter
set updatetime=250

"color
"let g:solarized_contrast="high"
"let g:solarized_termcolors=256
colorscheme atom-dark-256

highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none

"YCM
let g:ycm_server_python_interpreter = '/usr/bin/python'

"comfortable-motion.vim
let g:comfortable_motion_scroll_down_key = "j"
let g:comfortable_motion_scroll_up_key = "k"
