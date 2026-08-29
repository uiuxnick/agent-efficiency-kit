# Memory Protocol

The memory files are not a diary. They are a compression layer for verified engineering state.

## PROJECT_MAP.md
Purpose: durable project knowledge that prevents repeated repo discovery.

Store:
- stack/runtime/package manager;
- important entry points;
- non-obvious architecture boundaries;
- canonical build/test/lint commands;
- stable ownership facts;
- known high-risk areas.

Do not store:
- current debugging guesses;
- raw logs;
- full file contents;
- short-lived task details;
- facts that can be inferred instantly from filenames.

Update it only when a stable fact is learned or invalidated.

## TASK_STATE.md
Purpose: single source of truth for the current task.

Keep:
- objective and acceptance criteria;
- in/out scope;
- relevant paths and symbols;
- verified call/data flow;
- decisions plus evidence;
- failed hypotheses that should not be repeated;
- tests completed;
- current and next step.

Delete or archive it when the task is done.

## HANDOFF.md
Purpose: allow a fresh context/session to resume without replaying history.

A good handoff should be readable in under a minute. If it is several pages long, compress it.

## Evidence labels
Use strong wording only for verified facts.
- `Verified:` directly observed in code/test/output.
- `Assumption:` plausible but not verified.
- `Decision:` chosen approach and why.
- `Dead end:` tested and rejected.

This prevents future agents from turning guesses into "memory."
