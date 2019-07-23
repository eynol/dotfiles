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