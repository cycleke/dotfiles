#!/hint/zsh

function dsf() {
    diff -u $@ | delta
}

function path() {
    echo ${PATH} |
        tr ":" "\n" |
        awk "{ sub(\"/usr\",   \"$fg_no_bold[green]/usr$reset_color\"); \
           sub(\"/bin\",   \"$fg_no_bold[blue]/bin$reset_color\"); \
           sub(\"/opt\",   \"$fg_no_bold[cyan]/opt$reset_color\"); \
           sub(\"/sbin\",  \"$fg_no_bold[magenta]/sbin$reset_color\"); \
           sub(\"/local\", \"$fg_no_bold[yellow]/local$reset_color\"); \
           print }"
}

function any() {
    emulate -L zsh
    unsetopt KSH_ARRAYS
    if [[ -z "$1" ]]; then
        echo "any - grep for process(es) by keyword" >&2
        echo "Usage: any " >&2
        return 1
    else
        ps xauwww | rg -i --color=auto "[${1[1]}]${1[2,-1]}"
    fi
}

function precmd() {
    # Put the string "hostname::/full/directory/path" in the title bar:
    echo -ne "\e]2;$PWD\a"

    # Put the parentdir/currentdir in the tab
    echo -ne "\e]1;$PWD:h:t/$PWD:t\a"
}
