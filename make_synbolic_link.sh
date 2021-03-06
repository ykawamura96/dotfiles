#!/bin/bash

DOT_FILES=(.bashrc .gitconfig)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

ln -s $HOME/dotfiles/init.el $HOME/.emacs.d/init.el
ln -s $HOME/dotfiles/rc.py $HOME/.percol.d/rc.py
