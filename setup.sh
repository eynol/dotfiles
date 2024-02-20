#!/bin/bash

echo "Please select config names to install"

DIR_NAME=$(cd $(dirname $0);pwd)

NVIM_PATH=$HOME/.config/nvim


select name in $(ls $DIR_NAME/.nvim-profiles)
do

    ln -vsnf $DIR_NAME/.nvim-profiles/$name $NVIM_PATH
    break
    
done
