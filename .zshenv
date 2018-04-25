export LANG=ja_JP.UTF-8
export EDITOR=vim
export GPG_TTY=$(tty)
bindkey -e

# Java(default 1.7)
function chjava() {
  version=$1
  echo "Change java version to ${version}"
  export JAVA_HOME=`/System/Library/Frameworks/JavaVM.framework/Versions/A/Commands/java_home -v "${version}"`
}

# リポジトリ上にある実行ファイル
if [ -d $HOME/.bin ]; then
  path=($HOME/.bin $path)
fi

# svn
#if [ -f /opt/subversion/bin/svn ]; then
#  path=(/opt/subversion/bin $path)
#fi

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

# office設定(あれば)
if [ -f $HOME/.zshrc_office ]; then
  source $HOME/.zshrc_office
fi

# zgen設定(あれば)
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

# rbenv
if [ -f $HOME/.rbenv/bin/rbenv ]; then
  path=($HOME/.rbenv/bin $path)
  eval "$(rbenv init -)"
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

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "$HOME/.gvm/bin/gvm-init.sh" ]] && source "$HOME/.gvm/bin/gvm-init.sh"

# The next line updates PATH for the Google Cloud SDK.
[[ -s "$HOME/google-cloud-sdk/path.zsh.inc" ]] && source "$HOME/google-cloud-sdk/path.zsh.inc"
# The next line enables bash completion for gcloud.
#[[ -s "$HOME/google-cloud-sdk/completion.zsh.inc" ]] && source "$HOME/google-cloud-sdk/completion.zsh.inc"
