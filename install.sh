#!/bin/bash

set -euo pipefail

if ! command -v chezmoi >/dev/null; then

    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:eliorion/dotfiles.git
fi

~/.local/share/chezmoi/bin/chezmoi apply

exit 0
