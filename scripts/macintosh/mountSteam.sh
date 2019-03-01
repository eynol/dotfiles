#!/usr/bin/bash
sudo diskutil unmount /dev/disk1s5
sudo  mount -t apfs /dev/disk1s5 ~/Library/Application\ Support/Steam/
