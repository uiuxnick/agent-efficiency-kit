# Context and Tool Budget

The objective is not an arbitrary percentage reduction. The objective is to spend model attention only where it changes the engineering decision.

## Default exploration budget
For a normal bug/feature:
- start with 1-3 targeted searches;
- inspect roughly 3-7 likely files;
- trace only directly relevant callers/dependencies;
- run one focused verification before broadening scope.

These are defaults, not hard limits. A cross-cutting migration may legitimately need more files.

## High-cost behaviors to avoid
- recursive reading of an entire repository;
- repeatedly reopening unchanged files;
- pasting full build/test logs into model context;
- running the full test suite after every small edit;
- repeatedly asking the model to rediscover architecture;
- browser/MCP calls unrelated to the current decision;
- carrying unrelated previous tasks in the same session;
- "while I am here" refactors.

## When to expand scope
Expand only when one of these is true:
- the relevant symbol delegates behavior elsewhere;
- tests show an unexpected dependency;
- a contract/schema change requires callers/consumers;
- security/authorization boundaries cross modules;
- the smallest change cannot satisfy acceptance criteria.

Write the reason for expansion into task state. This forces exploration to remain evidence-driven.

## Reasoning discipline
Do not demand "no thinking." Good engineering requires reasoning. Instead:
- reason deeply at decision points;
- do not re-reason settled facts;
- keep routine actions terse;
- preserve conclusions in task memory;
- reset/compact after the useful conclusions have been captured.
