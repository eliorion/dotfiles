#!/bin/bash
# Called by tmux window-focus-in hook — strips ✓ prefix when switching to a window
W=$(tmux display-message -p '#W')
case "$W" in
  "✓ "*) tmux rename-window "${W#✓ }" ;;
esac
