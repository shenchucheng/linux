#!/usr/bin/sh
sudo apt install build-essential cmake python3-dev python3-pip
pip3 install requests
git clone https://github.com/VundleVim/Vundle.vim.git   ~/.vim/bundle/Vundle.vim
git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
cd ~/.vim/bundle/YouCompleteMe
git submodule update --init --recursive
./install.py --all
vim -c PluginInstall

