# XDG Base Directory Specification
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache

export ZDOTDIR=${XDG_CONFIG_HOME}/zsh

typeset -U path
path=(
    ${HOME}/.local/bin
    /usr/local/bin
    /usr/local/sbin
    /usr/bin
    /usr/sbin
    /bin
    /sbin
)

export DEFAULT_USER="cycleke"

# Local Variables:
# mode: sh
# End:
