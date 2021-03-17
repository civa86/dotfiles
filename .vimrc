filetype plugin indent on
syntax on
set encoding=utf-8
set hlsearch incsearch      " hightlight search and incremental search
set gdefault                " global replace by default
set nowrap                  " not wrap lines
set nu                      " show line numbers
set foldlevel=1             " default foldlevel 1 to see headings
set nobackup noswapfile     " stop backup and swap files
set nocompatible ignorecase smartcase
set nocindent noautoindent nosmartindent indentexpr= "disable autoindents
set tabstop=4 shiftwidth=4 expandtab "setup default tab/shift/expand
set showmode showcmd ttyfast
set guioptions=a            " hide scrollbars/menu/tabs
let mapleader = ","
let maplocalleader = ";"
set foldmethod=marker       " sets the fold method to {{{ }}} markers
set shortmess=atI           " disable welcome screen
set listchars=tab:\|\ ,trail:·,eol:¬
set nospell                 " disable

set t_Co=256
set t_ut=

call plug#begin()
  Plug 'rakr/vim-one'
  Plug 'preservim/nerdtree'
  Plug 'itchyny/lightline.vim'
call plug#end()

try
    colorscheme one
    set background=dark
catch /^Vim\%((\a\+)\)\=:E185/
    " deal with it
endtry

set laststatus=2

let g:lightline = {
      \ 'colorscheme': 'one dark'
      \ }
