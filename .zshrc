# git pull
git_dir=$(dirname `readlink ~/.zshrc`)
cd $git_dir
git pull
cd

HISTFILE=${HOME}/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
# シェルのプロセスごとに履歴を共有
setopt share_history
# ヒストリにhistoryコマンドを記録しない
setopt hist_no_store
# 同じ履歴は残さない
setopt hist_ignore_all_dups
# 補完
autoload -Uz compinit
compinit
# sshと同じ補完をする
compdef mosh=ssh

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

