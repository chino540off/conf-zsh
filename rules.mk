_m = zsh

$(_m)-dirs =	\
  bookmarks

$(_m)-dir-bookmarks	= $(CURDIR)/zsh/bookmarks

$(_m)-links =	\
  starship.toml \
  zshrc		\
  zsh

$(_m)-link-starship.toml= ~/.starship.toml
$(_m)-link-zshrc	= ~/.zshrc
$(_m)-link-zsh		= ~/.zsh
