# Exa is an alternative for the ls command.
alias ls='exa'
# some more ls aliases
# -a, --all -- do not ignore entries starting with .
# -l -- use a long listing format
# -F, --classify -- append indicator (one of */=>@|) to entries
alias ll='ls -alF'
# -A, --almost-all -- do not list implied . and ..
#alias la='ls -A'
alias la='ls -a'
# -C -- list entries by columns
# -F, --classify -- append indicator (one of */=>@|) to entries
alias l='ls -CF'

alias rg='rg --smart-case'
alias spotify='spotify --force-device-scale-factor=2'
alias ts='tmuxinator start'
alias tns='trans -pager more --'
alias csd='cap staging deploy'
alias csr='cap staging puma:restart'
alias gpu='git push'
alias g='git'
alias please='sudo'

alias erb='erb -U'

function _guard_command () {
    if [ -e "bin/guard" ]; then
        bin/guard "$@"
    else
        command guard "$@"
    fi
}
alias guard='_guard_command'

function _rake_command () {
    if [ -e "bin/guard" ]; then
        bin/rake "$@"
    else
        command rake "$@"
    fi
}
alias rake='_rake_command'

function _rails_command () {
    if [ -e "bin/rails" ]; then
        bin/rails "$@"
    else
        command rails "$@"
    fi
}
alias rails='_rails_command'

if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform
    :
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under GNU/Linux platform
    alias open='xdg-open'
    # Add an "alert" alias for long running commands.  Use like so:
    #   sleep 10; alert
    alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
    alias disable-touchpad='xinput set-prop `xinput list | grep -i touchpad | cut -f 2 | grep -oE '[[:digit:]]+'` "Device Enabled" 0'
    alias enable-touchpad='xinput set-prop `xinput list | grep -i touchpad | cut -f 2 | grep -oE '[[:digit:]]+'` "Device Enabled" 1'
fi 
