# python
alias py2='python2'
alias py='python3' py3='python3' ipy='ipython3' ipy3='ipython3'

# tmux
alias ta='tmux attach -t'
alias tad='tmux attach -d -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'
alias tksv='tmux kill-server'
alias tkss='tmux kill-session -t'

# trash
alias rm='trash-put' rt='trash-restore' re='trash-empty' rl='trash-list'

# git
alias gcls='git clone --recurse-submodules --sparse'
alias gclsfn='git clone --recurse-submodules --sparse --filter=blob:none'
alias gclsfm='git clone --recurse-submodules --sparse --filter=blob:limit=1m'
alias gsco='git sparse-checkout'

# 杂七杂八
alias reload='source $ZDOTDIR/.zshrc'
alias h='tldr'
alias vi='nvim'
alias rgc='rg --color=always'
alias rgcn='rg --color=always -n'
alias rgcin='rg --color=always -in'
alias ea='emacsclient -c -a ""'
alias e='emacsclient -t -a ""'
alias hdu='du -sk -- * | sort -n | perl -pe '\''@SI=qw(K M G T P); s:^(\d+?)((\d\d\d)*)\s:$1." ".$SI[((length $2)/3)]."\t":e'\'''
