# SOSA™ — Supervised Orchestrated Secured Agents

[![Visitors](https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2FMSApps-Mobile%2Fsosa&count_bg=%2379C83D&title_bg=%23555555&title=visitors&edge_flat=false)](https://github.com/MSApps-Mobile/sosa)
[![GitHub stars](https://img.shields.io/github/stars/MSApps-Mobile/sosa?style=social)](https://github.com/MSApps-Mobile/sosa/stargazers)

> A governance framework for production-grade autonomous AI operations.

If you find SOSA useful, please ⭐ **[star this repo](https://github.com/MSApps-Mobile/sosa/stargazers)** — it helps other developers discover the framework and motivates us to keep building.

AI agents today have a trust problem. Most are demos — not production tools.
They skip confirmation on destructive actions, have no concept of token budgets,
and have no formal boundaries.

**SOSA™** is a four-pillar methodology built at [MSApps](https://msapps.mobi) to fix that.
Every agent we deploy declares its compliance level, impact classification, and security posture before it runs.

---

## The Four Pillars

### 🛡️ Supervised
High-impact actions require human approval. An outreach agent can't send 500 emails without sign-off.
Agents pause, explain, and wait before irreversible actions.

**Plugin:** [`sosa-governor`](https://github.com/MSApps-Mobile/claude-plugins/tree/main/plugins/sosa-governor)
— trust scores, tool gates, audit log

---

### ⚙️ Orchestrated
Agents follow **Plan → Act → Verify**. Tasks are ranked by a Priority Score:
`(Impact × Urgency × Dependencies) / Token Cost`.
Token budgets are enforced — waste is measured, reported, and reduced.

**Plugins:**
- [`sosa-orchestrator`](https://github.com/MSApps-Mobile/claude-plugins/tree/main/plugins/sosa-orchestrator) — budget tracking, task prioritisation, pause/resume
- [`token-efficiency-audit`](https://github.com/MSApps-Mobile/claude-plugins/tree/main/plugins/token-efficiency-audit) — finds and eliminates token waste (O6 compliance)

---

### 🔒 Secured
No hardcoded credentials. External data is scanned for prompt injection.
Package versions are pinned. A finance agent can't send emails — period.

**Plugin:** [`sosa-compliance-checker`](https://github.com/MSApps-Mobile/claude-plugins/tree/main/plugins/sosa-compliance-checker)
— security audit, injection detection, compliance scoring

---

### 🤖 Agents
Each agent has a formal role spec, declared tool access, and explicit boundaries.
Not "an AI that does things" — an agent with a defined scope it cannot exceed.

---

## SOSA Compliance Levels

| Level | Description |
|-------|-------------|
| **Level 1** | Basic — human approval on destructive actions |
| **Level 2** | Standard — approval gates + no hardcoded secrets |
| **Level 3** | Full — all four pillars enforced with audit trail |

---

## Install the SOSA Suite

```bash
/plugin install sosa-governor@msapps-plugins
/plugin install sosa-orchestrator@msapps-plugins
/plugin install sosa-compliance-checker@msapps-plugins
/plugin install token-efficiency-audit@msapps-plugins
```

All plugins available in the [MSApps Claude Plugins marketplace](https://github.com/MSApps-Mobile/claude-plugins).

---

## Documentation

- 📄 [Whitepaper](https://github.com/MSApps-Mobile/claude-plugins/blob/main/docs/sosa-whitepaper.md)
- 📋 [Enforcement Guide](https://github.com/MSApps-Mobile/claude-plugins/blob/main/docs/SOSA-ENFORCEMENT.md)
- ✅ [Compliance Checklist](https://github.com/MSApps-Mobile/claude-plugins/blob/main/plugins/sosa-compliance-checker/skills/sosa-audit/references/sosa-checklist.md)

---

## Built by MSApps

[MSApps](https://msapps.mobi) — Israeli boutique software development studio, est. 2010.

Questions: michal@msapps.mobi | [GitHub Issues](https://github.com/MSApps-Mobile/sosa/issues)
