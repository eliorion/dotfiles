#!/bin/bash
# statusline wrapper: caveman badge + context-window usage + session cost.
# Reads Claude Code session JSON on stdin, prints one status line.
# Wired in ~/.claude/settings.json -> statusLine.command.

input=$(cat)

CFG="${CLAUDE_CONFIG_DIR:-$HOME/.claude}"

# Caveman badge first — it reads its own flag file and ignores stdin.
[ -f "$CFG/hooks/caveman-statusline.sh" ] && bash "$CFG/hooks/caveman-statusline.sh" </dev/null

# No jq -> just the caveman badge, no crash.
command -v jq >/dev/null 2>&1 || exit 0

IFS=$'\t' read -r PCT USED SIZE DUR_MS CWD FIVEH FIVEH_R SEVD SEVD_R < <(printf '%s' "$input" | jq -r '
  [ (.context_window.used_percentage // 0 | floor),
    ((.context_window.total_input_tokens // 0) + (.context_window.total_output_tokens // 0)),
    (.context_window.context_window_size // 200000),
    (.cost.total_duration_ms // 0),
    (.workspace.current_dir // .cwd // ""),
    (.rate_limits.five_hour.used_percentage // -1 | floor),
    (.rate_limits.five_hour.resets_at // 0),
    (.rate_limits.seven_day.used_percentage // -1 | floor),
    (.rate_limits.seven_day.resets_at // 0)
  ] | @tsv')

# Git branch from the session's working dir (not in stdin JSON).
BRANCH=""
[ -n "$CWD" ] && BRANCH=$(git -C "$CWD" branch --show-current 2>/dev/null)

DIM='\033[2m'; RST='\033[0m'

# Tokens -> "16.7k" style.
fmt_k() { awk -v n="$1" 'BEGIN{ if(n<1000){printf "%d",n} else {k=n/1000; if(k==int(k)) printf "%dk",k; else printf "%.1fk",k} }'; }
USED_K=$(fmt_k "$USED")
SIZE_K=$(fmt_k "$SIZE")

# Countdown epoch->now -> "1h39m" / "2d3h" / "12m". Empty if past/0.
NOW=$(date +%s)
fmt_eta() {
  local d=$(( $1 - NOW )); [ "$d" -le 0 ] && return
  if   [ "$d" -ge 86400 ]; then printf '%dd%dh' $(( d/86400 )) $(( (d%86400)/3600 ))
  elif [ "$d" -ge 3600  ]; then printf '%dh%dm' $(( d/3600 ))  $(( (d%3600)/60 ))
  else printf '%dm' $(( d/60 )); fi
}
# Rate-limit window segment: "5h 23% (1h39m)", colored by usage % (absent for non-Pro/Max).
rl_seg() {
  local label=$1 pct=$2 reset=$3 col eta
  [ "$pct" -ge 0 ] 2>/dev/null || return
  if   [ "$pct" -lt 50 ]; then col=35
  elif [ "$pct" -lt 80 ]; then col=178
  else col=196; fi
  eta=$(fmt_eta "$reset")
  if [ -n "$eta" ]; then
    printf " ${DIM}·${RST} \033[38;5;%sm%s %s%%${RST} ${DIM}(%s)${RST}" "$col" "$label" "$pct" "$eta"
  else
    printf " ${DIM}·${RST} \033[38;5;%sm%s %s%%${RST}" "$col" "$label" "$pct"
  fi
}
FIVEH_SEG=$(rl_seg 5h "$FIVEH" "$FIVEH_R")
SEVD_SEG=$(rl_seg 7d "$SEVD" "$SEVD_R")

# Elapsed wall-clock -> Hh Mm / Mm / Ss.
SEC=$(( DUR_MS / 1000 ))
if   [ "$SEC" -ge 3600 ]; then ELAPSED="$(( SEC/3600 ))h$(( (SEC%3600)/60 ))m"
elif [ "$SEC" -ge 60   ]; then ELAPSED="$(( SEC/60 ))m"
else ELAPSED="${SEC}s"; fi

# Context color: <50 green, <80 yellow, else red.
if   [ "$PCT" -lt 50 ]; then CCOL=35
elif [ "$PCT" -lt 80 ]; then CCOL=178
else CCOL=196; fi

BSEG=""
[ -n "$BRANCH" ] && BSEG=$(printf " ${DIM}·${RST} \033[38;5;39m⎇ %s${RST}" "$BRANCH")

printf "%b ${DIM}·${RST} \033[38;5;%smctx %s%% (%s/%s)${RST}%b%b ${DIM}·${RST} %s" \
  "$BSEG" "$CCOL" "$PCT" "$USED_K" "$SIZE_K" "$FIVEH_SEG" "$SEVD_SEG" "$ELAPSED"
