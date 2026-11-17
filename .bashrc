
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"
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
if [[ $- == *i* ]]; then
  export PATH="/opt/homebrew/bin:$PATH"
  export TERMINAL_HOST_LABEL=mac
  export STARSHIP_CONFIG="$HOME/.config/starship.toml"
  export EDITOR=vim
  HISTSIZE=50000
  HISTFILESIZE=100000
  HISTCONTROL=ignoreboth:erasedups
  shopt -s histappend checkwinsize
  set -o vi
  bind '"\C-r": reverse-search-history'
  if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
  fi
fi
# codex-terminal-managed-end
