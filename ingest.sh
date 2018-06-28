#!/bin/sh

echo Ingesting Default config for BASH
cp -fr ~/.bash_profile .config/bash/
cp -fr ~/.bashrc       .config/bash/

echo Ingesting Default config for VIM
cp -fr ~/.vim   .config/vim/
cp -fr ~/.vimrc .config/vim/

echo Ingesting Default config for TMUX
cp -fr ~/.tmux* .config/tmux/
