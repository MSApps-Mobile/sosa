<p align="center">
  <a href="https://github.com/MSApps-Mobile/sosa/stargazers"><img src="https://img.shields.io/github/stars/MSApps-Mobile/sosa?style=social" alt="GitHub Stars"></a>
  <img src="https://img.shields.io/github/forks/MSApps-Mobile/sosa?style=social" alt="GitHub Forks">
  <img src="https://img.shields.io/badge/SOSA%E2%84%A2-v1.0-brightgreen" alt="SOSA v1.0">
  <img src="https://img.shields.io/badge/license-MIT-blue" alt="MIT License">
  <a href="https://hits.seeyoufarm.com"><img src="https://hits.seeyoufarm.com/api/count/incr/badge.svg?url=https%3A%2F%2Fgithub.com%2FMSApps-Mobile%2Fsosa&count_bg=%2379C83D&title_bg=%23555555&title=visitors&edge_flat=false" alt="Visitors"></a>
</p>

<p align="center">
  <a href="https://github.com/MSApps-Mobile/sosa/stargazers">
    <img src="https://img.shields.io/badge/%E2%AD%90_Found_this_useful%3F-Star_on_GitHub-yellow?style=for-the-badge&logo=github" alt="Star on GitHub">
  </a>
</p>

# SOSA™ — Supervised Orchestrated Secured Agents

> **A governance framework for production-grade autonomous AI operations.**

**Platform-agnostic. Works with Claude, OpenAI, LangChain, CrewAI, AutoGen, or any agent system.**

If you find SOSA useful, please ⭐ **[star this repo](https://github.com/MSApps-Mobile/sosa/stargazers)** — it helps other developers discover the framework and motivates us to keep building.

---

## Why SOSA

AI agents are shipping to production without governance standards. Bug bounties find vulnerabilities after deployment. Security researchers discover prompt injection paths in live systems. Token costs spiral because nobody measures waste.

Every agent framework gives you tools to **build** agents. None of them tell you how to **govern** them.

SOSA fills that gap. It prevents architectural vulnerabilities _before_ an agent ever runs — not after.

---

## The Four Pillars

### 🛡️ Supervised — Graduated Human Oversight

Traditional AI safety treats human oversight as all-or-nothing. SOSA introduces a **trust gradient**:

| Mode | When Applied | Behavior |
|------|-------------|----------|
| **Autonomous** | Proven low-risk actions | Execute without human approval |
| **Notify** | Medium-risk actions | Execute and alert the human |
| **Approve** | High-risk actions | Halt and require explicit confirmation |
| **Blocked** | Prohibited actions | Never permitted regardless of trust level |

The trust gradient is **dynamic** — agents that consistently succeed earn expanded autonomy. Agents that fail or exceed scope get reduced autonomy automatically.

**In practice:** An outreach agent can't send 500 emails without your sign-off. An agent that consistently produces clean PRs earns the right to auto-merge formatting changes.

### ⚙️ Orchestrated — Structured Efficiency

Agents follow **Plan → Act → Verify**. Tasks are coordinated through DAG execution, not ad-hoc messaging. Orchestration demands efficiency:

- Skill descriptions must be lean and trigger-accurate
- Shared rules externalized to structured stores, not duplicated across agents
- Unused tool connectors eliminated
- Task frequency matches actual change cadence
- Token budgets are treated as shared, finite resources

**Waste is an orchestration failure, not just a performance issue.**

### 🔒 Secured — Layered Zero Trust

| Layer | Requirement |
|-------|------------|
| **Credentials** | Never hardcoded — use environment variables or secure stores |
| **Tool Access** | Declared capability sets with principle of least privilege |
| **Input** | Prompt injection scanning on all external data |
| **Dependencies** | Pinned versions for all packages and MCP servers |
| **Output** | Audit logging of all agent actions and decisions |
| **Context** | Session isolation — no cross-agent context contamination |

### 🤖 Agents — Formally Defined

Every SOSA agent is a tuple **A = (R, T, M, P)**:

| Component | Symbol | Definition |
|-----------|--------|-----------|
| Role | **R** | What the agent does, what it doesn't do, and its operational boundaries |
| Tools | **T** | Explicit manifest of every tool with declared permissions and scope |
| Memory | **M** | Defined context store with scope: session, persistent, or shared |
| Planning | **P** | How the agent decides: reactive (trigger-based), proactive, or scheduled |

Informal agents — those without complete definitions — are **not SOSA-compliant**.

---

## Execution Model: Plan → Act → Verify

Every SOSA agent operation follows a structured three-phase loop:

### Plan
- Assess resource costs (tokens, API calls, time)
- Define success criteria _before_ acting
- Check permissions against the current trust gradient
- Identify escalation points — what triggers a human handoff

### Act
- Execute with full logging of every tool invocation and result
- Enforce escalation thresholds: cost, risk, or scope breaches stop execution
- Track all API calls, file operations, and external communications
- Maintain rollback capability wherever technically feasible

### Verify
- Evaluate results against the pre-defined success criteria from Plan
- Measure efficiency: tokens consumed, time elapsed, API calls made
- Generate a structured audit trail entry
- Update the trust gradient based on outcome

**Escalation protocol:** When any agent encounters a condition exceeding its trust level — stop immediately, log with full context, escalate to human with clear options, wait for explicit decision, resume only after authorization.

---

## Compliance Levels

SOSA defines three compliance levels, each a strict superset of the previous:

| Level | Name | Requirements |
|-------|------|-------------|
| **L1** | Basic | Role spec, pinned dependencies, no hardcoded secrets, basic docs |
| **L2** | Standard | L1 + injection scanning, audit logging, capability declaration, token efficiency, error handling |
| **L3** | Full | L2 + approval gates, Plan→Act→Verify loops, dynamic trust gradient, cross-agent isolation, system-wide auditing, efficiency benchmarks |

---

## SOSA for Code

SOSA extends naturally to **AI coding agents** — systems that autonomously generate, review, refactor, and deploy code. The **"SOSA for Code"** paper introduces:

- **Plan-Code-Verify** — a code-specific instantiation of Plan→Act→Verify for the software development lifecycle
- **Graduated code supervision** — five levels (L0–L4) from auto-merge formatting fixes to human-only production deploys
- **Multi-agent development coordination** — orchestrated task DAGs preventing merge conflicts and architectural drift
- **Codebase knowledge models** — the extended tuple A_code = (R, T, M, P, K) where K captures architectural patterns, conventions, and technical debt
- **Trust gradients for repositories** — agents earn autonomy per-repo through demonstrated reliability

| Level | Scope | Example | Review |
|-------|-------|---------|--------|
| L0 — Auto | Formatting, comments, docs | Fix typo in README | None (auto-merge) |
| L1 — Async | Single-file, non-critical | Add unit test | Post-merge review |
| L2 — Pre-merge | Multi-file, business logic | New API endpoint | 1 human reviewer |
| L3 — Gated | Security, infra, shared libs | Auth flow change | Senior + security review |
| L4 — Prohibited | Production deploy, DB migration | Schema migration | Human-only execution |

> 📄 **Read the full paper:** [SOSA™ for Code: A Methodology for Governing AI Coding Agents](docs/sosa-for-code.md) (Shatz, 2026)

---

## Platform Adaptation Guide

SOSA is platform-agnostic. The formal agent definition maps to concrete artifacts in every major framework:

| Platform | Role Spec | Tool Manifest | Trust Gradient |
|----------|-----------|---------------|----------------|
| **Claude Code / Cowork** | `SKILL.md` | `plugin.json` + MCP declarations | Hook lifecycle |
| **OpenAI Agents SDK** | `instructions` param | `tools[]` array | Guardrail validators |
| **LangChain / LangGraph** | System prompt | Tool bindings | Graph conditionals |
| **CrewAI** | `role` / `goal` / `backstory` | `tools` list | Task delegation |
| **OpenAI AgentKit** | Agent Builder node | Connector Registry | Visual DAG |
| **AutoGen** | Agent config | Message filter | Human-in-the-loop |

> 🔗 **OpenAI-specific implementation:** [sosa-openai](https://github.com/MSApps-Mobile/sosa-openai) — Trust gradients, compliance auditing, and structured supervision for OpenAI Agents SDK and AgentKit.

---

## SOSA Plugins for Claude

Production-ready plugins that implement SOSA governance, available in the [MSApps Claude Plugins marketplace](https://github.com/MSApps-Mobile/claude-plugins):

| Plugin | What it does | Install |
|--------|-------------|---------|
| [**sosa-governor**](https://github.com/MSApps-Mobile/claude-plugins/tree/main/plugins/sosa-governor) | Real-time governance layer — classifies, gates, and logs every MCP tool call | `sosa-governor@msapps-plugins` |
| [**sosa-orchestrator**](https://github.com/MSApps-Mobile/claude-plugins/tree/main/plugins/sosa-orchestrator) | Token-aware task prioritization and budget management | `sosa-orchestrator@msapps-plugins` |
| [**sosa-compliance-checker**](https://github.com/MSApps-Mobile/claude-plugins/tree/main/plugins/sosa-compliance-checker) | Audit any plugin ecosystem against SOSA — catches hardcoded keys, missing gates, injection vulnerabilities | `sosa-compliance-checker@msapps-plugins` |
| [**token-efficiency-audit**](https://github.com/MSApps-Mobile/claude-plugins/tree/main/plugins/token-efficiency-audit) | Find and fix token waste — typical savings: 20–50% | `token-efficiency-audit@msapps-plugins` |

```bash
# Install the full SOSA suite
/plugin marketplace add MSApps-Mobile/claude-plugins
/plugin install sosa-governor@msapps-plugins
/plugin install sosa-orchestrator@msapps-plugins
/plugin install sosa-compliance-checker@msapps-plugins
/plugin install token-efficiency-audit@msapps-plugins
```

> **Pro tip:** Run `sosa-compliance-checker` on _all_ your installed plugins — not just ours. It catches issues in any plugin.

---

## Enforcement

SOSA compliance is enforced at three levels:

### 1. CI/CD — GitHub Actions (Automatic)
Every PR and push to `main` triggers the SOSA lint workflow — four-pillar compliance check, secret scanning, role spec presence verification, and token efficiency warnings. **PRs that fail cannot be merged.**

### 2. Local Linting (Pre-push)
```bash
./scripts/sosa-lint.sh /path/to/your/agent
```

### 3. PR Review Checklist (Human)
Every PR includes the four-pillar checklist:

- [ ] **Supervised:** Are approval gates defined for high-risk actions?
- [ ] **Orchestrated:** Is the execution efficient? No bloated context or redundant tools?
- [ ] **Secured:** No hardcoded secrets? Injection scanning? Least privilege enforced?
- [ ] **Agents:** Role spec complete? Tool manifest declared? Memory scope defined?

---

## Documentation

| Document | Description |
|----------|-------------|
| [**Specification v1.0**](docs/SPECIFICATION.md) | Complete SOSA technical specification — principles, execution model, compliance levels, platform mappings |
| [**SOSA for Code**](docs/sosa-for-code.md) | Extended white paper on governing AI coding agents across the SDLC |
| [**Enforcement Guide**](docs/ENFORCEMENT.md) | CI/CD, local linting, and human review enforcement |
| [**SOSA for OpenAI**](https://github.com/MSApps-Mobile/sosa-openai) | Governance layer for OpenAI Agents SDK and AgentKit |
| [**Claude Plugins**](https://github.com/MSApps-Mobile/claude-plugins) | 31 production plugins built on SOSA, including 4 SOSA governance plugins |

---

## Reference Implementation

[**OpsAgent**](https://github.com/MSApps-Mobile/claude-plugins) by MSApps — 18+ production agent types running under SOSA governance since early 2025, across sales, recruiting, invoicing, security research, outreach, and development workflows.

---

## Quick Start

**Audit your existing agents:**
```bash
./scripts/sosa-lint.sh /path/to/your/agent
```

**Install SOSA governance for Claude:**
```bash
/plugin marketplace add MSApps-Mobile/claude-plugins
/plugin install sosa-compliance-checker@msapps-plugins
```

**Apply to your own framework:**
1. Define each agent as a tuple (R, T, M, P)
2. Classify actions by impact level and assign supervision thresholds
3. Implement the Plan → Act → Verify loop
4. Pin dependencies, scan inputs, log everything
5. Start at L1 — graduate to L3 as governance matures

---

## Related Repositories

| Repository | Description |
|------------|-------------|
| [**sosa-spec**](https://github.com/MSApps-Mobile/sosa-spec) | Platform-agnostic SOSA specification (canonical spec source) |
| [**sosa-openai**](https://github.com/MSApps-Mobile/sosa-openai) | SOSA governance layer for OpenAI Agents SDK and AgentKit |
| [**claude-plugins**](https://github.com/MSApps-Mobile/claude-plugins) | 31 production Claude plugins built on the SOSA framework |

---

## Community

- 💬 [Open an issue](https://github.com/MSApps-Mobile/sosa/issues) for bugs or feature requests
- ⭐ Star the repo to help others find it

---

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=MSApps-Mobile/sosa&type=Date)](https://star-history.com/#MSApps-Mobile/sosa&Date)

---

## License

MIT — use it, fork it, build on it.

## Author

Created by [Michal Shatz](https://linkedin.com/in/michalshatz) / [MSApps](https://msapps.mobi)

Part of the [OpsAgent](https://www.linkedin.com/company/opsagent) project.

Questions: michal@msapps.mobi | [GitHub Issues](https://github.com/MSApps-Mobile/sosa/issues)

---

<p align="center">
  Built by <a href="https://msapps.mobi">MSApps</a> · <a href="https://github.com/MSApps-Mobile/sosa">github.com/MSApps-Mobile/sosa</a>
</p>
