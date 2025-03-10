#!/bin/sh

# Raycast Script Command Template
#
# Duplicate this file and remove ".template." from the filename to get started.
# See full documentation here: https://github.com/raycast/script-commands
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title dict
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.icon 🟦
# @raycast.packageName Translator
# @raycast.argument1 { "type": "text", "placeholder": "word" }
#
# [ -s $HOME/.bashrc ] && source $HOME/.bashrc

[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
#if [ -f ~/.zshenv ] ;then
#  . ~/.zshenv
#fi
dict $1
