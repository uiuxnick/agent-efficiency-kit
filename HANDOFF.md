# Example Handoff

## Goal
Prevent duplicate orders from retried checkout requests.

## Status
Implementation complete; focused tests pass; full suite not run.

## Changed Files
- `src/checkout/createOrder.ts`
- `src/checkout/createOrder.test.ts`

## Verified Facts
- The route can retry after gateway timeout.
- Order creation previously had no idempotency check.
- `checkout_request_id` is stable across gateway retries.

## Decisions That Must Not Be Reopened Without New Evidence
- Use `checkout_request_id` as the idempotency key because it is already stable and unique for one customer submission.

## Tests Run
- `npm test -- createOrder.test.ts` - pass
- `npm run typecheck -- --pretty false` - pass

## Remaining Work
1. Run checkout integration test in staging.

## Risks / Watchouts
- Existing historical rows do not have `checkout_request_id`; new logic handles null as legacy behavior.

## Exact Next Action
Run the staging checkout integration test and inspect one retry in logs.
