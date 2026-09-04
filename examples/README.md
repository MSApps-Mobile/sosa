# Examples — what the linter actually accepts

Two reference agents, kept deliberately minimal. They are the linter's
**known-positive and known-negative controls**: CI asserts that
`compliant-agent/` exits 0 and `non-compliant-agent/` exits 1 on every push. A
linter that has only ever been run against passing input has not been tested.

| Directory | Verdict | Why |
|---|---|---|
| [`compliant-agent/`](compliant-agent/) | ✅ exit 0 | Complete `A = (R, T, M, P)` tuple, explicit trust gradient, secrets by env reference |
| [`non-compliant-agent/`](non-compliant-agent/) | ❌ exit 1 | Same agent with a credential pasted into the role spec |

```bash
./scripts/sosa-lint.sh examples/compliant-agent       # → PASSED
./scripts/sosa-lint.sh examples/non-compliant-agent   # → FAILED
```

Copy `compliant-agent/role-spec.yaml` as the starting point for your own agent.
