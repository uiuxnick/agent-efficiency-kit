# Agent Context Optimizer

Production-oriented **AI agent skills and workflow instructions for Claude Code, OpenAI Codex, OpenCode, and Google Antigravity**. Improve coding-agent context efficiency, repository discovery, task planning, memory, handoffs, verification, security, and production-quality delivery.

Search terms: **Claude AI skills, Claude Code skills, Claude Code plugins, Codex AI skills, OpenAI Codex skills, OpenAI coding agent, Antigravity AI skills, Google Antigravity rules, OpenCode skills, AI coding assistant, agent skills, developer productivity, context engineering, persistent agent memory, coding workflow, software engineering automation**.

It is designed for a specific failure mode in AI coding: the agent keeps reading more files, re-thinking decisions, carrying giant logs, and re-discovering the same architecture until context and usage explode. This project replaces that with a disciplined loop:

**Map -> Scope -> Execute -> Verify -> Remember -> Handoff**

## What it changes

The adapters instruct the coding agent to:
- define success before editing;
- build a minimal task map instead of scanning the whole repository;
- start from a small evidence-based set of relevant files;
- persist verified project/task state in compact local memory;
- avoid re-reading unchanged files and re-thinking settled decisions;
- implement in bounded steps with focused verification;
- stop blind patch loops after repeated failures;
- filter noisy logs/tool output;
- run broad tests only when risk warrants them;
- produce a compact handoff before context reset/compaction;
- finish with a production-quality diff and risk check.

## What it does NOT promise

This project cannot bypass provider rate/usage limits, and no honest configuration can guarantee "100x more usage." It targets avoidable waste. Actual savings depend on repo size, task complexity, model, tool behavior, and how disciplined the workflow was before installation.

## Supported adapters

| Platform | Primary project instruction |
|---|---|
| Claude Code | `CLAUDE.md` |
| OpenAI Codex | `AGENTS.md` |
| OpenCode | `AGENTS.md` |
| Google Antigravity | `.agents/rules/production-context-discipline.md` |

## Install as a Claude Code marketplace plugin

This repository includes a Claude Code marketplace catalog and an installable plugin.

```text
/plugin marketplace add uiuxnick/agent-efficiency-kit
/plugin install agent-context-optimizer@agent-context-tools
```

The plugin provides the namespaced skill:

```text
/agent-context-optimizer:production-context-discipline
```

You can also install the repository directly from the Claude Code plugin marketplace UI using:

```text
https://github.com/uiuxnick/agent-efficiency-kit.git
```

Use `main` as the Git ref and leave sparse paths empty.

## Install

```bash
./scripts/install.sh all /path/to/project
```

See [INSTALLATION.md](INSTALLATION.md) for platform-specific and Windows instructions.

## Platform guides

- **Claude Code / Claude AI:** use the marketplace commands above, or copy `adapters/claude/CLAUDE.md` into a project.
- **OpenAI Codex:** copy `adapters/codex/AGENTS.md` into the project root as `AGENTS.md`, then create `.agent-memory/` from the templates.
- **OpenCode:** copy `adapters/opencode/AGENTS.md` as `AGENTS.md`; optionally merge the compaction settings from `adapters/opencode/opencode.example.json`.
- **Google Antigravity:** copy `adapters/antigravity/production-context-discipline.md` into `.agents/rules/` and set it to Always On or Model Decision.

The shell and PowerShell installers perform these copies safely and back up existing instruction files.

## Memory design

`.agent-memory/PROJECT_MAP.md` stores stable verified architecture facts. `.agent-memory/TASK_STATE.md` stores only current-task state. `.agent-memory/HANDOFF.md` lets a clean session resume without replaying the whole conversation.

The memory layer is intentionally compact. It is not a chain-of-thought log and should never become one.

## Recommended task style

Give agents issue-like tasks with acceptance criteria and any known anchors (error, route, component, file, test). Example:

```text
Fix duplicate orders created by checkout retries.
Acceptance: one customer submission creates at most one order; retries reuse the original; add a focused regression test.
Start from the checkout route and closest order-creation test. Do not scan unrelated modules.
```

## Repository layout

```text
adapters/          Platform-specific instruction files
  claude/
  codex/
  opencode/
  antigravity/
docs/              Detailed workflow, memory and production guidance
templates/memory/  Compact persistent-state templates
examples/          Example task and handoff
scripts/           Safe installers for macOS/Linux and Windows
```

## Core design principle

Do not tell the model to "think less" indiscriminately. That can reduce correctness. Tell it to **reason at decision points, avoid repeated reasoning, and preserve verified conclusions so it does not pay for the same discovery twice.**

## License

MIT. See [LICENSE](LICENSE).
