" System
set clipboard=unnamed
autocmd TextYankPost * if (v:event.operator == 'y' || v:event.operator == 'd') | silent! execute 'call system("wl-copy", @")' | endif
nnoremap p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
set title

" Visual
colorscheme lunaperche
syntax on
set number
set ruler
set visualbell
set encoding=utf-8
set showmode
set showcmd

" Formatting
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround

" Cursor
set scrolloff=3
set backspace=indent,eol,start
set matchpairs+=<:> 
runtime! macros/matchit.vim

" Move Lines
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Rendering
set ttyfast

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search
"
" set guicursor=n-v-c:block-Cursor,i-ci-ve:ver25-Cursor,r-cr-o:hor20-Cursor

