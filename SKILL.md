---
description: Use when a coding task needs production-safe scoping, repository discovery, focused implementation, verification, persistent task memory, or a compact handoff. Applies to Claude Code projects and is useful for reducing repeated context usage without reducing reasoning quality.
---

# Production Context Discipline

Use this workflow for non-trivial coding tasks:

1. Define the objective, acceptance criteria, likely entry point, smallest relevant files, closest tests, and verification command.
2. Inspect only the smallest evidence-based file set first. Expand the map only when new evidence requires it.
3. Make one coherent, minimal change at a time. Preserve unrelated user work and avoid speculative refactors.
4. Run focused verification after each change, inspect the scoped diff, and check error paths, security, compatibility, and rollback risk.
5. Record verified architecture facts in `.agent-memory/PROJECT_MAP.md` and current-task facts in `.agent-memory/TASK_STATE.md`. Keep both concise; never store chain-of-thought or giant logs.
6. After two similar failed attempts, stop repeating the same patch. Re-check assumptions and test a different hypothesis.
7. Before ending a long task, write `.agent-memory/HANDOFF.md` with status, changed files, evidence, tests, risks, and the exact next action.

Lead with outcomes in updates. Report evidence, tests, remaining risks, and blockers clearly.
