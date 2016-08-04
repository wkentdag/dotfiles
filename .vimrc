syntax on
colorscheme tomorrow-night


set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Plugin 'elzr/vim-json'
Plugin 'digitaltoad/vim-pug'
Plugin 'vim-ruby/vim-ruby'

filetype plugin indent on


set smartindent
set expandtab
set tabstop=2
set encoding=utf-8 nobomb
set textwidth=72
set number
