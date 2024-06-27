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

# bindings
bindkey '^[[H'	beginning-of-line
bindkey '^[[F'	end-of-line
bindkey '^D'	delete-char

bindkey '^[[1;5C' forward-word # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word # [Ctrl-LeftArrow] - move backward one word


# Binaries
# starship
zinit ice as"command" from"gh-r" atload'eval "$(starship init zsh)"'
zinit load starship/starship

# junegunn/fzf-bin
zinit ice as"command" lucid from"gh-r" \
  pick"fzf"
zinit light junegunn/fzf

# ajeetdsouza/zoxide
zinit ice as"command" lucid from"gh-r" \
  atclone"./zoxide init --cmd cd zsh > init.zsh" \
  atpull"%atclone" src"init.zsh" nocompile'!'
zinit light ajeetdsouza/zoxide

# sharkdp/bat
zinit ice as"command" from"gh-r" \
  mv"bat* -> bat" \
  pick"bat/bat"
zinit light sharkdp/bat
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

# Load completions
zinit ice as"completion"
#zinit snippet https://github.com/ahmetb/kubectx/blob/master/completion/_kubectx.zsh
#zinit snippet https://github.com/ahmetb/kubectx/blob/master/completion/_kubens.zsh
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/completion.zsh
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh
zinit snippet https://github.com/zx2c4/password-store/blob/master/src/completion/pass.zsh-completion
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/docker/completions/_docker
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/pip/_pip
zinit snippet https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/rust/_rustc

autoload -Uz compinit && compinit

zinit cdreplay -q

# env
# starship
export STARSHIP_CONFIG=~/.starship.toml

# fzf
export FZF_PREVIEW_COMMAND="bat --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}"
export FZF_COMMON_OPTIONS="
--height 60% \
--border sharp \
--layout reverse \
--prompt '∷ ' \
--pointer ▶ \
--marker ⇒ \
--bind='?:toggle-preview' \
--bind='ctrl-u:preview-page-up' \
--bind='ctrl-d:preview-page-down' \
--preview '($FZF_PREVIEW_COMMAND) 2> /dev/null'"
export FZF_CTRL_T_OPTS="${FZF_COMMON_OPTIONS}"
export FZF_CTRL_R_OPTS="${FZF_COMMON_OPTIONS}"

# zoxide
export _ZO_FZF_OPTS="${FZF_COMMON_OPTIONS}"

# std
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
export PAGER="bat"
export EDITOR="nvim"

# aliases
alias ll='ls -l'
alias lla='ls -la'
alias la='ls -a'

alias ip='ip -c -h'

alias g='git'
alias d='docker'

source ~/.zsh/blue
