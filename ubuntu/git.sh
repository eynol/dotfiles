#!/bin/bash
if test ! "$(which git)"
then
	sudo apt install git
else
	echo "git [installed]"
fi
