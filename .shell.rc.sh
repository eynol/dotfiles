# User config paths
export PATH=$HOME/.bin:$HOME/bin:$HOME/.local/bin:$HOME/.docker/bin:$PATH
[ -d $HOME/device-scripts ] && export PATH=$HOME/device-scripts:$PATH
[ -d $HOME/.codeium/windsurf/bin ] && export PATH=$HOME/.codeium/windsurf/bin:$PATH

# rust env setup
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

[ -s "$HOME/.shell.secret.sh" ] && source $HOME/.shell.secret.sh
[ -s "$HOME/.shell.device.sh" ] && source $HOME/.shell.device.sh

if [ -n "$USE_NVM" ]; then
  # NVM config
  export NVM_NODEJS_ORG_MIRROR=https://mirrors.ustc.edu.cn/node/
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
fi

# fnm
if command -v fnm 2>&1 >/dev/null; then
  export FNM_NODE_DIST_MIRROR=https://mirrors.ustc.edu.cn/node/
  eval "$(fnm env)"
fi
# deno config
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# editor
export VISUAL=nvim
export EDITOR=nvim

alias v='nvim'
alias s="kitten ssh"
alias lg='lazygit'
alias t='tmux'

# fzf config
if [ -n "$ZSH_VERSION" ]; then
  # assume Zsh
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
elif [ -n "$BASH_VERSION" ]; then
  # assume Bash
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
else
  # assume something else
  [ -z 0]
fi

_zsh_ifdo() {
  if [ -n "$ZSH_VERSION" ]; then
    $*
  fi
}

# iterm2 config load
[ -n "$ZSH_VERSION" ] &&
  [ -s "${HOME}/.iterm2_shell_integration.zsh" ] &&
  source "${HOME}/.iterm2_shell_integration.zsh"

# Global functions (aka complex aliases) {{{
function f {
  find . -type f | grep -v .svn | grep -v .git | grep -i $1
}

function fzfo() {
  file=$(fzf)
  dirname=$(dirname $file)
  cd $dirname
}

function config-github-user-global() {
  git config --global user.name kyle.tk
  git config --global user.email 62560852@qq.com
  git config --global core.quotePath false
}
function config-github-user-local() {
  git config --local user.name kyle.tk
  git config --local user.email 62560852@qq.com
}

# }}}

# see http://github.com/durdn/cfg/
# durdn/cfg related commands {{{
alias config='git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias lazyconfig='lazygit --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias zshconfig="$EDITOR ~/.zshrc"

# zsh completion for config command. Treat 'config' as git
_zsh_ifdo compdef config=git

function _dur {
  case $1 in
  create | cr)
    echo "disabled"
    ;;
  list | li)
    curl --user $2:$3 https://api.bitbucket.org/1.0/user/repositories 2>/dev/null | grep "name" | sed -e 's/\"//g' | col 2 | sort | uniq | column
    ;;
  clone | cl)
    git clone git@bitbucket.org:durdn/$2.git
    ;;
  move | mv)
    git remote add bitbucket git@bitbucket.org:durdn/$(basename $(pwd)).git
    git push --all bitbucket
    ;;
  trackall | tr)
    #track all remote branches of a project
    for remote in $(git branch -r | grep -v master); do git checkout --track $remote; done
    ;;
  key | k)
    #track all remote branches of a project
    ssh $2 'mkdir -p .ssh && cat >> .ssh/authorized_keys' <~/.ssh/id_rsa.pub
    ;;
  fun | f)
    #list all custom bash functions defined
    typeset -F | col 3 | grep -v _ | xargs | fold -sw 60
    ;;
  def | d)
    #show definition of function $1
    typeset -f $2
    ;;
  help | h | *)
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

# OSX specific config {{{
if [ $(uname) = "Darwin" ]; then

  #aliases {{{

  # }}}

  #open macvim
  function gvim {
    if [ -e $1 ]; then
      open -a MacVim $@
    else
      touch $@ && open -a MacVim $@
    fi
  }
  #open visual studio code
  function vsc {
    if [ -e $1 ]; then
      open -a Visual\ Studio\ Code $@
    else
      touch $@ && -a Visual\ Studio\ Code $@
    fi
  }

  #homebrew git autocompletions {{{
  if [ -f $(brew --prefix)/etc/bash_completion.d/git-completion.bash ] && [ -n "$BASH_VERSION" ]; then
    . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
  fi
  #}}}

  eval "$(/opt/homebrew/bin/brew shellenv)"
  export HOMEBREW_API_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles/api"
  export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.ustc.edu.cn/homebrew-bottles"
  export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.ustc.edu.cn/brew.git"
  export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.ustc.edu.cn/homebrew-core.git"
  export HOMEBREW_PIP_INDEX_URL="https://pypi.tuna.tsinghua.edu.cn/simple"

fi

# }}}
