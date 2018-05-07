# alias
alias tmux='tmux -2'

HISTFILE=${HOME}/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
# Share histories in each shell process
setopt share_history
# Not record "history" command to history
setopt hist_no_store
# Ignore duplicate command
setopt hist_ignore_all_dups
# Completion settings
autoload -Uz compinit
compinit
# mosh has the same comp definition as ssh
compdef mosh=ssh

# vcs_info in right prompt
autoload -Uz add-zsh-hook
autoload -Uz vcs_info
zstyle ':vcs_info:*' formats '(%b)'
zstyle ':vcs_info:*' actionformats '(%b|%a)'

function _update_vcs_info_message() {
  psvar=()
  LANG=en_US.UTF-8 vcs_info
  psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_message
RPROMPT="[%c]%v"

## peco
# Search via history
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

# Window switching for tmux
#function peco-tmux() {
#  local i=$(tmux lsw | awk '/active.$/ {print NR-1}')
#  local f='#{window_index}: #{window_name}#{window_flags} #{pane_current_path}'
#  tmux lsw -F "$f" \
#    | anyframe-selector-auto "" --initial-index $i \
#    | cut -d ':' -f 1 \
#    | anyframe-action-execute tmux select-window -t
#}
#zle -N peco-tmux
#bindkey '^[' peco-tmux

# Refresh zshrc
function refresh-setting(){
  # git pull
  current=$PWD
  git_dir=$(dirname `readlink ~/.zshrc`)
  cd $git_dir
  git pull
  cd $current
  source ~/.zshrc
}

# Delete merged branches
function git_delete-merged-branches(){
  git branch --merged | grep -v '*' | xargs -I % git branch -d %
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/shinichi/.sdkman"
[[ -s "/Users/shinichi/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/shinichi/.sdkman/bin/sdkman-init.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ishimura/Downloads/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/ishimura/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ishimura/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/ishimura/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
