# Everyday commands

Day-to-day commands for this setup only. Not a reference — each tool has `--help`
for the rest.

Leader key in Neovim is `Space`. tmux prefix is `C-b`.

---

## A typical day

```bash
tmux                              # or attach: tmux a
# C-b O                           → pick a repo, get its session
cd ~/org/api                      # (or let C-b O do it)
devpod up . --ide none            # start the container
workmux add fix-login             # worktree + window + agent in the container
# ... agent works, you review ...
workmux merge fix-login           # merge, then remove worktree and window
```

---

## devpod

Containers are per project. One workspace per repository.

| Command | Does |
|---|---|
| `devpod up . --ide none` | Start (or create) the workspace for the current repo |
| `devpod list` | All workspaces and their state |
| `devpod ssh <ws>` | Shell inside the container |
| `devpod stop <ws>` | Stop without deleting |
| `devpod delete <ws>` | Remove the workspace |
| `devpod up <ws> --recreate` | Re-apply a changed `devcontainer.json` |
| `devpod up <ws> --reset` | Rebuild from scratch, discard container state |
| `devpod provider add docker` | One-time, on a new machine |

`--recreate` is the one to remember: editing `.devcontainer/` does nothing until
you pass it.

## chezmoi

The dotfiles source is this repository. Never edit `~/.zshrc` directly — edit the
source and apply.

| Command | Does |
|---|---|
| `chezmoi edit ~/.zshrc` | Edit the *source* of a file, in `$EDITOR` |
| `chezmoi apply` | Write pending changes into the home directory |
| `chezmoi diff` | What `apply` would change |
| `chezmoi status` | Short version of the same |
| `chezmoi cd` | Shell in the source directory |
| `chezmoi add ~/.config/foo/bar` | Track a new file |
| `chezmoi re-add` | Pull edits made directly in `~` back into the source |
| `chezmoi update` | `git pull` in the source, then apply |

`chezmoi apply` also runs `.chezmoiscripts/`, so it installs anything new in
`dot_config/mise/config.toml`.

## mise

Tool versions. Global list is `dot_config/mise/config.toml`; per-project is
`mise.toml` in the repo root.

| Command | Does |
|---|---|
| `mise install` | Install everything the config asks for |
| `mise ls` | Installed tools and versions |
| `mise use node@24` | Pin a tool in the current project's `mise.toml` |
| `mise use -g <tool>@latest` | Pin globally |
| `mise outdated` | What has a newer release |
| `mise upgrade` | Update tools pinned to `latest` |
| `mise run <task>` | Run a task defined in `mise.toml` |
| `mise trust` | Allow a project `mise.toml` you just cloned |

A new project's `mise.toml` is ignored until you `mise trust` it.

## tmux

| Key | Does |
|---|---|
| `C-b O` | Fuzzy pick a repository, create or attach its session |
| `C-b S` | Fuzzy switch between existing sessions |
| `C-b L` | Toggle back to the previous session |
| `C-b w` | Window list across sessions |
| `C-b s` | Session/window tree, `/` to filter |
| `C-b c` | New window |
| `C-b ,` | Rename window |
| `C-b d` | Detach (everything keeps running) |
| `C-b z` | Zoom the current pane, again to unzoom |
| `C-b [` | Copy mode, vi keys, `v` select, `y` copy |

| Command | Does |
|---|---|
| `tmux` | New session |
| `tmux a` | Attach to the last session |
| `tmux ls` | List sessions |
| `tmux kill-session -t <name>` | Kill one session |

Sessions are saved every minute and restored on boot by resurrect + continuum, so
a reboot is not a loss. `C-b C-s` saves now, `C-b C-r` restores.

## workmux

One worktree per task, each with its own tmux window and its own agent. Run these
from anywhere inside the repository.

| Command | Does |
|---|---|
| `workmux add <name>` | New worktree, branch, window, and agent |
| `workmux add <name> -A "<task>"` | Same, but the branch name is generated from the task |
| `workmux ls` | Worktrees in this repo |
| `workmux ls --all` | Across every repo with a tracked agent |
| `workmux status --all` | Which agents are working, waiting, or done |
| `workmux open <name>` | Window for an existing worktree |
| `workmux close <name>` | Close the window, keep worktree and branch |
| `workmux send <name> "<text>"` | Send a prompt to a running agent |
| `workmux capture <name>` | Last 200 lines of an agent's terminal |
| `workmux merge <name>` | Merge the branch, then clean up worktree and window |
| `workmux rm <name>` | Drop worktree, window, and branch without merging |
| `workmux rebase <name>` | Rebase the worktree branch onto its base |
| `workmux path <name>` | Print the worktree's path |
| `workmux dashboard` | TUI of every active agent |
| `workmux resurrect` | Rebuild windows after a crash |

Agents run inside the project's devpod workspace, through `dcx`. Worktrees are
created in `.worktrees/` inside the repo so the container's bind mount sees them.

`workmux send` and `capture` take `project:name` too, so you can poke an agent in
another repository without switching to it.

## dcx

Wrapper that runs a command inside the current project's devpod workspace, at the
matching path. workmux calls it for you; use it directly when you want a shell.

| Command | Does |
|---|---|
| `dcx` | Login shell in the container, same directory |
| `dcx <cmd>` | Run one command in the container |
| `WORKMUX_DEVPOD_WS=<ws> dcx` | Override the workspace name if it is not the repo's directory name |

## Neovim

LazyVim. `v` is the alias.

| Key | Does |
|---|---|
| `<leader><space>` | Find file in the project |
| `<leader>/` | Grep the project |
| `<leader>e` | File explorer |
| `<leader>,` | Switch buffer |
| `<leader>lg` | LazyGit |
| `<leader>bd` | Close buffer |
| `gd` / `gr` | Go to definition / references |
| `K` | Hover docs |
| `<leader>ca` | Code action |
| `<leader>cr` | Rename symbol |
| `<leader>cf` | Format |
| `<leader>xx` | Diagnostics list |
| `s` | Flash jump to any visible position |
| `<leader>l` | Lazy plugin manager |
| `<leader>cm` | Mason, for LSP servers |

`:LazyHealth` when something stops working.

## lazygit

Launch with `lazygit`, or `<leader>lg` in Neovim. Panels are on the left, `Tab`
and `1`–`5` move between them.

| Key | Does |
|---|---|
| `Space` | Stage / unstage the file or hunk under the cursor |
| `a` | Stage everything |
| `c` | Commit |
| `A` | Amend the last commit |
| `P` / `p` | Push / pull |
| `b` | Branch menu |
| `space` on a branch | Check it out |
| `d` | Discard changes (asks first) |
| `Enter` on a file | Line-by-line staging |
| `x` | Keybinding help for the focused panel |
| `q` | Quit |

## direnv

Per-project environment, loaded when you `cd` in. `.envrc` is globally gitignored.

| Command | Does |
|---|---|
| `direnv allow` | Trust `.envrc` — required after every edit |
| `direnv reload` | Reload without editing |
| `direnv edit .` | Edit and auto-allow |
| `direnv status` | Why it is or is not loaded |

"direnv: error .envrc is blocked" always means `direnv allow`.

## fd

Find files. Respects `.gitignore` by default.

| Command | Does |
|---|---|
| `fd <pattern>` | Find by name, fuzzy, from here down |
| `fd -e ts` | By extension |
| `fd -H <pattern>` | Include hidden files |
| `fd -I <pattern>` | Include gitignored files |
| `fd -t d <pattern>` | Directories only |
| `fd <pattern> <dir>` | Search a specific directory |
| `fd -x <cmd> {}` | Run a command per result |

## ripgrep

Search file contents. Also respects `.gitignore`.

| Command | Does |
|---|---|
| `rg <pattern>` | Search from here down |
| `rg -i <pattern>` | Case-insensitive |
| `rg -w <pattern>` | Whole word |
| `rg -t ts <pattern>` | Only TypeScript files |
| `rg -l <pattern>` | File names only |
| `rg -A3 -B3 <pattern>` | Show 3 lines of context |
| `rg --hidden --no-ignore <pattern>` | Search everything |
| `rg <pattern> -g '!*.test.ts'` | Exclude a glob |

## Shell aliases

Defined in `dot_zshrc` and `dot_bashrc`.

| Alias | Expands to |
|---|---|
| `v` | `nvim` |
| `cat` | `bat` |
| `ll` / `la` / `lt` | `lsd` variants |
| `gs` / `gaa` / `gcam` / `gd` / `gp` / `gl` | git status / add . / commit -a -m / diff / push / log --oneline --graph --all |
| `k` | `kubectl` |
| `clauded` | `claude --dangerously-skip-permissions` |
| `claudedr` | `claude --dangerously-skip-permissions --resume` |
