# Installation

This repository provides adapters for Claude Code, OpenAI Codex, OpenCode, and Google Antigravity. You can install one platform or all of them in the same project.

The installer never needs API keys and does not install model providers. It only adds instruction files and local memory templates.

## Option A - Install with the shell script

From this repository:

```bash
./scripts/install.sh all /path/to/your/project
```

Or install one adapter:

```bash
./scripts/install.sh claude /path/to/project
./scripts/install.sh codex /path/to/project
./scripts/install.sh opencode /path/to/project
./scripts/install.sh antigravity /path/to/project
```

Existing `CLAUDE.md` or `AGENTS.md` files are backed up and the kit block is appended once. The Antigravity adapter is installed as its own workspace rule file.

## Option B - Windows PowerShell

```powershell
.\scripts\install.ps1 -Platform all -Target C:\path\to\project
```

Supported `-Platform` values: `all`, `claude`, `codex`, `opencode`, `antigravity`.

## Manual installation

### Claude Code
Copy:

```text
adapters/claude/CLAUDE.md -> <project>/CLAUDE.md
```

If the project already has `CLAUDE.md`, merge the kit sections rather than deleting project-specific commands/conventions. Claude Code uses project `CLAUDE.md` as persistent project memory/instructions.

Create local state files from `templates/memory/` under:

```text
<project>/.agent-memory/
```

Run Claude Code from the project directory. For a long same-task session, capture a handoff and use `/compact`; use a clean session for unrelated work.

### OpenAI Codex
Copy:

```text
adapters/codex/AGENTS.md -> <project>/AGENTS.md
```

If `AGENTS.md` already exists, merge the production-context sections with the existing repository-specific rules. Keep repository build/test commands and architecture facts; they are valuable persistent context for Codex.

Create `.agent-memory/` from the included templates.

### OpenCode
Copy:

```text
adapters/opencode/AGENTS.md -> <project>/AGENTS.md
```

OpenCode loads project `AGENTS.md` as persistent instructions. Its `/init` command can create/update an `AGENTS.md`; if you use `/init`, keep the Production Context Discipline section after the generated project-specific information.

Optional: review `adapters/opencode/opencode.example.json` and merge the `compaction` / watcher settings into your existing `opencode.json` rather than replacing your configuration blindly. OpenCode supports manual `/compact` (alias `/summarize`) and automatic compaction.

### Google Antigravity
Copy:

```text
adapters/antigravity/production-context-discipline.md
  -> <project>/.agents/rules/production-context-discipline.md
```

In Antigravity, workspace rules live under `.agents/rules`. You can also add rules through the editor's Customizations -> Rules panel. Set this rule to **Always On** for development work, or use Model Decision if you only want it activated for coding/debugging tasks.

Create `.agent-memory/` from the included templates.

## Recommended memory location

The default installer adds `.agent-memory/` to the target project's `.gitignore`. This is deliberate: current task state and handoffs often contain local paths, temporary decisions, or debugging notes. If your team wants shared durable project knowledge, commit a curated architecture file separately rather than committing raw task state.

## Verify installation

Ask the agent:

```text
Before changing code, tell me your objective, acceptance criteria, initial relevant-file map, and verification plan. Do not inspect unrelated files.
```

A correct installation should cause the agent to scope first rather than immediately scanning the entire repository.
