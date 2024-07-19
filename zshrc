if [[ -f "/opt/homebrew/bin/brew" ]] then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
  FPATH="$(/opt/homebrew/bin/brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# history
export HISTFILE=~/.history
export HISTSIZE=1000
export SAVEHIST=1000
setopt hist_ignore_all_dups
setopt hist_ignore_space

# bindings
bindkey '^[[H'	beginning-of-line
bindkey '^[[F'	end-of-line
bindkey '^D'	delete-char

bindkey '^[[1;5C' forward-word # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word # [Ctrl-LeftArrow] - move backward one word

# umask
umask 002

# enable IFS
setopt sh_wordsplit

# Binaries
# starship
export STARSHIP_CONFIG=~/.starship.toml

zinit ice as"command" from"gh-r" atload'eval "$(starship init zsh)"'
zinit load starship/starship

# junegunn/fzf-bin
export FILE_PREVIEW="bat --style=numbers,changes --wrap never --color always"
export DIR_PREVIEW="exa --color=always --group-directories-first --oneline"
export FZF_PREVIEW_COMMAND="${FILE_PREVIEW} {} || ${DIR_PREVIEW} {}"
export FZF_COMMON_OPTIONS="
--height 60% \
--border sharp \
--layout reverse \
--prompt '∷ ' \
--pointer ▶ \
--marker ⇒ \
--bind='?:toggle-preview' \
--bind='ctrl-u:preview-page-up' \
--bind='ctrl-d:preview-page-down'"
export FZF_CTRL_T_OPTS="${FZF_COMMON_OPTIONS} --preview '($FZF_PREVIEW_COMMAND) 2> /dev/null'"
export FZF_CTRL_R_OPTS="${FZF_COMMON_OPTIONS}"

zinit ice as"command" lucid from"gh-r" \
  pick"fzf"
zinit light junegunn/fzf

# ajeetdsouza/zoxide
export _ZO_FZF_OPTS="${FZF_COMMON_OPTIONS} --preview '${DIR_PREVIEW} {2..}'"

zinit ice as"command" lucid from"gh-r" \
  atclone"./zoxide init --cmd cd zsh > init.zsh" \
  atpull"%atclone" src"init.zsh" nocompile'!'
zinit light ajeetdsouza/zoxide

# sharkdp/bat
zinit ice as"command" from"gh-r" \
  mv"bat* -> bat" \
  pick"bat/bat"
zinit light sharkdp/bat
export BAT_THEME="Monokai Extended Origin"
alias cat="bat --style=numbers,changes --wrap never --color always"

# ogham/exa
zinit ice as"program" lucid from"gh-r" \
  mv"bin/exa* -> exa"
zinit light ogham/exa
alias ls="exa --git"

# direnv/direnv
zinit from"gh-r" as"program" mv"direnv* -> direnv" \
  atclone'./direnv hook zsh > zhook.zsh' atpull'%atclone' \
  pick"direnv" src="zhook.zsh" for \
direnv/direnv

# pyenv/pyenv
zinit ice atclone'PYENV_ROOT="$PWD" ./libexec/pyenv init - > zpyenv.zsh' \
    atinit'export PYENV_ROOT="$PWD"' atpull"%atclone" \
    as'command' pick'bin/pyenv' src"zpyenv.zsh" nocompile'!'
zinit light pyenv/pyenv

# derailed/k9s
zinit ice as"program" lucid from"gh-r" \
  pick"k9s"
zinit light derailed/k9s

# kubens/kubectx
zinit ice as"program" lucid from"gh-r" \
    bpick'kubectx;kubens'
zinit light ahmetb/kubectx


# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light joshskidmore/zsh-fzf-history-search
zinit light zpm-zsh/bookmarks

# Load completions
zinit ice as"completion"
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/completion.zsh
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh

zinit ice lucid nocompile wait'1' nocompletions
zinit load MenkeTechnologies/zsh-more-completions

# thefuck
zinit ice wait"1" lucid
zinit light laggardkernel/zsh-thefuck

autoload -Uz compinit && compinit

zinit cdreplay -q

# env
# std
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export PAGER="bat"
export EDITOR="nvim"
export PATH="$HOME/local/bin:$PATH"

# aliases
alias ll='ls -l'
alias lla='ls -la'
alias la='ls -a'

alias ip='ip -c -h'

alias g='git'
alias gitk='gitk --all'

alias d='docker'

# extra modules
source ~/.zsh/blue
