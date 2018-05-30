#!/bin/sh

if [ ! $(which ruby) ]
then 
  sudo install ruby -y
else 
  echo "Ruby[installed]"
fi
