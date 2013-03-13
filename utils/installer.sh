#!/bin/sh

if [ -d $HOME/.vim ]
then
    cd ~/.vim ; git pull    
else
    cd ~ ; git clone https://andrzejsliwa@bitbucket.org/andrzejsliwa/vimfiles.git ~/.vim; ln -s $HOME/.vim/vimrc $HOME/.vimrc ; cd - 
fi
