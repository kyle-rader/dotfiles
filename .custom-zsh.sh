###############################################################################
# ALIASES
###############################################################################

# Docker
alias dc='docker-compose'
alias dc-stats='docker stats --format "table {{.Name}}\t{{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}"'
alias td='triton-docker'

# Heroku
alias hk='heroku'

# Git
alias gap='git add -p'
alias pull='git pull --prune'
alias push='git push'
alias gcm='git cs -m '
alias gitt='clear && git status'
alias gdel='git-delete-merged-branches'
alias gfp='git push --force-with-lease'
alias grb='git rebase -S'
alias puo='git push -u origin'

# make copy and move verbose
alias cp='cp -v'
alias mv='mv -v'

# more is less
alias more='less'

# tmux aliases, 'cuz typing is hard
alias tmn='tmux new-session -s'
alias tml='tmux list-sessions'
alias tma='tmux attach-session -t'

# use color and ANSI line graphics for tree
alias tree='tree -AC'

# use command -v instead of which
alias which='command -v'

# gpg is gpg2
alias gpg='gpg2'

# who wants to highlight, right-click, and copy all the time?
alias setclip='xclip -selection c'
alias getclip='xclip -selection c -o'

# Ruby Tools
alias be='bundle exec'
alias beg='spring stop && bundle exec guard'

# SSH To Places
alias wwu_cluster='ssh -p 922 cluster.cs.wwu.edu'
alias wwu_cs='ssh -p 922 linux.cs.wwu.edu'


###############################################################################
# Setup Languages
###############################################################################

# our custom scripts
export PATH="$HOME/.bin:$PATH"

# NVM - NodeJS
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# RBENV - Ruby
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# export NPM_AUTH_TOKEN="$(head -n 1 ~/.npmrc | sed "s/\/\/.*=//")"

# Rust (Rustup/ Cargo)
# export PATH="$PATH:$HOME/.cargo/bin"

# VirtualEnv Wrapper (Python)
# export WORKON_HOME=$HOME/.virtualenvs

# CUDA
#export PATH=/usr/local/cuda-8.0/bin${PATH:+:${PATH}}
#export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64"
#export CUDA_HOME=/usr/local/cuda

# added by Anaconda3 installer
# export PATH="/home/raderk/anaconda3/bin:$PATH"
