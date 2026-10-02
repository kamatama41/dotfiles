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

# GO
function setGOROOT(){
  v=${1}
  echo "Set GOROOT to ${v}"
  export GOROOT=$(go${v} env GOROOT)
  path=(${GOROOT}/bin(N-/) $path)
}
export PATH="$HOME/go/bin:$PATH"

# Delete merged branches
function git_delete-merged-branches(){
  git branch --merged | grep -v '*' | xargs -I % git branch -d %
}

# rbenv
if [ -f /opt/homebrew/bin/rbenv ]; then
  eval "$(rbenv init -)"
fi

# pyenv (via homebrew)
if [ -f $HOME/.homebrew/bin/pyenv ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
fi

# fnm (via homebrew)
if [ -f /opt/homebrew/bin/fnm ]; then
  eval "$(fnm env --use-on-cd)"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# .rc for office (if exists) 
if [ -f $HOME/.zshrc_office ]; then
  source $HOME/.zshrc_office
fi

# OpenSSL (via homebrew)
if [ -f $HOME/.homebrew/opt/openssl@3/bin/openssl ]; then
  #path=($HOME/.homebrew/opt/openssl@3/bin $path)
  export PATH=$HOME/.homebrew/opt/openssl@3/bin:$PATH
fi

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sishimura/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/sishimura/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sishimura/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/sishimura/google-cloud-sdk/completion.zsh.inc'; fi

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/sishimura/.docker/completions $fpath)
autoload -Uz compinit
(( ${+_comps[docker]} )) || compinit
# End of Docker CLI completions
export PATH="$HOME/.local/bin:$PATH"

# ---------------------------------------------------------------
# Modern CLI tools (インストールされているものだけ有効化)
#   brew install fzf fd ripgrep zoxide eza bat lazygit starship git-delta
# ---------------------------------------------------------------
export EDITOR=nvim
export VISUAL=nvim

# starship: プロンプト (設定: ~/.config/starship.toml)
(( $+commands[starship] )) && eval "$(starship init zsh)"

# zoxide: `z <名前の一部>` でジャンプ, `zi` で fzf 選択
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

# fzf: Ctrl-R 履歴 / Ctrl-T ファイル / Alt-C cd
if (( $+commands[fzf] )); then
  source <(fzf --zsh)
  if (( $+commands[fd] )); then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
  fi
  export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
  (( $+commands[bat] )) && export FZF_CTRL_T_OPTS="--preview 'bat --color=always --style=numbers --line-range=:200 {}'"
fi

if (( $+commands[eza] )); then
  alias ls='eza --icons --git'
  alias ll='eza -l --icons --git'
  alias la='eza -la --icons --git'
  alias lt='eza --tree --level=2 --icons'
fi
(( $+commands[bat] )) && alias cat='bat --paging=never --style=plain'
(( $+commands[lazygit] )) && alias lg='lazygit'
alias vi='nvim'
alias vim='nvim'
