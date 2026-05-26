# Dotfiles

Personal configuration for workstations and devcontainers. Managed with [chezmoi](https://chezmoi.io).

## Bootstrap

```bash
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply https://github.com/eliorion/dotfiles.git
```

Installs chezmoi and applies all dotfiles to `~/`.

## Tools

Managed via [mise](https://mise.jdx.dev):

| Tool | Purpose |
|------|---------|
| neovim | Editor |
| tmux | Terminal multiplexer |
| starship | Shell prompt |
| lazygit | Git TUI |
| bat, fd, fzf, ripgrep | CLI utilities |
| direnv | Environment management |
| uv | Python toolchain |
| node | JavaScript runtime |

## Devcontainer setup

`devcontainer.json` runs `scripts/setup` on container creation:

1. **mise** — installs all tools
2. **Claude Code** — AI coding assistant
3. **RTK** — token-optimizing proxy for Claude Code (`rtk init -g --auto-patch`)
4. **Caveman** — Claude Code plugin for compressed output
5. **Graphify** — knowledge graph for the workspace (`graphify claude install`)
6. **graphify update .** — builds AST graph of the workspace on first boot

## Claude Code

Global instructions live in `dot_claude/CLAUDE.md` (deployed to `~/.claude/CLAUDE.md`):
- Imports `RTK.md` for token-saving command reference
- Defines 4 coding principles: Think Before Coding, Simplicity First, Surgical Changes, Goal-Driven Execution

Project-specific instructions are generated per repo with `claude init`.

Skills can be added to `dot_claude/skills/<name>/SKILL.md` — propagated to all machines via chezmoi.

## Graphify

Builds a knowledge graph of the current workspace on devcontainer boot.
- `graphify-out/` is gitignored (rebuilt per machine, per workspace)
- Run `/graphify --update` in Claude Code to add semantic layer after first boot
- `graphify update .` in a project to refresh after code changes
