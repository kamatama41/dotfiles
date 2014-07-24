# ヒストリにhistoryコマンドを記録しない
setopt hist_no_store
# 同じ履歴は残さない
setopt hist_ignore_all_dups
# 補完
autoload -Uz compinit
compinit
# sshと同じ補完をする
compdef mosh=ssh

# office設定(あれば)
if [ -f $HOME/.zshrc_office ]; then
  source $HOME/.zshrc_office
fi

# svn
if [ -f /opt/subversion/bin/svn ]; then
  path=(/opt/subversion/bin $path)
fi

# maven
if [ -f $HOME/maven2/current/bin/mvn ]; then
  export M2_HOME=$HOME/maven2/current
  path=($M2_HOME/bin $path)
fi

# golang
export GOPATH=$HOME/go
path=($GOPATH/bin(N-/) $(go env GOROOT)/bin(N-/) $path)

# mysql
if [ -f /usr/local/mysql/bin/mysql ]; then
  path=(/usr/local/mysql/bin $path)
fi

# rbenv
if [ -f $HOME/.rbenv/bin/rbenv ]; then
  path=($HOME/.rbenv/bin $path)
  eval "$(rbenv init -)"
fi

# peco
# ヒストリから検索する
function peco-select-history() {
  local tac
  if which tac > /dev/null; then
    tac="tac"
  else
    tac="tail -r"
  fi
    BUFFER=$(history -n 1 | \
      eval $tac | \
      peco --query "$LBUFFER")
    CURSOR=$#BUFFER
    zle clear-screen
}
zle -N peco-select-history
bindkey '^r' peco-select-history

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "$HOME/.gvm/bin/gvm-init.sh" ]] && source "$HOME/.gvm/bin/gvm-init.sh"
