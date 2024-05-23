###############################################################################
# ZSH debugging
if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zmodload zsh/zprof
fi
# time ZSH_DEBUGRC=1 zsh -i -c exit



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

###############################################################################
# Setup GPG
export GPG_TTY=$(tty)
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

###############################################################################
# Import zsh command suggestions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

###############################################################################
# Homebrew executables
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="/opt/homebrew/opt/python/libexec/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@14/bin:$PATH"

export PATH="$PATH:$HOME/Applications/bin"
export PATH="$PATH:$HOME/.local/bin"

export DISABLE_SPRING=true

###############################################################################
# Setup rbenv
export LDFLAGS="-L/opt/homebrew/opt/libffi/lib"
export CPPFLAGS="-I/opt/homebrew/opt/libffi/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig"
eval "$($HOME/.rbenv/bin/rbenv init - zsh)"
# alias load-rbenv='export LDFLAGS="-L/opt/homebrew/opt/libffi/lib" && export CPPFLAGS="-I/opt/homebrew/opt/libffi/include" && export PKG_CONFIG_PATH="/opt/homebrew/opt/libffi/lib/pkgconfig" && eval "$($HOME/.rbenv/bin/rbenv init - zsh)"'

###############################################################################
# Setup nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"
# alias load-nvm='export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh" && [ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"'

###############################################################################
# Setup pyenv
# export PYENV_ROOT="$HOME/.pyenv"
# export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init - zsh)"
# alias load-pyenv='export PYENV_ROOT="$HOME/.pyenv" && export PATH="$PYENV_ROOT/bin:$PATH" && eval "$(pyenv init - zsh)"'

###############################################################################
# Setup golang
export GOPATH="$HOME/Applications/go"
export PATH="$GOROOT/bin:$GOPATH/bin:$PATH"
[[ -s "/Users/chuhoangnam/.gvm/scripts/gvm" ]] && source "/Users/chuhoangnam/.gvm/scripts/gvm"

###############################################################################
# ZSH debugging
if [ -n "${ZSH_DEBUGRC+1}" ]; then
    zprof
fi

