#! /bin/bash

source "../functions/functions"
RM=rm

stat_busy "Zsh installation"

for file in zshrc zsh; do
  if [ -e ~/.$file ]; then
    $RM ~/.$file
  fi
  ln -s $PWD/$file ~/.$file
  printhl "$file linked"
done

stat_done
