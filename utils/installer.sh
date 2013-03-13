#!/bin/sh

if [ -d $HOME/.vim ]
then
    cd ~/.vim ; git pull    
else
    cd ~ ; git clone https://github.com/andrzejsliwa/vimfiles.git ~/.vim; ln -s $HOME/.vim/vimrc $HOME/.vimrc ; cd - 
fi
