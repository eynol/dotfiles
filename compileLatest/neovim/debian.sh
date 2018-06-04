#!/bin/sh

version=$1

sudo -v

if [ ! -d $HOME/repos ] 
then
	echo "Create repo folders"
	mkdir $HOME/repos
fi

sudo apt-get install ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip

# clone repo
cd $HOME/repos
if [ ! -d $HOME/repos/neovim ]
then
	git clone -b v0.2.2 https://github.com/neovim/neovim.git --depth=1
else
	echo "Neovim folder is already cloned, please pull the latest manually"
fi

# make
cd neovim

# optimized builds
rm -r build
make clean
make CMAKE_BUILD_TYPE=Release
sudo make install
echo "Neovim is installed in /usr/local/bin"
echo -e "\tUninstall neovim, please run:"
echo -e "\t\tsudo rm /usr/local/bin/nvim"
echo -e "\t\tsudo rm /usr/local/share/nvim/"
