#!/bin/bash

TARGET_SHA=$1

result=$(git rev-parse HEAD 2>&1)

if [[ $result == *"Not a git repository"* ]]; then
	echo "Not in a Git repository"
	exit 1
fi

git for-each-ref --format='%(refname) %(objectname)' refs/ |
	grep -F "$TARGET_SHA" | grep -v prefetch | awk '{ print $1}'
