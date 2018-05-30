#!/bin/sh

# config

text_done="nodejs & npm [installed]"
prefix=$HOME/.npm-global
bash_profile=$HOME/.bash_profile

# Begin
if [ ! $(which nodejs) ] && [ ! $(which npm) ]
then
	curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
	sudo apt-get install -y build-essential
	sudo apt-get install -y nodejs npm
  if [ $(ls $NPM_CONFIG_PREFIX) ];then
    echo  $text_done
  elif [ -e $bash_profile ] && [ $( cat $bash_profile|grep "NPM_CONFIG_PREFIX" ) ] ;then
    source $bash_profile
  else
    echo "export NPM_CONFIG_PREFIX=${prefix}">>$bash_profile
    source $bash_profile
  fi
  if [ $? ];then
    echo $text_done
  fi
else
	echo $text_done
fi


# arch
# pacman -S nodejs npm
