#!/bin/bash
# Merges Claude Code Stop hook (tmux window notification) into ~/.claude/settings.json
SETTINGS="$HOME/.claude/settings.json"
HOOK_CMD="$HOME/.claude/hooks/tmux-claude-done.sh"

[ ! -f "$SETTINGS" ] && echo '{}' > "$SETTINGS"

# Skip if already configured
if jq -e --arg cmd "$HOOK_CMD" '[.hooks.Stop[]?.hooks[]?.command] | any(. == $cmd)' "$SETTINGS" 2>/dev/null | grep -q true; then
  echo "Claude Code tmux Stop hook already configured"
  exit 0
fi

tmp=$(mktemp)
jq --arg cmd "$HOOK_CMD" '.hooks.Stop += [{"hooks": [{"type": "command", "command": $cmd}]}]' "$SETTINGS" > "$tmp" && mv "$tmp" "$SETTINGS"
echo "Claude Code tmux Stop hook configured"
