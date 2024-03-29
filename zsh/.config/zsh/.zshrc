# 为 Emacs Tramp
[[ $TERM == "dumb" ]] && unsetopt zle && PS1='$ ' && return

source ~/.config/zsh/zinit/bin/zinit.zsh

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

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1

forgit_add=gai
forgit_diff=gdi
forgit_log=glgi

ZSHZ_DATA=$ZDOTDIR/.z

# 历史文件
export HISTFILE=$ZDOTDIR/.histfile
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME
setopt EXTENDED_HISTORY

zinit wait="1" lucid light-mode for \
	wfxr/forgit

zinit light-mode for \
	blockf \
	zsh-users/zsh-completions \
	src="etc/git-extras-completion.zsh" \
	tj/git-extras

zinit wait="1" lucid for \
	OMZ::lib/clipboard.zsh \
	OMZ::lib/git.zsh \
	OMZ::lib/history.zsh \
	OMZ::plugins/git/git.plugin.zsh \
	OMZ::plugins/sudo/sudo.plugin.zsh \
	OMZ::plugins/extract/extract.plugin.zsh \
	OMZ::plugins/copyfile/copyfile.plugin.zsh

zinit light-mode for \
	zdharma-continuum/fast-syntax-highlighting \
	zsh-users/zsh-autosuggestions \
	zpm-zsh/ls \
	SukkaW/zsh-proxy

# 杂乱文件
for i in $XDG_CONFIG_HOME/zsh/snippets/*.zsh; do
	source $i
done

autoload -U compinit && compinit

# 加载 fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# 加载 zoxide
if type zoxide &>/dev/null; then
	eval "$(zoxide init zsh)"
fi

# 加载主题
source $ZDOTDIR/p10k.zsh
zinit ice depth=1
zinit light romkatv/powerlevel10k
