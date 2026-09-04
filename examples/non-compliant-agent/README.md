# non-compliant-agent — the negative control

Byte-identical to [`../compliant-agent/role-spec.yaml`](../compliant-agent/role-spec.yaml)
except that two credentials are pasted in as literals instead of referenced
from the environment. That single change is a **Secured** failure, and Secured
is the pillar that cannot be traded away: any FAIL there drops the agent to
non-compliant regardless of the other three.

The values are obvious placeholders. They authorize nothing.

```bash
./scripts/sosa-lint.sh examples/non-compliant-agent   # → ❌ FAILED (exit 1)
diff ../compliant-agent/role-spec.yaml role-spec.yaml # → the whole delta
```
