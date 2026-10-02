#!/bin/sh 

cd $(dirname $0)
for dotfile in .?*; do
  case $dotfile in
    ..)
      continue;;
    .git)
      continue;;
    .gitignore)
      continue;;
    .gitmodules)
      continue;;
    *)
      ln -Fis "${PWD}/${dotfile}" $HOME/${dotfile}
      ;;
  esac
done

# lazygit
if command -v lazygit > /dev/null; then
  lazygit_dir=$(lazygit --print-config-dir)
else
  lazygit_dir="$HOME/Library/Application Support/lazygit"
fi
mkdir -p "${lazygit_dir}"
ln -Fis "${PWD}/lazygit/config.yml" "${lazygit_dir}/config.yml"

# ghostty
mkdir -p "$HOME/.config/ghostty"
ln -Fis "${PWD}/ghostty/config" "$HOME/.config/ghostty/config"
