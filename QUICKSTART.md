# Quick Start

1. Clone/download this repository.
2. Run `./scripts/install.sh all /path/to/project` (or choose one platform).
3. Open the target project with your coding agent.
4. Give it one well-scoped task with acceptance criteria.
5. Let it create/update `.agent-memory/TASK_STATE.md` as it works.
6. When the task/session becomes long, require a compact handoff and then compact/reset context.

A useful first instruction:

```text
Use the production context workflow. Build the smallest task map first, touch only relevant files, verify each bounded step, and keep `.agent-memory/TASK_STATE.md` concise and current.
```
