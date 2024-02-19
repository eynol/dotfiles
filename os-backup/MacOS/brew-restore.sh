#!/bin/bash
if [ -z "$(command -v brew)" ]; then
    echo brew is not installed
    exit
fi
SHELL_FOLDER=$(
    cd "$(dirname "$0")"
    pwd
)


# check latest brew bundle
if brew tap | grep bundle ;then
    echo brew has taped bundle
else 
    brew tap --custom-remote --force-auto-update homebrew/bundle https://git.mirrors.cqupt.edu.cn/Homebrew/homebrew-bundle.git
fi

if [ -z "$1" ]; then
    FILENAME="$SHELL_FOLDER/Brewfile"
else
    FILENAME="${1}"
fi
echo using filename: $FILENAME
brew bundle install --file=$FILENAME
