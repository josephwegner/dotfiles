PS1="\u@\h 😱   \W: "

export HISTSIZE=50000

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

export EDITOR=/usr/bin/vim

source ~/.profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

alias nw="~/Applications/node-webkit.app/Contents/MacOS/node-webkit"
alias sm="git pull upstream master && git push origin master"
alias gpom="git pull origin master"
alias gpum="git pull upstream master"
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
. "$HOME/.cargo/env"

# Initialize Starship prompt
eval "$(starship init bash)"
export STARSHIP_CONFIG="$HOME/.config/starship.toml"
# devbar-managed-start
export NODE_EXTRA_CA_CERTS="$HOME/.devbar/certs/corporate-ca-bundle.pem"
# devbar-managed-end

# >>> aisuite >>>
export NODE_EXTRA_CA_CERTS="/Users/joseph.wegner/.aisuite/conf/npm-sfdc-certs.pem"
export PATH="$PATH:/Users/joseph.wegner/.aisuite/bin:/Users/joseph.wegner/.aisuite/bin/aliases"
# <<< aisuite <<<

# >>> mhtc-telemetry >>>
export PATH='/Users/joseph.wegner/.mh-telemetry-collector-aisuite/telemetry/opencode-shim':"$PATH"
# <<< mhtc-telemetry <<<

# codex-terminal-managed-start
export TERMINAL_HOST_LABEL=mac
HISTSIZE=50000
HISTFILESIZE=100000
HISTCONTROL=ignoreboth:erasedups
shopt -s histappend checkwinsize
# codex-terminal-managed-end
