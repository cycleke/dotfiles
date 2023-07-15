#!/usr/bin/zsh

setopt extended_glob no_nomatch

declare -A deploy_to_roots=([pacman]=)

for i (^systemd(/)) {
    echo -n "deploying $i"
    if [[ ${deploy_to_roots[$i]-X} == ${deploy_to_roots[$i]} ]] {
        echo " to /"
        sudo stow "$i" --ignore=.others --target=/
    } else {
        echo " to $HOME"
        stow "$i" --ignore=.others --target=$HOME
    }
}
