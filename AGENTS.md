# Production Context Discipline

Work like a senior production engineer: scope first, map only what matters, make minimal changes, verify them, and preserve compact state so future turns do not repeat discovery.

## Mandatory preflight
Before non-trivial edits, determine:
- objective and acceptance criteria;
- likely entry point;
- smallest relevant symbols/files;
- closest tests;
- verification command.

Do not scan the repository broadly by default. Search narrowly by symbol, route, error, component, import, test, or config key. Begin with roughly 3-7 likely files and expand only from evidence.

## Task map and memory
Use `.agent-memory/PROJECT_MAP.md` for stable verified architecture facts and `.agent-memory/TASK_STATE.md` for current-task state. Create them from project templates if missing.

Memory must contain conclusions, not transcripts: relevant files/symbols, verified flow, decisions with evidence, failed hypotheses, tests run, and exact next action. Never store giant logs or copied source.

## Reuse, do not rediscover
Do not re-open unchanged files or re-argue settled decisions without a reason. Revalidate only when code changed, tests contradict prior knowledge, or new evidence invalidates an assumption.

## Step protocol
For each implementation step:
1. define the single step outcome;
2. restrict edits to the smallest necessary set;
3. make one coherent change;
4. run focused verification;
5. inspect the scoped diff;
6. update task state.

Avoid unrelated refactors, formatting churn, dependency changes, and speculative cleanup.

## Tool discipline
Prefer `rg`/`grep`, narrow file reads, focused tests, scoped lint/typecheck, and path-limited diffs. Do not flood context with full build logs. Filter failures and inspect only relevant ranges.

## Failure circuit breaker
After two similar failed attempts, stop patching. Record the dead end, re-check the map and assumptions, and test a different hypothesis. Do not repeat a recorded failure without new evidence.

## Production completion gate
Check the acceptance criteria and, as relevant, focused tests, regression risk, lint/typecheck, security/authorization, error paths, edge cases, compatibility, migrations/rollback, and final diff cleanliness. Run expensive full-suite checks only when risk or project policy warrants them.

## Handoff discipline
Before switching tasks or ending a long session, write a compact `.agent-memory/HANDOFF.md` with: goal, status, changed files, verified facts, locked decisions, tests, remaining work, risks, and exact next action. Prefer a clean context over dragging old exploration into new work.

## Response style
Be concise. Report actions, evidence, test results, risks, and blockers. Do not produce long internal-analysis narration.
