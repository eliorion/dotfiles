# Dotfiles
This depo contain all personnel configuration file for zsh, git and vim. 

## Setup
The setup script use different packet manager to install, if necessary `zsh`, `vim`, and `Oh-My-Zsh`.
```bash
git clone https://github.com/skh/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

## Alias of zsh
| Shortcut  | Normal                         |
|:---------:|:-------------------------------|
| ll        | ls -alF                        |
| la        | ls -A                          |
| l         | ls -CF                         |
| gs        | git status                     |
| ga        | git add .                      |
| gc        | git commit -m                  |
| gac       | git add . && git commit -m     |
| gd        | git diff                       |
| gp        | git push                       |
| gl        | git log --oneline --graph --all|
| k         | kubectl                        |
| da        | direnv allow                   |