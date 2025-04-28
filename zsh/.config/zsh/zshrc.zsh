zinit ice depth"1"
zinit light QuarticCat/zsh-smartcache

zinit ice depth"1"
zinit wait lucid light-mode for \
    hlissner/zsh-autopair \
    atinit"AUTOCD=1" \
    z-shell/zsh-eza

if [[ "$OSTYPE" == darwin* ]]; then
    zinit ice depth"1"
    zinit wait lucid light-mode for \
        zshzoo/macos
fi

zinit ice from"gh-r" as "program" depth"1"
zinit light decayofmind/zsh-fast-alias-tips

## LS color, defined esp. for cd color, 'cause exa has its own setting
export CLICOLOR=1
export LSCOLORS=ExGxFxdaCxDaDahbadeche

# 加载 Homebrew
if [ -f /opt/homebrew/bin/brew ]; then
    eval $(/opt/homebrew/bin/brew shellenv)
fi

# Rust 配置
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
export CARGO_UNSTABLE_SPARSE_REGISTRY=true
[[ -f ${HOME}/.cargo/env ]] && source ${HOME}/.cargo/env

# Golang 配置
if type go &>/dev/null; then
    path+=(${HOME}/go/bin)

    # Lazy loading
    go() {
        unfunction "$0"

        go env -w GO111MODULE=on
        go env -w GOPROXY=https://goproxy.cn,direct

        $0 "$@"
    }
fi

fpath+=(${ZDOTDIR}/functions ${ZDOTDIR}/completions)

function zwc() {
    local file=$1
    if [[ ! -f "${file}.zwc" || "${file}" -nt "${file}.zwc" ]]; then
        zcompile -Uz "${file}"
    fi
    builtin source ${file}
}

autoload -Uz ${ZDOTDIR}/functions/*(:t)
for file in ${ZDOTDIR}/autoloads/*.zsh; do
    zwc ${file}
done

if [[ -d ${ZDOTDIR}/custom/completions ]]; then
    fpath+=(${ZDOTDIR}/custom/completions)
fi

if [[ -d ${ZDOTDIR}/custom/functions ]]; then
    fpath+=(${ZDOTDIR}/custom/functions)
    autoload -Uz ${ZDOTDIR}/custom/functions/*(:t)
fi

if [[ -d ${ZDOTDIR}/custom/autoloads ]]; then
    for file in ${ZDOTDIR}/custom/autoloads/*.zsh; do
        zwc ${file}
    done
fi

# 加载补全
zpcompinit
zpcdreplay

# 加载 fzf
if [[ -f ${HOME}/.fzf.zsh ]]; then
    export FZF_DEFAULT_COMMAND="fd --type f --strip-cwd-prefix"
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    source ${HOME}/.fzf.zsh
fi

# 加载 zoxide
if type zoxide &>/dev/null; then
    export _ZO_RESOLVE_SYMLINKS=1
    smartcache eval zoxide init zsh --cmd j
fi

# 加载 atuin
if type atuin &>/dev/null; then
    smartcache eval atuin init zsh
fi

# 加载 carapace
if type carapace &>/dev/null; then
    export CARAPACE_BRIDGES="zsh,fish,bash,inshellisense"
    zstyle ":completion:*:git:*" group-order "main commands" "alias commands" "external commands"
    source <(carapace _carapace)
fi

# 由于这些插件包裹了 zle，需要放在最后加载
zinit ice depth"1"
zinit wait lucid light-mode for \
    zdharma-continuum/fast-syntax-highlighting \
    blockf atpull"zinit creinstall -q ." \
    zsh-users/zsh-completions \
    Aloxaf/fzf-tab

# Load powerlevel10k theme
zinit ice depth"1"
zinit light romkatv/powerlevel10k
[[ ! -f ${ZDOTDIR}/p10k.zsh ]] || source ${ZDOTDIR}/p10k.zsh
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/p10k.zsh.

# 配置 fzf-tab
zstyle ":completion:*:git-checkout:*" sort false
zstyle ":completion:*:descriptions" format "[%d]"
zstyle ":completion:*" menu no
zstyle ":completion:*" verbose yes
zstyle ":fzf-tab:complete:kill:argument-rest" fzf-preview "ps --pid=$word -o cmd --no-headers -w -w"
zstyle ":fzf-tab:complete:kill:argument-rest" fzf-flags "--preview-window=down:3:wrap"
zstyle ":fzf-tab:complete:kill:*" popup-pad 0 3
zstyle ":fzf-tab:complete:cd:*" fzf-preview "eza -1 --color=always $realpath"
zstyle ":fzf-tab:complete:cd:*" popup-pad 30 0
zstyle ":fzf-tab:*" fzf-flags --color=bg+:23
zstyle ":fzf-tab:*" switch-group "<" ">"

# 配置 zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion ${ZSH_AUTOSUGGEST_STRATEGY})
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_COMPLETION_IGNORE='( |man |yum )*'
