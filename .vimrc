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
call dein#add('Shougo/neocomplete.vim')
"call dein#add('w0ng/vim-hybrid')
call dein#add('jonathanfilip/vim-lucius')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes') 
call dein#add('gorodinskiy/vim-coloresque') 
call dein#add('thinca/vim-quickrun')
call dein#add('Yggdroot/indentLine')
call dein#add('zah/nim.vim')
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
call dein#add('davidhalter/jedi-vim')
call dein#add('andviro/flake8-vim')
call dein#add('hynek/vim-python-pep8-indent')
call dein#add('vim-syntastic/syntastic')
call dein#add('cohama/lexima.vim')
call dein#add('justmao945/vim-clang')


"Airline
set laststatus=2
set t_Co=256 
let g:airline_theme='papercolor'


"color
syntax on
colorscheme lucius

highlight Normal ctermbg=none
highlight NonText ctermbg=none
highlight LineNr ctermbg=none
highlight Folded ctermbg=none
highlight EndOfBuffer ctermbg=none

"syntastic
let g:syntastic_mode_map = { 'mode': 'active',
  \ 'passive_filetypes': ['python'] }


"jedi
autocmd FileType python setlocal completeopt-=preview
let g:jedi#rename_command = "<leader>R" 

autocmd FileType python setlocal omnifunc=jedi#completions
let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0

if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif

let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'


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


" 'Shougo/neocomplete.vim' {{{
let g:neocomplete#enable_at_startup = 1

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_overwrite_completefunc = 1
let g:neocomplete#force_omni_input_patterns.c =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
let g:neocomplete#force_omni_input_patterns.cpp =
      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

" }}}
"


"vim-clang config
function! s:get_latest_clang(search_path)
    let l:filelist = split(globpath(a:search_path, 'clang-*'), '\n')
    let l:clang_exec_list = []
    for l:file in l:filelist
        if l:file =~ '^.*clang-\d\.\d$'
            call add(l:clang_exec_list, l:file)
        endif
    endfor
    if len(l:clang_exec_list)
        return reverse(l:clang_exec_list)[0]
    else
        return 'clang'
    endif
endfunction

function! s:get_latest_clang_format(search_path)
    let l:filelist = split(globpath(a:search_path, 'clang-format-*'), '\n')
    let l:clang_exec_list = []
    for l:file in l:filelist
        if l:file =~ '^.*clang-format-\d\.\d$'
            call add(l:clang_exec_list, l:file)
        endif
    endfor
    if len(l:clang_exec_list)
        return reverse(l:clang_exec_list)[0]
    else
        return 'clang-format'
    endif
endfunction

let g:clang_exec = s:get_latest_clang('/usr/bin')
let g:clang_format_exec = s:get_latest_clang_format('/usr/bin')

let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
