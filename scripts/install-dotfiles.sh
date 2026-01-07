#!/bin/bash
REPO=https://cnb.cool/cnb.heitaov.cn/dotfiles

echo "install dotfiles from git repo $REPO"
if [ -d "$HOME/.cfg" ]; then
  echo .cfg folder exist, skip clone git repo
else
  echo .cfg folder not exist, clone git repo
  git clone --bare $REPO $HOME/.cfg
fi
function config {
  git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
  #    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}
mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config."
else
  echo "Backing up pre-existing dot files."
  config checkout 2>&1 | egrep "\s+" | awk {'print $1'} | xargs -I{} mv -v {} .config-backup/{}
fi
config checkout
config config status.showUntrackedFiles no

echo "Tip: reload your shell or source your rc file."
