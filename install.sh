#!/bin/bash

set -euo pipefail

if ! command -v chezmoi >/dev/null; then

    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/eliorion/dotfiles.git -b $HOME/.local/bin 
fi

$HOME/.local/bin/chezmoi apply

exit 0
