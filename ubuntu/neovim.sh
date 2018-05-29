#!/bin/bash
if test ! "$(which nvim)"
then
	sudo apt-get install software-properties-common -y
	sudo add-apt-repository ppa:neovim-ppa/stable -y
	sudo apt-get update
	sudo apt-get install neovim -y
	sudo apt-get install python-dev python-pip python3-dev python3-pip -y
else 
	echo "neovim [installed]"
fi
