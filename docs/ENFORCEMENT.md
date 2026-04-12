# SOSA™ Enforcement Guide

This document describes how SOSA compliance is enforced at three levels: automated CI/CD, local linting, and human review.

## 1. CI/CD — GitHub Actions (Automatic)

Every PR and push to `main` triggers `.github/workflows/sosa-lint.yml`:

- **SOSA four-pillar lint** — checks agents/plugins against the checklist
- **Secret scanning** — blocks hardcoded API keys, passwords, tokens
- **Role spec presence** — ensures every agent has a role definition
- **Token efficiency** — warns on bloated descriptions (>3000 words)

PRs that fail the SOSA lint **cannot be merged**.

## 2. Local Linting (Pre-push)

Run before pushing:

```bash
./scripts/sosa-lint.sh /path/to/your/agent
```

Same checks as CI, with color-coded output.

## 3. PR Review Checklist (Human)

Every PR should include the four-pillar checklist. Reviewers verify each item:

- [ ] **Supervised**: Are approval gates defined for high-risk actions?
- [ ] **Orchestrated**: Is the execution efficient? No bloated context?
- [ ] **Secured**: No hardcoded secrets? Injection scanning? Least privilege?
- [ ] **Agents**: Role spec complete? Tool manifest declared? Memory scoped?

## Adding New Agents

Every new agent must include:

- Role specification (what it does and doesn't do)
- Dependency manifest with pinned versions
- No hardcoded secrets — use env vars or secure stores
- Documentation with trigger conditions and boundaries
