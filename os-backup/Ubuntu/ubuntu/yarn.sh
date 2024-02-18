#!/bin/sh
if test ! "$(which yarn)"
then
	curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
     	echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
	sudo apt-get update && sudo apt-get install yarn
else 
	echo "yarn [installed]"
fi

