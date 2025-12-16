#!/usr/bin/env bash
set -e

echo "→ Configuring Linux keyboard (FR layout, Windows keyboard)"

# Only apply in graphical sessions
if [[ -z "$DISPLAY" && -z "$WAYLAND_DISPLAY" ]]; then
  echo "→ No graphical session detected, skipping keyboard setup"
  exit 0
fi

# Ensure required tools exist
if ! command -v setxkbmap >/dev/null 2>&1; then
  echo "→ setxkbmap not available, skipping keyboard layout setup"
  exit 0
fi

# ---- Keyboard layout ----
# fr        → French AZERTY
# oss       → Windows-style AltGr symbols (€, etc.)
# caps:ctrl_modifier → Caps Lock becomes Control (common on Windows keyboards)
# lv3:ralt_switch    → Right Alt (AltGr) works properly

setxkbmap \
  -layout fr \
  -variant oss \
  -option caps:ctrl_modifier \
  -option lv3:ralt_switch

# ---- Key repeat behavior (X11 only) ----
if [[ -n "$DISPLAY" ]] && command -v xset >/dev/null 2>&1; then
  # Delay before repeat (ms), repeat rate (per second)
  xset r rate 250 40
fi

echo "✓ Keyboard configured: FR (AZERTY), Windows keyboard"