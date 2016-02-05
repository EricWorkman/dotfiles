if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
export PATH="/usr/local/sbin:$PATH"
eval $(ssh-agent)
/usr/bin/ssh-add -K

alias vim="mvim -v"
alias vi="vim"

# PyEnv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
