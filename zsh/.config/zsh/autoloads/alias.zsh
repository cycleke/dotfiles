# python
alias py2="python2"
alias python="python3" ipython="ipython3"
alias py="python3" py3="python3" ipy="ipython3" ipy3="ipython3" pip="pip3"

# trash
alias rm="trash-put" rm-r="trash-restore" rm-e="trash-empty" rm-l="trash-list"

# misc
alias h="tldr"
alias vi="nvim"
alias xhd="xh --download"
alias kssh="kitty +kitten ssh"

alias re="source ${ZDOTDIR}/.zshrc"
function ra() {
    for file in ${ZDOTDIR}/autoloads/*.zsh; do
        echo "\033[32m 重新加载 $file\033[0m"
        source $file
    done
}

function dsf() {
    diff -u $@ | delta
}

alias -s gz="tar -xzvf"
alias -s tgz="tar -xzvf"
alias -s zip="unzip"
alias -s bz2="tar -xjvf"

alias -s h=nvim
alias -s hpp=nvim
alias -s cc=nvim
alias -s cpp=nvim
alias -s rs=nvim
