# Env Var Exports
export GPG_TTY=$(tty)
export LANG=en_US.UTF-8

source "$HOME/.cargo/env"

# ZSH Completions
fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

# Init Starship Prompt
eval "$(starship init zsh)"

# Active RTX
eval "$(rtx activate zsh)"

# Aliases
alias c=cargo
alias la="ls -la"
alias l="ls -l"
alias gpg=gpg2