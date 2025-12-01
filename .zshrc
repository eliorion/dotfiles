# === Oh-My-Zsh ===
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="risto"
plugins=(git docker kubectl podman direnv)

# Source Oh-My-Zsh
if [ -f $ZSH/oh-my-zsh.sh ]; then
    source $ZSH/oh-my-zsh.sh
fi

# === Direnv hook ===
eval "$(direnv hook zsh)"

# === Aliases utiles ===
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias gs='git status'
alias gd='git diff'
alias gp='git push'
alias gl='git log --oneline --graph --all'
alias k='kubectl'

# === Prompt info ===
#export PROMPT='$(git_prompt_info) %F{green}%n@%m%f %F{blue}%~%f
#%  > '