zinit ice depth"1"
zinit light QuarticCat/zsh-smartcache

zinit ice depth"1"
zinit wait lucid light-mode for \
    hlissner/zsh-autopair \
    atinit"AUTOCD=1" \
    z-shell/zsh-eza \
    zshzoo/macos

zinit ice from"gh-r" as "program" depth"1"
zinit light decayofmind/zsh-fast-alias-tips

zinit wait lucid for \
    OMZL::clipboard.zsh \
    OMZP::sudo/sudo.plugin.zsh \
    OMZP::extract/extract.plugin.zsh \
    OMZP::copyfile/copyfile.plugin.zsh \
    OMZP::colored-man-pages/colored-man-pages.plugin.zsh

# 加载 Homebrew
if [ -f /opt/homebrew/bin/brew ]; then
    eval $(/opt/homebrew/bin/brew shellenv)
fi

# 加载补全
fpath+=(${ZDOTDIR}/functions ${ZDOTDIR}/completions)
zpcompinit
zpcdreplay

# 自己写的脚本
autoload -Uz ${ZDOTDIR}/functions/*(:t)
for file in ${ZDOTDIR}/autoloads/*.zsh; do
    source ${file}
done

# Rust 配置
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"
export CARGO_UNSTABLE_SPARSE_REGISTRY=true
[[ -f ${HOME}/.cargo/env ]] && source ${HOME}/.cargo/env

# Golang 配置
if type go &>/dev/null; then
    go env -w GO111MODULE=on
    go env -w GOPROXY=https://goproxy.cn,direct
    path+=(${HOME}/go/bin)
fi

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
[[ ! -f ${ZDOTDIR}/.p10k.zsh ]] || source ${ZDOTDIR}/.p10k.zsh
# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.

# 配置 fzf-tab
zstyle ":completion:*:git-checkout:*" sort false
zstyle ":completion:*:descriptions" format "[%d]"
zstyle ":completion:*" menu no
zstyle ":fzf-tab:complete:kill:argument-rest" fzf-preview "ps --pid=$word -o cmd --no-headers -w -w"
zstyle ":fzf-tab:complete:kill:argument-rest" fzf-flags "--preview-window=down:3:wrap"
zstyle ":fzf-tab:complete:kill:*" popup-pad 0 3
zstyle ":fzf-tab:complete:cd:*" fzf-preview "eza -1 --color=always $realpath"
zstyle ":fzf-tab:complete:cd:*" popup-pad 30 0
zstyle ":fzf-tab:*" fzf-flags --color=bg+:23
zstyle ":fzf-tab:*" switch-group "<" ">"
