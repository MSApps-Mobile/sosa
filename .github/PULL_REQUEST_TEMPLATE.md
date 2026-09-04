## What this changes

<!-- One or two sentences. -->

## Shape

- [ ] Platform mapping (a framework SOSA didn't cover)
- [ ] Linter rule (`scripts/sosa-lint.sh`)
- [ ] Spec clarification (`docs/`) — linked issue: #
- [ ] Docs / README
- [ ] Other:

## Four-pillar checklist

- [ ] **Supervised** — approval gates defined for high-risk actions
- [ ] **Orchestrated** — efficient execution, no bloated context or redundant tools
- [ ] **Secured** — no hardcoded secrets, injection scanning, least privilege
- [ ] **Agents** — role spec complete, tool manifest declared, memory scope defined

## Verification

<!-- Paste the output. Every documented command must actually run. -->

```
bash -n scripts/sosa-lint.sh
./scripts/sosa-lint.sh .
```
