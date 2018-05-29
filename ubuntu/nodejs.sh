#!/bin/sh
if test ! "$(which nodejs)"
then
	curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
	sudo apt-get install -y build-essential
	sudo apt-get install -y nodejs
else 
	echo "nodejs [installed]"
fi

# arch
# pacman -S nodejs npm
