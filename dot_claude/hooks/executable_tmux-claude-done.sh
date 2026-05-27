#!/bin/bash
# Called by Claude Code Stop hook — prefixes tmux window name with ✓ to signal task done
[ -z "$TMUX_PANE" ] && exit 0
W=$(tmux display-message -p -t "$TMUX_PANE" '#W')
case "$W" in
  "✓ "*) ;;
  *) tmux rename-window -t "$TMUX_PANE" "✓ $W" ;;
esac
