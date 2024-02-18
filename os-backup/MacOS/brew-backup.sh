#!/bin/bash
if [ -z "$(command -v brew)" ]; then
    echo brew is not installed
    exit
fi
SHELL_FOLDER=$(cd "$(dirname "$0")";pwd)
echo $0
brew bundle --file=- dump|grep -v "vscode \"" > $SHELL_FOLDER/Brewfile