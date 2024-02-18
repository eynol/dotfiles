#!/bin/bash
if [ ! $(which git) ]
then
	sudo apt install git
else
	echo "git [installed]"
fi
git config --global user.name "Tao Kai"
git config --global user.email "625608852@qq.com"
git config --global push.default simple
