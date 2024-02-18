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

#!! sets vi mode for shell
# set -o vi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
# }}}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export PATH=$HOME/.local/bin:$PATH
export PATH=$HOME/.bin:$HOME/bin:$PATH



# Global functions (aka complex aliases) {{{
function f {
  find . -type f | grep -v .svn | grep -v .git | grep -i $1
}


# }}}
# see http://github.com/durdn/cfg/
# durdn/cfg related commands {{{
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
function _dur {
  case $1 in
  create|cr)
    echo "disabled"
    ;;
  list|li)
    curl --user $2:$3 https://api.bitbucket.org/1.0/user/repositories 2> /dev/null | grep "name" | sed -e 's/\"//g' | col 2 | sort | uniq | column
    ;;
  clone|cl)
    git clone git@bitbucket.org:durdn/$2.git
    ;;
  move|mv)
    git remote add bitbucket git@bitbucket.org:durdn/$(basename $(pwd)).git
    git push --all bitbucket
    ;;
  trackall|tr)
    #track all remote branches of a project
    for remote in $(git branch -r | grep -v master ); do git checkout --track $remote ; done
    ;;
  key|k)
    #track all remote branches of a project
    ssh $2 'mkdir -p .ssh && cat >> .ssh/authorized_keys' < ~/.ssh/id_rsa.pub
    ;;
  fun|f)
    #list all custom bash functions defined
    typeset -F | col 3 | grep -v _ | xargs | fold -sw 60
    ;;
  def|d)
    #show definition of function $1
    typeset -f $2
    ;;
  help|h|*)
    echo "[dur]dn shell automation tools - (c) 2011 Nicola Paolucci nick@durdn.com"
    echo "commands available:"
    echo " [cr]eate, [li]st, [cl]one"
    echo " [i]nstall,[m]o[v]e, [re]install"
    echo " [f]fun lists all bash functions defined in .bashrc"
    echo " [def] <fun> lists definition of function defined in .bashrc"
    echo " [k]ey <host> copies ssh key to target host"
    echo " [tr]ackall], [h]elp"
    ;;
  esac
}

# }}}

# youtube-dl -F {url}
# youtube-dl -f {audio}+{video} {url}
# youtube-dl -f {audio}+{video} {url} --playlist-start 22
alias youtube-dl-playlist="youtube-dl  --write-auto-sub --sub-lang en,zh,zh-tw,jp,zh-hans --output '%(playlist)s/%(playlist_index)s- %(title)s.%(ext)s'"

function fzfo(){
  file=`fzf`
  dirname=`dirname $file`
  cd $dirname
}

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



# OSX specific config {{{
if [ $(uname) == "Darwin" ]; then
  export TERM=xterm-256color
  export PATH=/usr/local/bin:/usr/local/sbin:/usr/local/Cellar/python3/3.4.1/bin:$HOME/bin:$PATH
  export MANPATH=/opt/local/share/man:$MANPATH

  #aliases {{{

  # }}}

  #open macvim
  function gvim {
    if [ -e $1 ];
      then open -a MacVim $@;
      else touch $@ && open -a MacVim $@;
    fi
  }
  #open visual studio code
  function vsc {
    if [ -e $1 ];
      then open -a Visual\ Studio\ Code $@;
      else touch $@ && -a Visual\ Studio\ Code $@;
    fi
  }


  #homebrew git autocompletions {{{
  if [ -f `brew --prefix`/etc/bash_completion.d/git-completion.bash ]; then
    . `brew --prefix`/etc/bash_completion.d/git-completion.bash
  fi
  #}}}

fi

# }}}


# tip:3 
# $ history|grep "keyword"|grep "keyword2"
# > 233
# $ !233

# alias h=history

# tip 6
# PROMPT_COMMAND="history -a" 
