# Shortcuts for editor and pager
alias m=$PAGER

# Shortcut for making dirs recursively
alias md='mkdir -p'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias ~='cd ~'

# Open as many windows as many files passed
alias vim='vim -o'

# Shortcut to open Finder in current folder
alias f='open -a Finder'

if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
else
    export LSCOLORS="exfxcxdxbxegedabagacad"
fi

# LS flags:
# h - human readable sizes
# F - show trailing `/` for dirs, `*` for executables and so on
# G - enable colorized output
# A - show hidden files (except . and ..)
alias ls='ls -hFGA'
alias ll='ls -l'
alias la='ls -l'
alias l='ls'

alias please='sudo'

# Git utils
alias gs='git status -sb'
alias ga='git add' && __git_complete ga _git_add
alias gap='git add -p' && __git_complete gap _git_add
alias gb='git branch' && __git_complete gb _git_branch
alias gt='git tag' && __git_complete gt _git_tag
alias gi='git commit' && __git_complete gi _git_commit
alias gam='git commit --amend'
alias gm='git merge --no-ff' && __git_complete gm _git_merge
alias gmf='git merge --ff-only' && __git_complete gmf _git_merge

# Personal aliases
alias gitstash='for dir in $(find . -name ".git"); do cd ${dir%/*}; git stash && git pull ; cd -; done'
alias brewu='brew update && brew upgrade && brew cleanup --cache'

alias gd='git diff'
# Git diff parent
alias gdp='git diff HEAD^'

# Staged changes
alias gds='git diff --staged'
alias gdc='git diff --cached'

# Checkout shortcuts
alias go='git checkout' && __git_complete go _git_checkout
alias god='go dev'
alias gom='go master'
alias gor='go release'

alias gl='git lol'
alias gh='git hist'

# Git remotes
alias gr='git remote -v'
alias gf='git fetch'
alias gfu='git fetch upstream'
alias gfp='git fetch --prune'
alias gfpu='git fetch --prune upstream'
alias grh='git reset --hard'

# Reset current branch to its origin state
alias grho='git reset --hard origin/`gbc`'

# Pull changes without merge
alias gpf='git pull --ff-only'
alias gpfu='git pull --ff-only upstream'

# Pull changes and rebase local commits
alias gpr='git pull --rebase'
alias gpru='git pull --rebase upstream'

# Push current branch and setup upstream
alias gpc='git push -u origin `gbc`'
# Force push current branch
alias gpcf='git push -u origin +`gbc`'

# Rebase
alias grc='git rebase --continue'
alias gra='git rebase --abort'
alias grs='git rebase --skip'

# Cherry-picking
alias gcp='git cherry-pick ' && __git_complete gcp _git_cherry_pick
alias gcpa='git cherry-pick --abort'

# Go to dev and update it (git update dev)
alias gud='god && gpf'

# Rebase on dev (or master) branch
alias grd='git rebase dev'
alias grid='git rebase -i dev'
alias grm='git rebase master'
alias grim='git rebase -i master'

alias gsh='git show ' && __git_complete gsh _git_show
alias ghs='git hash'
alias gbc='git rev-parse --abbrev-ref HEAD' # git-branch-current
alias gsd='git show -s --format="%ci"' # git-show-date

# Show merge-base from dev
alias grf='git merge-base dev `gbc`' # WAT?
# git branch set upstream to origin/<current-branch-name>
alias gbsu='git branch -u origin/`gbc`'

# Execute on feature branch.
# Updates dev (or master) and then rebases current branch
alias gudc='god && gpf && go - && grd'
alias gumc='gom && gpf && go - && grm'

# git-svn aliases
alias gog='go git-svn'
alias gsr='git svn rebase'
alias gsrb='git rebase git-svn'
alias gugc='gog && gsr && go - && gsrb'
alias gsc='git svn dcommit'

# defunkt hub alias
if [[ `which hub` != '' ]]; then
    alias git='hub'
    alias gbr='git browse'
    alias gbri='git browse -- issues'
    alias gbrn='git browse -- network'
fi

# npm
alias ni='npm install'
alias nis='npm install --save'
alias nid='npm install --save-dev'
alias nig='npm install --global'
alias nt='npm test'
alias nit='npm install && npm test'
alias nk='npm link'
alias nr='npm run'
alias nf='npm cache clean && rm -rf node_modules && npm install'

# .profile utils
alias sp='source ~/.profile'
