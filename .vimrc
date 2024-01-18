" Copy & Paste
set clipboard=unnamed

" Visual
colorscheme slate
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

" Rendering
set ttyfast

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase
set showmatch
map <leader><space> :let @/=''<cr> " clear search

