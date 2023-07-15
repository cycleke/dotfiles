path_prepend() {
    if [ -d "$1" ] && [[ ":$PATH:" != *":$1:"* ]]; then
        PATH="$1${PATH:+":$PATH"}"
    fi
}

path_prepend /sbin
path_prepend /bin
path_prepend /usr/sbin
path_prepend /usr/bin/
path_prepend /usr/local/bin
path_prepend $HOME/bin
path_prepend $HOME/.local/bin

export NPM_PACKAGES="${HOME}/.npm-global"
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
path_prepend $HOME/.npm-global/bin

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share

ZDOTDIR=$XDG_CONFIG_HOME/zsh

export EDITOR="emacsclient -c -a \"\""
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS="@im=fcitx5"

export RUSTUP_DIST_SERVER=https://mirrors.ustc.edu.cn/rust-static
export RUSTUP_UPDATE_ROOT=https://mirrors.ustc.edu.cn/rust-static/rustup
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"

[ -f /opt/homebrew/bin/brew ] && eval $(/opt/homebrew/bin/brew shellenv)

export DEFAULT_USER="yagoguo"

# Local Variables:
# mode: sh
# End:
