# Dotfiles
This depo contain all personnel configuration file for zsh, git and vim. 

## Setup
The setup script use different packet manager to install, if necessary `zsh`, `vim`, and `Oh-My-Zsh`.
```bash
git clone https://github.com/KharitonoffSamuel/dotfiles.git ~/dotfiles
cd ~/dotfiles
./setup.sh
```

## ZSH plugins
[Oh-My-Zsh repository](https://github.com/ohmyzsh/ohmyzsh)
### Git
[Alias git plugin](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git)
### Kubernetes
[Alias kubernetes plugin]()
### Direnv
[Alias direnv plugin]()


## Alias of zsh
| Shortcut  | Normal                         |
|:---------:|:-------------------------------|
| ll        | ls -alF                        |
| la        | ls -A                          |
| l         | ls -CF                         |
| k         | kubectl                        |
| da        | direnv allow                   |