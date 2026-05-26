# Graph Report - .  (2026-05-26)

## Corpus Check
- Corpus is ~1,768 words - fits in a single context window. You may not need a graph.

## Summary
- 32 nodes · 21 edges · 13 communities (11 shown, 2 thin omitted)
- Extraction: 90% EXTRACTED · 10% INFERRED · 0% AMBIGUOUS · INFERRED: 2 edges (avg confidence: 0.9)
- Token cost: 0 input · 0 output

## Community Hubs (Navigation)
- [[_COMMUNITY_RTK & Graphify Tooling|RTK & Graphify Tooling]]
- [[_COMMUNITY_Devcontainer Setup|Devcontainer Setup]]
- [[_COMMUNITY_Global Claude Instructions|Global Claude Instructions]]
- [[_COMMUNITY_Claude Hooks Config|Claude Hooks Config]]
- [[_COMMUNITY_Claude Permissions|Claude Permissions]]
- [[_COMMUNITY_Dotfiles Bootstrap|Dotfiles Bootstrap]]

## God Nodes (most connected - your core abstractions)
1. `Global CLAUDE.md (Claude Code Instructions)` - 6 edges
2. `Project CLAUDE.md (RTK Instructions)` - 4 edges
3. `build` - 3 edges
4. `RTK (Rust Token Killer)` - 3 edges
5. `hooks` - 2 edges
6. `permissions` - 2 edges
7. `Dotfiles README` - 2 edges
8. `RTK.md Reference File` - 2 edges
9. `PreToolUse` - 1 edges
10. `allow` - 1 edges

## Surprising Connections (you probably didn't know these)
- `Global CLAUDE.md (Claude Code Instructions)` --conceptually_related_to--> `Project CLAUDE.md (RTK Instructions)`  [INFERRED]
  dot_claude/CLAUDE.md → CLAUDE.md
- `RTK.md Reference File` --references--> `RTK (Rust Token Killer)`  [INFERRED]
  dot_claude/CLAUDE.md → CLAUDE.md

## Hyperedges (group relationships)
- **Claude Code Global Coding Principles** — principle_think_before_coding, principle_simplicity_first, principle_surgical_changes, principle_goal_driven_execution [EXTRACTED 1.00]

## Communities (13 total, 2 thin omitted)

### Community 0 - "RTK & Graphify Tooling"
Cohesion: 0.33
Nodes (6): Project CLAUDE.md (RTK Instructions), graphify-out/ Knowledge Graph Directory, Graphify Knowledge Graph Tool, RTK.md Reference File, RTK Token Savings Golden Rule, RTK (Rust Token Killer)

### Community 1 - "Devcontainer Setup"
Cohesion: 0.40
Nodes (4): build, context, dockerfile, postCreateCommand

### Community 2 - "Global Claude Instructions"
Cohesion: 0.40
Nodes (5): Global CLAUDE.md (Claude Code Instructions), Goal-Driven Execution Principle, Simplicity First Principle, Surgical Changes Principle, Think Before Coding Principle

### Community 5 - "Dotfiles Bootstrap"
Cohesion: 0.67
Nodes (3): Oh-My-Zsh, Dotfiles README, Setup Script (setup.sh)

## Knowledge Gaps
- **9 isolated node(s):** `PreToolUse`, `allow`, `context`, `dockerfile`, `postCreateCommand` (+4 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **2 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `Global CLAUDE.md (Claude Code Instructions)` connect `Global Claude Instructions` to `RTK & Graphify Tooling`?**
  _High betweenness centrality (0.068) - this node is a cross-community bridge._
- **Why does `Project CLAUDE.md (RTK Instructions)` connect `RTK & Graphify Tooling` to `Global Claude Instructions`?**
  _High betweenness centrality (0.047) - this node is a cross-community bridge._
- **What connects `PreToolUse`, `allow`, `context` to the rest of the system?**
  _14 weakly-connected nodes found - possible documentation gaps or missing edges._