#!/bin/bash
#
[ -d .git ] && git maintenance start
git config --global fetch.writeCommitGraph true
