# Load files in ~/.zsh/*

SYSTEM=`uname -s`

for file in ~/.zsh/*[^~]; do
  source $file
done
