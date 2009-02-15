# Load files in ~/.zsh/*
for file in ~/.zsh/*[^~]; do
  source $file
done
