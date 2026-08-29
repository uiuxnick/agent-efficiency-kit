# Example Task Prompt

Use Production Context Discipline.

Task: Fix checkout requests that intermittently create duplicate orders.

Acceptance criteria:
- one submitted checkout creates at most one order;
- retries return/reuse the existing order rather than creating a second one;
- existing successful checkout behavior remains unchanged;
- add or update focused tests for the duplicate-request case.

Start by mapping only the checkout entry point, order-creation service, idempotency/transaction logic, and closest tests. Do not scan unrelated modules. Record the compact map and task state before implementation.
