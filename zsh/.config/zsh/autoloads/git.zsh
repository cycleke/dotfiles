#!/hint/zsh

alias g="git"

alias ga="git add"
alias gaa="git add --all"

alias gbl="git blame -w"

alias gb="git branch"
alias gba="git branch --all"
alias gbd="git branch --delete"
alias gbD="git branch --delete --force"
alias gbr="git branch --remote"

alias gco="git checkout"
alias gcor="git checkout --recurse-submodules"
alias gcb="git checkout -b"
alias gcB="git checkout -B"

alias gcp="git cherry-pick"
alias gcpa="git cherry-pick --abort"
alias gcpc="git cherry-pick --continue"

alias gcl="git clone --recurse-submodule"
alias gcl1="git clone --recurse-submodules --depth=1"

alias gfh="git fetch"
alias gfa="git fetch --all"

alias gc="git commit --verbose"
alias gc!="git commit --verbose --amend"
alias gca="git commit --verbose --all"
alias gca!="git commit --verbose --all --amend"

alias gd="git diff"
alias gdca="git diff --cached"
alias gdcw="git diff --cached --word-diff"
alias gds="git diff --staged"
alias gdw="git diff --word-diff"

alias glg="git log --stat"

alias gm="git merge"
alias gma="git merge --abort"
alias gmc="git merge --continue"
alias gms="git merge --squash"
alias gmff="git merge --ff-only"

alias gp="git push"
alias gl="git pull"
alias gpr="git pull --rebase"
alias gprv="git pull --rebase -v"

alias grb="git rebase"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias grbi="git rebase --interactive"

alias grbidev="git rebase --interactive dev"
alias grbirdev="git rebase --interactive origin/dev"

alias grbimain="git rebase --interactive main"
alias grbirmain="git rebase --interactive origin/main"

alias grbimaster="git rebase --interactive master"
alias grbirmaster="git rebase --interactive origin/master"

alias grf="git reflog"

alias gr="git remote"
alias grv="git remote --verbose"
alias gra="git remote add"
alias grrm="git remote remove"
alias grmv="git remote rename"
alias grset="git remote set-url"
alias grup="git remote update"

alias grh="git reset"
alias grhh="git reset --hard"
alias grhk="git reset --keep"
alias grhs="git reset --soft"

alias grs="git restore"
alias grss="git restore --source"
alias grst="git restore --staged"

alias grm="git rm"
alias grmc="git rm --cached"

alias gsh="git show"
alias gst="git status"
alias gss="git status --short"

alias gsta="git stash push"
alias gstl="git stash list"
alias gstp="git stash pop"
alias gstd="git stash drop"

alias gsw="git switch"
alias gswc="git switch --create"

alias gcid="git rev-parse --short HEAD"

alias gcls="git clone --recurse-submodules --sparse"
alias gclsfn="git clone --recurse-submodules --sparse --filter=blob:none"
alias gclsfm="git clone --recurse-submodules --sparse --filter=blob:limit=1m"
alias gsco="git sparse-checkout"

alias glfs="git lfs"

function g-shrink() {
  git reflog expire --expire-unreachable=now --all
  git fsck --full --unreachable
  git repack -A -d
  git gc --aggressive --prune=now
  git lfs prune
  git remote prune origin
}

# Pack the current HEAD.
pack() {
  cdir=$(basename $(pwd))
  git archive --prefix=${cdir}-$(git rev-parse --short HEAD)/ -o ${cdir}.tgz HEAD
}

packzip() {
  cdir=$(basename $(pwd))
  git archive -o ${cdir}.zip HEAD
}
