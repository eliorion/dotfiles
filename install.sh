#!/bin/bash

set -euo pipefail

if ! command -v chezmoi >/dev/null; then
    sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/eliorion/dotfiles.git
fi

chezmoi apply

/scripts/setup || true


echo "=== Installation terminée ==="

exit 0
