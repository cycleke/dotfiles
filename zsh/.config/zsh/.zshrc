# 为 Emacs Tramp
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

# p10k instant prompt
# 可取代 zplugin turbo mode
if [[ -r "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "$XDG_CACHE_HOME/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Zplugin 初始化
typeset -A ZINIT=(
  BIN_DIR $ZDOTDIR/zinit/bin
  HOME_DIR $ZDOTDIR/zinit
  COMPINIT_OPTS -C
)

source $ZDOTDIR/zinit/bin/zinit.zsh

# 补全配置
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# 历史文件
export HISTFILE=$ZDOTDIR/.histfile
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY

# forgit
forgit_add=gai
forgit_diff=gdi
forgit_log=glgi
forgit_checkout_file=gcfi
forgit_blame=gbli

# 加载插件
zinit wait="0" lucid light-mode for \
  wfxr/forgit

zinit light-mode for \
  blockf \
  zsh-users/zsh-completions \
  src="etc/git-extras-completion.zsh" \
  tj/git-extras

zinit wait="1" lucid for \
  OMZL::clipboard.zsh \
  OMZL::git.zsh \
  OMZL::history.zsh \
  OMZP::git/git.plugin.zsh \
  OMZP::sudo/sudo.plugin.zsh \
  OMZP::extract/extract.plugin.zsh \
  OMZP::copyfile/copyfile.plugin.zsh

zinit as="completion" for \
  OMZP::rust/_rustc \
  OMZP::fd/_fd

zinit light-mode for \
  zsh-users/zsh-autosuggestions

zinit load atuinsh/atuin

# 杂乱文件
for i in $XDG_CONFIG_HOME/zsh/snippets/*.zsh; do
  source $i
done

# 加载 fzf
if [ -f ~/.fzf.zsh ]; then
  export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  source ~/.fzf.zsh
fi

# 加载 zoxide
if type zoxide &>/dev/null; then
  export _ZO_RESOLVE_SYMLINKS=1
  eval "$(zoxide init zsh --cmd j)"
fi

# 加载 atuin
if type atuin &>/dev/null; then
  eval "$(atuin init zsh)"
fi

# 加载主题
source $ZDOTDIR/p10k.zsh
zinit ice depth=1
zinit light romkatv/powerlevel10k
