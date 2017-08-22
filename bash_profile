if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi
export PATH="/usr/local/sbin:$PATH"
eval $(ssh-agent) >/dev/null 2>&1
/usr/bin/ssh-add -K >/dev/null 2>&1

alias vim="mvim -v"
alias vi="mvim -v"

# PyEnv
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Ruby
eval "$(rbenv init -)"

# Powerline
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source /Users/eworkman/.pyenv/versions/2.7.11/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh

# Postgres
alias postgres_start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias postgres_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

# Misc
alias weather="curl wttr.in/Lyndhurst"
alias cleardns="sudo killall -HUP mDNSResponder"
alias stayawake="sudo caffeinate -dims"

function title {
  printf "\033]0;%s\007" "$1"
}

