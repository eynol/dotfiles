# dotfiles

This is the very first repo to clone after switch to a new machine. The purposes of this repo are listed below.

- Automation

    Shell script makes it easy to automating installing softwares and setting up your development environment. 

- Repeating operations

    For example, backup files.

- Saving Time

    Spend time writing a script and save time at some time in the future.

- Config files

    Config files can be shared between machines or operating systems. Don't waste time to google it and configure it again and again.

    > nerd font download [link](https://www.nerdfonts.com/font-downloads)

- Other Intents

    IOT stuff.

## Install

```bash
curl -Lks https://github.com/eynol/dotfiles/raw/master/scripts/install-dotfiles.sh | /bin/bash
```

The install script does the following things.

- Clone this repo to `$HOME/.cfg`
- Make dir `.config-backup` for backuping existing config files
- Try checkout files
  - if checkout error, rerun again to use `egrep  "\s+"` to select files and mv these files to `.config-backup`
- In the end, `git config status.showUntrackedFiles no`

When install is done, reload your shell or source your rc file. 
You can use `config` as `git` command to manage your dotfiles.

## Instruction

Check out this article: [https://www.atlassian.com/git/tutorials/dotfiles](https://www.atlassian.com/git/tutorials/dotfiles) and [github.com/durdn/cfg](https://github.com/durdn/cfg).

It shows a simple way to backup your dotfiles.

## How Dotfiles Work

### bootstrap

Basicly, it use `.zshrc` or `.bashrc` to source other config files.

```bash
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
#
# read common shared config
[ -s "$HOME/.shell.rc.sh" ] && source $HOME/.shell.rc.sh
```

In the `$HOME/.shell.rc.sh`, it does the following things.

- Add `$HOME/bin` to `$PATH`, so that we can use local binaries
- Add device private scripts to `$PATH` in `$HOME/device-scripts`

- Set environment variables:  `RUSTUP_DIST_SERVER` 
- Source `$HOME/.shell.secret.sh` if it exists
- Source `$HOME/.shell.device.sh` if it exists
- Define editor: `export EDITOR=nvim`
- Define aliases: 
  - `lg` : lazygit
  - `t` :
  - `v` : `$EDITOR`
  - `config` : `git --git-dir=$HOME/.cfg/ --work-tree=$HOME `
  - `lazyconfig`: `lazygit --git-dir=$HOME/.cfg/ --work-tree=$HOME`
- Os related configs

### git config

git can use `includeIf` to include different config files based on the remote url.

```gitconfig
[includeIf "hasconfig:remote.*.url:git@gitlab.com:*/**"]
  path = ~/.gitconfig.github
```
