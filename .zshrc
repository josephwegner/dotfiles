# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="mh-custom"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration
export GOPATH=$HOME/Code/go
export PATH="/Users/josephwegner/.rvm/gems/ruby-2.0.0-p451@user_events_service/bin:/Users/josephwegner/.rvm/gems/ruby-2.0.0-p451@global/bin:/Users/josephwegner/.rvm/rubies/ruby-2.0.0-p451/bin:/Users/josephwegner/.rvm/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/git/bin:/usr/local/MacGPG2/bin:/usr/local/go/bin:$GOPATH/bin"
# export MANPATH="/usr/local/man:$MANPATH"

# Run direnv
eval "$(direnv hook zsh)"

# Read .rvmrc
rvm_project_rvmrc=1
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# Third Party Junk
. `brew --prefix`/etc/profile.d/z.sh

# Porting over stuff from .bash_profile

alias sm="git pull upstream master && git push origin master"
export ANDROID_HOME="/Applications/android-sdk"

# DuckDuckHack Setup
eval $(perl -I${HOME}/perl5/lib/perl5 -Mlocal::lib)

# Prompt Command
DISABLE_AUTO_TITLE="true"
precmd () {
  echo -ne "\e]2;${PWD/${HOME}/\~}\a"
  echo -ne "\e]1;${PWD##*/}\a"
}
preexec() {
  echo -ne "\e]1;${PWD##*/}/${1[(wr)^(*=*|sudo|ssh|rake|-*)]:gs/%/%%}\a"
}

# Docker Setup
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/josephwegner/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1
