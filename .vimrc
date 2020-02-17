set nocompatible              " required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'


" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" paste模式
set pastetoggle=<F3>
set number
syntax on
set laststatus=2
" set splitbelow
" set splitright
set wildmenu
set mouse=

" split navigations
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" 折叠
nnoremap <space> za
" 目录树
map <F4> :NERDTreeToggle<CR>
"Python
set filetype=python
au BufNewFile,BufRead .py,.pyw setf python
set autoindent "设置自动缩进
set smartindent "自动下一行缩进
set textwidth=79 "行最大宽度
set expandtab "tab替换为空格键
set tabstop=4 "设置table长度
set softtabstop=4 "软制表符宽度为4
set shiftwidth=4 "设置缩进的空格数为4
set fileformat=unix "设置以unix的格式保存文件
set foldmethod=indent "自动折叠
set foldlevel=79 "最多79个字符

"vim中F5直接调试
map <F5> :call RunPython()<CR>
func! RunPython()
exec "w"
if &filetype == 'python' "第一行#!/bin/python 运行python编译器
exec "!time python %"
elseif &filetype == 'sh' "第一行#!/bin/bash 运行shell编译器
:!time bash %
endif
endfunc

