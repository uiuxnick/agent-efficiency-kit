# Production Completion Checklist

Use only applicable checks; do not perform ceremonial work.

## Correctness
- Acceptance criteria are demonstrably met.
- Main happy path works.
- Relevant error/empty/null/boundary paths are handled.
- Existing behavior outside scope is preserved.

## Verification
- Closest focused tests pass.
- Changed scope passes lint/type checks when available.
- Relevant integration/regression tests pass.
- Build/full suite run when change risk or repository policy requires it.

## Security
- Authentication/authorization boundaries remain correct.
- Inputs are validated at the correct trust boundary.
- No secrets/credentials are introduced.
- File, shell, SQL, HTML, URL, and network inputs are safely handled where relevant.

## Compatibility
- API/request/response contracts are considered.
- Database/schema migrations are safe and ordered.
- Backward compatibility is preserved or intentionally documented.
- Config/environment changes have safe defaults.

## Operability
- Errors are diagnosable without exposing sensitive data.
- Logs/metrics are added only when useful.
- Rollback/migration risk is understood for high-impact changes.

## Diff quality
- No unrelated refactor or formatting churn.
- No debug code or temporary files.
- Comments explain non-obvious why, not obvious what.
