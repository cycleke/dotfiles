pack() {
    cdir=$(basename $(pwd))
    git archive --prefix=${cdir}-$(git rev-parse --short HEAD)/ -o ${cdir}.tar.gz HEAD
}

packzip() {
    cdir=$(basename $(pwd))
    git archive -o ${cdir}.zip HEAD
}

packzst() {
    cdir=$(basename $(pwd))
    git config tar.tar.zst.command "zstd"
    git archive --prefix=${cdir}-$(git rev-parse --short HEAD)/ -o ${cdir}.tar.zst HEAD
}
