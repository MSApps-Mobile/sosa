# SOSA™ Specification v1.0

*Supervised Orchestrated Secured Agents — A Methodology for Production-Grade Autonomous AI Operations*

**Author:** Michal Shatz, MSApps Research
**Date:** March 2026
**Status:** Open Standard

---

## 1. Introduction

SOSA is a governance methodology that ensures autonomous AI agents meet production-grade safety, efficiency, and accountability standards — regardless of the underlying platform.

This specification is platform-agnostic. It applies equally to Claude plugins, OpenAI Agents SDK workflows, LangChain chains, CrewAI crews, or any system where AI agents take actions autonomously.

## 2. Core Principles

### 2.1 Supervision is Graduated, Not Binary

Traditional AI safety treats human oversight as all-or-nothing. SOSA introduces a **trust gradient**:

- **Autonomous**: Proven low-risk actions execute without human approval
- **Notify**: Medium-risk actions execute but alert the human
- **Approve**: High-risk actions require explicit human confirmation
- **Blocked**: Certain actions are never permitted regardless of trust level

The trust gradient is dynamic — agents that consistently succeed earn expanded autonomy. Agents that fail get reduced.

### 2.2 Orchestration Demands Efficiency

An orchestrated system that wastes resources on redundant work, bloated context, or duplicate components is poorly orchestrated by definition.

- Skill descriptions must be lean and trigger-accurate
- Shared rules externalized to structured stores, not duplicated
- Unused tool connectors eliminated
- Task frequency matches actual change cadence
- Token budgets treated as shared finite resources

### 2.3 Security is Layered

| Layer | Requirement |
|-------|------------|
| Credentials | Never hardcoded; use environment variables or secure stores |
| Tool Access | Declared capability sets with principle of least privilege |
| Input | Prompt injection scanning on all external data |
| Dependencies | Pinned versions for all packages and servers |
| Output | Audit logging of all agent actions and decisions |
| Context | Isolation between agent sessions; no cross-contamination |

### 2.4 Agents Are Formally Defined

Every agent is a tuple **A = (R, T, M, P)**:

- **R (Role)**: What the agent does, doesn't do, and its boundaries
- **T (Tools)**: Explicit manifest of every tool with declared permissions
- **M (Memory)**: Defined context store with scope (session, persistent, shared)
- **P (Planning)**: How the agent decides — reactive, proactive, or scheduled

## 3. Execution Model

### 3.1 Plan → Act → Verify Loop

**Plan:**
- Assess resource costs (tokens, API calls, time)
- Define success criteria before acting
- Check permissions against the trust gradient
- Identify escalation points

**Act:**
- Execute with full logging
- Enforce escalation thresholds (cost, risk, scope)
- Track all tool invocations and results
- Maintain rollback capability where possible

**Verify:**
- Evaluate results against pre-defined success criteria
- Measure efficiency (tokens used, time elapsed, API calls)
- Generate audit trail entry
- Update trust gradient based on outcome

### 3.2 Escalation Protocol

1. Stop execution immediately
2. Log the situation with full context
3. Escalate to human with clear description and options
4. Wait for explicit human decision
5. Resume only after human authorization

## 4. Compliance Levels

### Level 1 — Basic
- [ ] Role specification exists for every agent
- [ ] Dependencies pinned to specific versions
- [ ] No hardcoded secrets in codebase
- [ ] Basic documentation exists

### Level 2 — Standard
- [ ] All Level 1 requirements
- [ ] Prompt injection scanning on external inputs
- [ ] Audit logging of all agent actions
- [ ] Capability declaration (explicit tool manifests)
- [ ] Token efficiency monitoring
- [ ] Error handling with graceful degradation

### Level 3 — Full
- [ ] All Level 2 requirements
- [ ] Human approval gates for high-risk actions
- [ ] Structured Plan → Act → Verify execution loops
- [ ] Dynamic trust gradient with history
- [ ] System-wide auditing across all agents
- [ ] Cross-agent isolation verified
- [ ] Efficiency benchmarks met

## 5. Platform Adaptation Guide

### 5.1 Claude Code / Cowork
- Role spec → `SKILL.md`
- Tool manifest → `.claude-plugin/plugin.json` + MCP declarations
- Memory → Session context, Notion stores
- Planning → Skill triggers + hook lifecycle

### 5.2 OpenAI Agents SDK
- Role spec → Agent `instructions` parameter
- Tool manifest → `tools` array with function definitions
- Memory → Thread context, external stores
- Planning → Handoff policies, guardrail validators
- Trust gradient → Custom guardrail checking action risk level

### 5.3 OpenAI AgentKit
- Role spec → Agent Builder node configuration
- Tool manifest → Connector Registry declarations
- Memory → Agent Builder state management
- Planning → Visual DAG in Agent Builder canvas

### 5.4 LangChain / LangGraph
- Role spec → System prompt + chain metadata
- Tool manifest → Tool binding declarations
- Memory → ConversationBufferMemory, VectorStoreMemory
- Planning → Graph state transitions, conditional edges

### 5.5 CrewAI
- Role spec → Agent `role`, `goal`, `backstory`
- Tool manifest → Agent `tools` list
- Memory → Crew shared memory
- Planning → Task delegation policies

---

© 2026 MSApps Research. Released under MIT License.
