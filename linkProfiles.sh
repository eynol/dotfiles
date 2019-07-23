#!/bin/bash
os=$(uname -s)

case $os in
"Darwin")
    mkdir -p $HOME/bin
    for file in $(ls ./mac/bin/); do
        [ -e $HOME/bin/$file ] && rm $HOME/bin/$file
        ln -v ./mac/bin/$file $HOME/bin/$file
    done
    ;;
"Linux")
    mkdir -p ~/bin
    echo "234"
    ;;
esac

if [ ~/.bash_profile ] 
