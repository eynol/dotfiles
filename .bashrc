# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

### *** === BASH CONFIG BEGIN
# export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
# export PATH="/usr/local/opt/ncurses/bin:$PATH"
# export NVM_DIR="$HOME/.nvm"
# [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
# [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
# [ -f ~/.bashrc ] && . ~/.bashrc

# test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

# export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_211.jdk/Contents/Home"
# export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
# export PATH=$JAVA_HOME/bin:$PATH
# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8
# export PATH="$PATH:/Users/taokai/FlutterSDK/flutter/bin:/Users/taokai/bin"

# source ~/.commonrc

# export PATH="$HOME/.cargo/bin:$PATH"
export DEBUG_SH_LOAD=$DEBUG_SH_LOAD:.bashrc

# some config from: http://github.com/durdn/cfg/.bashrc
#Global options {{{
export SHELL_SESSION_HISTORY=0
export HISTFILESIZE=999999
export HISTSIZE=999999

export HISTCONTROL=ignoredups:ignorespace
shopt -s checkwinsize
shopt -s progcomp
# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
#!! sets vi mode for shell
# set -o vi
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# }}}

[ -s "$HOME/.shell.rc.sh" ] && source $HOME/.shell.rc.sh




# youtube-dl -F {url}
# youtube-dl -f {audio}+{video} {url}
# youtube-dl -f {audio}+{video} {url} --playlist-start 22
alias youtube-dl-playlist="youtube-dl  --write-auto-sub --sub-lang en,zh,zh-tw,jp,zh-hans --output '%(playlist)s/%(playlist_index)s- %(title)s.%(ext)s'"

alias agc='ag --noheading --column'


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


# based on Chen bin @  https://www.quora.com/What-are-some-time-saving-tips-that-every-Linux-user-should-know
export HISTSIZE=32768
shopt -s histverify

function cleanfile () {
  if [ -z "$1" ]; then
    echo "Usage: remove duplicated lines without sort"
    echo "  cleanfile ~/.bash_history"
  else
      local bkfile="$1.backup"
      # \+ does not work in OSX sed
      # delte short commands, delete git related commands
      sed 's/ *$//g;' $1 | sed '/^.\{1,4\}$/d' | sed '/^g[nlabcdusfp]\{1,5\} .*/d' | sed '/^git [nr] /d' | sed '/^rm /d' | sed '/^cgnb /d' | sed '/^touch /d' > $bkfile
      # @see Page on stack Overflow/questions/11532157/unix-removing-duplicate-lines-without-sorting
      cat $bkfile | awk ' !x[$0]++' > $1
      rm $bkfile
  fi
}

# Linux specific config {{{
if [ $(uname) == "Linux" ]; then
  shopt -s autocd
  # Add an "alert" alias for long running commands.  Use like so: sleep 10; alert
  alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

fi
# }}}



# tip:3
# $ history|grep "keyword"|grep "keyword2"
# > 233
# $ !233

# alias h=history

# tip 6
# PROMPT_COMMAND="history -a"
