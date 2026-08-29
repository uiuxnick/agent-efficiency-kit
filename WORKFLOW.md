# Production Workflow

This kit uses a map -> execute -> verify -> remember loop.

## Phase 0 - Classify the task
Treat tiny, obvious edits differently from architectural or debugging work. A one-line typo does not need a full project map. A bug crossing controllers, services, queues, and database code does.

## Phase 1 - Define success
Write a concrete objective and testable acceptance criteria. Separate required behavior from optional cleanup. If the request is ambiguous but implementation can safely proceed with a reversible assumption, record the assumption; otherwise ask one focused question.

## Phase 2 - Build the smallest useful map
Start from the strongest anchor available: error string, function name, route, component, failing test, stack frame, config key, or changed file. Trace only enough imports/callers/dependencies to understand ownership and side effects.

A good map answers:
1. Where does execution enter?
2. Which symbol owns the behavior?
3. Which dependencies can affect it?
4. Which tests prove it?
5. Which files should not need modification?

Do not confuse "understanding the codebase" with "reading lots of files." The goal is decision-grade understanding.

## Phase 3 - Write task state
Record the map in `.agent-memory/TASK_STATE.md`. If a finding is stable and likely useful across tasks, promote it to `PROJECT_MAP.md`. Keep each bullet factual and compact.

## Phase 4 - Execute one bounded step
Each step should have one outcome and a small edit surface. Prefer one subsystem at a time. If the step unexpectedly requires broad changes, stop and update the map before editing more files.

## Phase 5 - Verify from narrow to broad
Use an evidence ladder:
1. syntax/static check for changed code;
2. closest unit/feature test;
3. scoped lint/typecheck;
4. related integration/regression test;
5. full build/suite only when risk or policy justifies it.

This avoids spending large tool/model context on unrelated failures while still providing production confidence.

## Phase 6 - Review the diff
Inspect only touched paths first. Look for accidental formatting changes, duplicate logic, missing error handling, debug code, secrets, migrations, API contract changes, or unrelated modifications.

## Phase 7 - Handoff or finish
If continuing later, write a compact handoff. A new session should be able to resume by reading the handoff and a few relevant files rather than replaying the full history.
