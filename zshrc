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
export HISTSIZE=5000000
export SAVEHIST=$HISTSIZE

setopt EXTENDED_HISTORY          # Write the history file in the ':start:elapsed;command' format.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS          # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt SHARE_HISTORY             # Share history between all sessions.

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

# ogham/exa
zinit ice as"program" lucid from"gh-r" \
  mv"bin/exa* -> exa"
zinit light ogham/exa

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

# kubernetes-sigs/krew
zinit ice as"program" lucid from"gh-r" \
    atclone'./krew* install krew' atpull'%atclone' \
    atinit"export PATH=${KREW_ROOT:-$HOME/.krew}/bin:$PATH" \
    pick'krew'
zinit light kubernetes-sigs/krew

# neovim
zinit ice as"program" lucid from'gh-r' \
    bpick"*tar*" \
    pick'*/bin/nvim'
zinit light neovim/neovim

# ripgrep
zinit ice as"program" lucid from'gh-r' \
    pick'**/rg'
zinit light BurntSushi/ripgrep

# fd
zinit ice as"program" lucid from'gh-r' \
    atclone'cp -vf contrib/completion/_fd _fd' \
    pick'**/fd'
zinit light sharkdp/fd

# dust
zinit ice as"program" lucid from'gh-r' \
    pick'**/dust'
zinit light bootandy/dust

# chino540off/samnefni
zinit ice as"program" lucid from"gh-r" \
    pick'samnefni'
zinit light chino540off/samnefni

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit light joshskidmore/zsh-fzf-history-search
zinit light chino540off/bookmarks

# Load completions
zinit ice as"completion"
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/completion.zsh
zinit snippet https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh

zinit ice lucid nocompile wait'1' nocompletions
zinit load MenkeTechnologies/zsh-more-completions

# thefuck
zinit ice wait"1" lucid
zinit light laggardkernel/zsh-thefuck

setopt complete_aliases
export ZSH_COMPLETION_LOCAL=~/.zsh/completions
fpath=($ZSH_COMPLETION_LOCAL $fpath)

zinit cdreplay -q

# env
# std
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat -plman'"
export PAGER="bat"
export EDITOR="nvim"
export PATH="$HOME/local/bin:$PATH"

autoload -Uz compinit && compinit

function alias-def() {
  local _alias=$1
  shift
  local _cmd=$1
  local _all="$@"

  alias $_alias="$_all"
  compdef $_alias=$_cmd
}

# aliases
alias cat="bat --style=numbers,changes --wrap never --color always"

alias ls="exa --git"
alias-def ll ls -l
alias-def lla ls -la
alias-def la ls -a

alias-def ip ip -c -h

alias-def g git
alias-def gitk gitk --all

export SAMNEFNI_CONFIG=~/.samnefni.toml
samnefni completion --shell zsh > ${ZSH_COMPLETION_LOCAL}/_samnefni

function samnefni-alias-zsh() {
  local _alias=$1
  local _command=$2
  local _fpath=$3

  alias $_alias="samnefni exec $_command --"
  samnefni completion --shell zsh $_command > ${_fpath}/_samnefni-$_command
  compdef _samnefni-$_command $_alias
}

samnefni-alias-zsh d    docker      $ZSH_COMPLETION_LOCAL
samnefni-alias-zsh k    kubectl     $ZSH_COMPLETION_LOCAL
samnefni-alias-zsh kctx kubectx     $ZSH_COMPLETION_LOCAL
samnefni-alias-zsh kns  kubens      $ZSH_COMPLETION_LOCAL
samnefni-alias-zsh n    nix         $ZSH_COMPLETION_LOCAL
samnefni-alias-zsh p    pass        $ZSH_COMPLETION_LOCAL

# extra modules
source ~/.zsh/blue
