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
