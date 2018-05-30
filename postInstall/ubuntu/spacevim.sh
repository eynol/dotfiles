#!/bin/bash
if [ ! -e $HOME/.config ]
then 
  mkdir $HOME/.config
fi

curl -sLf https://spacevim.org/cn/install.sh | bash -s -- --install neovim
