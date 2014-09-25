export LANG=ja_JP.UTF-8

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
if command -v go > /dev/null; then
  export GOPATH=$HOME/go
  path=($GOPATH/bin(N-/) $(go env GOROOT)/bin(N-/) $path)
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

# rbenv
if [ -f $HOME/.rbenv/bin/rbenv ]; then
  path=($HOME/.rbenv/bin $path)
  eval "$(rbenv init -)"
fi

# nodebrew
if [ -f $HOME/.nodebrew/current/bin/node ]; then
  path=($HOME/.nodebrew/current/bin $path)
fi

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "$HOME/.gvm/bin/gvm-init.sh" ]] && source "$HOME/.gvm/bin/gvm-init.sh"
