##############################################################################
# Oh-My-ZSH configuration

export ZSH=$HOME/.oh-my-zsh
export ZSH_CUSTOM=$HOME/.zsh-custom

COMPLETION_WAITING_DOTS="true"
DISABLE_AUTO_TITLE="true"
DISABLE_AUTO_UPDATE="true"
ENABLE_CORRECTION="false"
HIST_STAMPS="dd/mm/yyyy"
ZSH_DISABLE_COMPFIX="true"
ZSH_THEME="namchu"

plugins=()

source $ZSH/oh-my-zsh.sh

export EDITOR='nvim'
export VISUAL='nvim'

export GPG_TTY=$(tty)

export LANG='en_US.UTF-8'
export LANGUAGE='en_US.UTF-8'
export LC_CTYPE='en_US.UTF-8'
export LC_NUMERIC='en_US.UTF-8'
export LC_TIME='en_GB.UTF-8'
export LC_COLLATE='en_US.UTF-8'
export LC_MONETARY='en_US.UTF-8'
export LC_MESSAGES='en_US.UTF-8'
export LC_PAPER='en_US.UTF-8'
export LC_NAME='en_US.UTF-8'
export LC_ADDRESS='en_US.UTF-8'
export LC_TELEPHONE='en_US.UTF-8'
export LC_MEASUREMENT='en_US.UTF-8'
export LC_IDENTIFICATION='en_US.UTF-8'
export LC_ALL='en_US.UTF-8'

setopt no_share_history

###############################################################################
# Loading aliases
[ -s "$HOME/.zsh-aliases" ] && source "$HOME/.zsh-aliases"

export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

###############################################################################
# Specific bindkey for better iTerm2 - ZSH - Neovim integration
# bindkey '^A' beginning-of-line
# bindkey '^E' end-of-line
# bindkey '^B' backward-word
# bindkey '^F' forward-word
# bindkey '^U' kill-whole-line
# bindkey '^W' backward-kill-word

###############################################################################
# Homebrew executables
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/python/libexec/bin:$PATH"

###############################################################################
# Setup nvm
alias load-nvm='source "$HOME/.nvm/nvm.sh"'
# source "$HOME/.nvm/nvm.sh"

###############################################################################
# Setup rbenv
alias load-rbenv='export PATH="$HOME/.rbenv/bin:$PATH" && eval "$(rbenv init - zsh)"'
# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init - zsh)"

###############################################################################
# Setup pyenv
alias load-pyenv='export PYENV_ROOT="$HOME/.pyenv" && export PATH="$PYENV_ROOT/bin:$PATH" && eval "$(pyenv init - zsh)"'
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - zsh)"

###############################################################################
# Setup golang
alias load-gvm='source "$HOME/.gvm/scripts/gvm"'
export GOPATH="$HOME/.go"
export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
# source "$HOME/.gvm/scripts/gvm"
