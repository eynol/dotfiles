#!/bin/bash

echo "Please select config names to install"
select name in "nvim" "zsh" "tmux" "ranger"
do
    case $name in
        "nvim")
            ln -v -f -s $PWD/nvim $HOME/.config/nvim
            break
            ;;
        "zsh")
            echo "no"
            break
            ;;
        "tmux")
            echo "no"
            break
            ;;
        "ranger")
            echo "no"
            break
            ;;
        *)
            echo "Incorrect choice, exit"
    esac
done
