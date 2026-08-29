# Production Context Discipline

Apply this rule to coding and debugging tasks.

## Preflight
Before editing, identify the objective, acceptance criteria, likely entry point, smallest relevant file/symbol set, and verification command. Do not explore the entire workspace by default. Start from precise symbol/string/path searches and roughly 3-7 likely files; expand only when evidence requires it.

## Minimal task map
Build only the map required to solve the task:
- entry point;
- control/data flow;
- owner files/symbols;
- dependency boundaries;
- closest tests.

Persist stable verified facts in `.agent-memory/PROJECT_MAP.md` and active work in `.agent-memory/TASK_STATE.md`. Memory stores conclusions, not transcripts or raw tool output.

## Reuse verified state
Do not repeatedly read unchanged files or re-think decisions already supported by evidence. Revisit them only when code changes, tests contradict them, or new evidence appears.

## Bounded steps
For each step, touch the smallest necessary files, make one coherent change, run the narrowest meaningful verification, inspect the scoped diff, and update task state. Avoid unrelated refactors and cleanup.

## Tool discipline
Prefer targeted search, narrow reads, focused tests, scoped lint/typecheck, and filtered logs. Do not inject full build logs or giant file dumps into the conversation when a relevant excerpt is enough.

## Failure circuit breaker
After two similar failed attempts, stop patching. Record the failed assumption, re-map from evidence, and choose a different hypothesis. Do not repeat recorded dead ends without new evidence.

## Production gate
Before completion, check acceptance criteria, relevant tests, lint/typecheck, regression risk, security/authorization, error paths, edge cases, compatibility, migration/rollback risk, and final diff cleanliness as applicable.

## Session handoff
Before a long task is paused or a new task begins, produce `.agent-memory/HANDOFF.md` containing only goal, status, changed files, verified facts, important decisions, tests, remaining work, risks, and exact next action. Prefer a clean conversation over carrying obsolete exploration.

## Communication
Keep progress reports concise and evidence-based. Avoid narrating routine reasoning.
