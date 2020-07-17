export LANG=ja_JP.UTF-8
export EDITOR=vim
export GPG_TTY=$(tty)
bindkey -e

# maven
if [ -f $HOME/maven2/current/bin/mvn ]; then
  export M2_HOME=$HOME/maven2/current
  path=($M2_HOME/bin $path)
fi

# golang
if [ -f /usr/local/go/bin/go ]; then
  export GOPATH=$HOME/go
  path=($GOPATH/bin(N-/) $(/usr/local/go/bin/go env GOROOT)/bin(N-/) $path)
fi


# .zgen (if exists)
if [ -f $HOME/.zshrc.zgen ]; then
  source $HOME/.zshrc.zgen
fi

# node.js
if [ -s $HOME/.nvm/nvm.sh  ]; then
  . $HOME/.nvm/nvm.sh
  nvm use default
  npm_dir=${NVM_PATH}_modules
  export NODE_PATH=$npm_dir
fi

# mysql
if [ -f /usr/local/mysql/bin/mysql ]; then
  path=(/usr/local/mysql/bin $path)
fi

# nodebrew
if [ -f $HOME/.nodebrew/current/bin/nodebrew ]; then
  path=($HOME/.nodebrew/current/bin $path)
fi

# javacc
if [ -f $HOME/javacc/javacc-6.0/bin/lib/javacc.jar ]; then
  path=($HOME/javacc/javacc-6.0/bin $path)
fi

# embulk
if [ -f $HOME/.embulk/bin/embulk ]; then
  path=($HOME/.embulk/bin $path)
fi

# embulk
if [ -f $HOME/.digdag/bin/digdag ]; then
  path=($HOME/.digdag/bin $path)
fi

# homebrew
if [ -f /opt/homebrew/bin/brew ]; then
  path=(/opt/homebrew/bin $path)
fi

# PostgreSQL (via homebrew)
if [ -f /opt/homebrew/opt/postgresql@9.6/bin/psql ]; then
  path=(/opt/homebrew/opt/postgresql@9.6/bin $path)
fi

