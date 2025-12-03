#!/bin/bash
set -e

echo "=== Installation des dépendances (zsh, vim) ==="

install_if_missing() {
    local pkg="$1"
    local check="$2"

    if ! command -v "$check" >/dev/null 2>&1; then
        echo "Installation de $pkg..."

        if command -v apt-get >/dev/null 2>&1; then
            sudo apt-get update -y
            sudo apt-get install -y "$pkg"
        elif command -v dnf >/dev/null 2>&1; then
            sudo dnf install -y "$pkg"
        elif command -v brew >/dev/null 2>&1; then
            brew install "$pkg"
        else
            echo "Impossible d’installer $pkg : gestionnaire de paquets inconnu."
            exit 1
        fi
    else
        echo "$pkg déjà installé."
    fi
}

install_if_missing "zsh" "zsh"
install_if_missing "vim" "vim"

echo "=== Installation d'Oh-My-Zsh ==="
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "Oh-My-Zsh déjà installé."
fi

echo "=== Copie des dotfiles ==="
cp .zshrc ~/.zshrc
cp .gitconfig ~/.gitconfig
cp .vimrc ~/.vimrc

echo "=== Configuration du shell par défaut (zsh) ==="
if [ "$SHELL" != "/bin/zsh" ] && [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s "$(which zsh)" || echo "Impossible de changer le shell automatiquement."
fi

echo "=== Installation terminée ==="