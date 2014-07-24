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
#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "$HOME/.gvm/bin/gvm-init.sh" ]] && source "$HOME/.gvm/bin/gvm-init.sh"
