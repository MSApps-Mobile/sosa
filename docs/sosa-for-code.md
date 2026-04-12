# SOSA™ for Code: Supervised Orchestrated Secured Agents

*A Methodology for Governing AI Coding Agents and Software Project Operations*

**Michal Shatz**
**MSApps Research**
**michal@msapps.mobi**
**March 2026**

---

## Abstract

AI coding agents—systems that autonomously generate, review, refactor, and deploy code—are rapidly becoming central participants in software engineering workflows. Yet the industry lacks a coherent governance framework for determining when these agents should act independently, when they require human oversight, and how multiple coding agents should coordinate across the software development lifecycle. Ungoverned coding agents introduce a novel category of engineering risk: silent technical debt accumulation, unreviewed security vulnerabilities committed at machine speed, and architectural drift that compounds across thousands of autonomous commits. We apply the SOSA™ (Supervised Orchestrated Secured Agents) methodology—originally developed for enterprise operations automation—to the specific domain of AI-assisted software engineering. We demonstrate how each SOSA pillar maps to concrete governance primitives for code generation, review, testing, deployment, and project coordination. We introduce the Plan-Code-Verify execution model, a code-specific instantiation of SOSA's Plan-Act-Verify loop, and define formal trust gradient mechanics for progressive coding autonomy. This paper provides engineering teams and platform architects with a principled framework for deploying coding agents that are productive without being reckless.

**Keywords:** AI coding agents, software engineering automation, code generation governance, multi-agent development, SDLC automation, developer tools, agentic coding, code review, CI/CD agents

---

## 1. Introduction

Software engineering is undergoing its most fundamental transformation since the introduction of version control. Large language models (LLMs) equipped with tool-use capabilities, persistent context, and file system access have evolved beyond code completion into fully autonomous coding agents: systems that can analyze requirements, plan implementations, write code across multiple files, execute tests, interpret failures, and iterate toward working solutions—all without human intervention at each step.

The commercial landscape reflects this shift. Claude Code, GitHub Copilot Workspace, Cursor, Windsurf, Devin, and a growing ecosystem of agentic coding tools have moved from novelty demonstrations to daily use by millions of developers. Industry surveys indicate that over 70% of professional developers now use AI-assisted coding tools in some capacity [1]. The most advanced of these systems can sustain autonomous coding sessions lasting hours, producing hundreds of lines of production code per session.

Yet this velocity creates a governance vacuum. When a human developer writes code, organizational controls—code review, CI pipelines, architectural review boards, security scanning—mediate the path from intent to production. These controls evolved over decades to address known failure modes: logic errors, security vulnerabilities, architectural inconsistencies, and undocumented assumptions. AI coding agents operate at speeds that overwhelm these existing controls. A coding agent can generate and commit code faster than any human reviewer can meaningfully evaluate it. The result is a growing body of agent-authored code that has never been critically reviewed—code that may function correctly in isolation but accumulate technical debt, introduce subtle security flaws, or drift from architectural intent at a pace invisible to engineering leadership.

The failure modes are specific and consequential. Under-governed agents produce code that passes tests but violates team conventions, introduces dependency sprawl, or implements expedient solutions that create maintenance burdens. Over-governed agents require approval at every file write, reducing them to expensive autocomplete engines that deliver marginal productivity gains. Both extremes stem from the same root cause: the absence of a structured methodology for calibrating coding agent autonomy against software engineering risk.

This paper applies SOSA™—Supervised Orchestrated Secured Agents—to the domain of AI-assisted software engineering. SOSA was originally developed as a general methodology for governing autonomous AI agents in enterprise operations [2]. Here we demonstrate that its four pillars—Supervised, Orchestrated, Secured, Agents—map naturally to the governance requirements of coding agents operating across the full software development lifecycle (SDLC): from requirements analysis through code generation, testing, deployment, and ongoing maintenance.

## 2. Related Work

### 2.1 AI Coding Assistants and Agents

The evolution from code completion to coding agents has occurred in distinct phases. GitHub Copilot [3] demonstrated that LLM-based code suggestion could achieve broad developer adoption, but operated as a reactive tool embedded within the editor—it suggested; the developer decided. Cursor and Windsurf extended this model with multi-file editing capabilities and conversational interfaces, but retained the human-in-the-loop at every edit boundary. Claude Code [4] and Devin [5] represent the agentic frontier: systems that accept high-level task descriptions and autonomously plan, implement, test, and iterate. These tools possess genuine autonomy—they make architectural decisions, choose implementation strategies, and recover from errors without human guidance at each step.

None of these systems, however, embed governance as a first-class concern. Autonomy boundaries are configured through ad-hoc permission flags (e.g., "allow file writes", "allow shell commands") rather than through a principled framework that considers impact magnitude, reversibility, and organizational risk tolerance. SOSA provides this missing governance layer.

### 2.2 DevOps and CI/CD Automation

The DevOps movement established that software delivery pipelines benefit from automation at every stage: build, test, deploy, monitor [6]. CI/CD platforms (GitHub Actions, GitLab CI, Jenkins, CircleCI) automate deterministic workflows triggered by code events. However, these systems execute fixed scripts—they do not reason, adapt, or make judgment calls. The introduction of AI agents into the SDLC creates a fundamentally different automation paradigm: agents that make non-deterministic decisions about code structure, implementation strategy, and error recovery. Existing CI/CD governance models—pipeline approvals, environment protections, deployment gates—were designed for deterministic automation and are insufficient for governing adaptive, reasoning agents.

### 2.3 Software Engineering Process Frameworks

Traditional software engineering methodologies—Agile [7], DevOps [6], Site Reliability Engineering [8]—define processes for human teams. They assume that every code change originates from a human developer who understands context, intent, and organizational norms. The emergence of coding agents as first-class participants in the development process demands an extension of these frameworks to account for non-human contributors who possess technical capability but lack organizational context, institutional memory, and professional judgment. SOSA provides this extension by defining governance primitives that apply regardless of whether the code author is human or artificial.

### 2.4 The SOSA Foundation

The SOSA methodology was introduced in Shatz [2] as a general framework for governing autonomous AI agents in enterprise operations. SOSA defines four interdependent pillars—Supervised, Orchestrated, Secured, Agents—and a Plan-Act-Verify execution loop with an adaptive trust gradient. The original paper demonstrated SOSA through OpsAgent, a platform automating business operations across 18+ department types. This paper extends SOSA to the software engineering domain, demonstrating that the methodology's governance primitives are sufficiently general to address the unique challenges of autonomous code generation and project operations.

## 3. The Problem: Ungoverned Coding Agents

Before presenting the SOSA application to coding agents, we characterize the specific failure modes that motivate the need for a governance framework. These failure modes are distinct from those encountered in general enterprise agent deployments and require domain-specific governance responses.

### 3.1 Silent Technical Debt Accumulation

Coding agents optimize for task completion: passing tests, satisfying immediate requirements, resolving the current error. Without explicit architectural governance, agents gravitate toward expedient implementations that introduce coupling, code duplication, and inconsistent patterns. Unlike human developers, who accumulate institutional knowledge about "how we do things here," agents treat each coding session as independent. The result is codebase entropy—a gradual degradation of code quality that is invisible in any single commit but compounds across hundreds of agent-authored changes.

### 3.2 Security Vulnerabilities at Machine Speed

A human developer who introduces a SQL injection vulnerability does so in a single code review cycle. A coding agent can introduce the same vulnerability pattern across dozens of endpoints in a single session. Without security-aware governance, coding agents can propagate vulnerable patterns faster than security tooling can detect them—particularly when the agent generates code that is syntactically correct, passes unit tests, and satisfies functional requirements while containing subtle security flaws that only manifest under adversarial conditions.

### 3.3 Architectural Drift

Software architecture is the set of high-level structural decisions that constrain implementation choices: which frameworks to use, how to organize modules, where to place business logic, how to handle cross-cutting concerns. Coding agents, lacking persistent architectural awareness, may produce implementations that are locally correct but globally inconsistent. An agent tasked with adding a new API endpoint may implement it using a different pattern than the team's established convention—not because the agent is incapable of following conventions, but because no governance mechanism ensures that conventions are consistently communicated and enforced across agent sessions.

### 3.4 Review Bottleneck Inversion

Traditional development workflows assume that code production is the bottleneck and review is relatively lightweight. Coding agents invert this ratio: code production becomes nearly instantaneous, and human review becomes the critical bottleneck. Organizations that deploy coding agents without adjusting their review processes find themselves with a rapidly growing queue of agent-authored PRs that humans cannot review at the rate they are produced. The organizational response is often to rubber-stamp agent output—precisely the governance failure that SOSA is designed to prevent.

## 4. SOSA™ Applied to Coding Agents

Each SOSA pillar maps to specific governance requirements in the software engineering domain. We present these mappings below, demonstrating that the abstract SOSA framework produces concrete, implementable governance primitives when applied to coding agents.

### 4.1 Supervised: Graduated Code Oversight

The Supervised pillar requires that every coding agent operates under a defined supervision policy. In the code domain, supervision manifests as graduated review requirements calibrated to the impact of the code change.

We extend the SOSA impact scoring function to code-specific factors. For any code change *c*, the impact score *I(c)* is computed from: the number of files modified, the criticality of the files touched (infrastructure vs. UI vs. documentation), the presence of security-sensitive patterns (authentication, authorization, cryptography, data access), the reversibility of the change (additive changes are more reversible than modifications to shared interfaces), and the blast radius (changes to shared libraries affect more consumers than changes to leaf modules).

For any code change *c*, execution proceeds autonomously if *I(c) ≤ θ_code*, where *θ_code* is a repository-specific threshold. Changes exceeding *θ_code* require human review before merge, with the review depth proportional to the margin by which *I(c)* exceeds *θ_code*.

The trust gradient operates at the repository level. An agent that consistently produces high-quality changes to a specific codebase—measured by review approval rates, test stability, and post-merge defect rates—earns expanded autonomy for that repository.

**Table 1: Supervision Levels for Code Changes**

| Level | Scope | Example | Review Requirement |
|-------|-------|---------|-------------------|
| L0 — Auto | Formatting, comments, docs | Fix typo in README | None (auto-merge) |
| L1 — Async | Single-file, non-critical | Add unit test | Post-merge review |
| L2 — Pre-merge | Multi-file, business logic | New API endpoint | 1 human reviewer |
| L3 — Gated | Security, infra, shared libs | Auth flow change | Senior + security review |
| L4 — Prohibited | Production deploy, DB migration | Schema migration | Human-only execution |

### 4.2 Orchestrated: Multi-Agent Development Coordination

Software projects involve multiple concurrent activities that must be coordinated: feature development, bug fixing, refactoring, testing, documentation, and deployment. When multiple coding agents operate on the same codebase, orchestration becomes critical to prevent conflicts, ensure consistency, and maintain architectural coherence.

SOSA's orchestration layer manages this coordination through a task DAG specific to the development workflow. The orchestrator maintains a dependency graph *G_dev = (V, E)* where vertices represent development tasks (implement feature X, write tests for module Y, update documentation for API Z) and edges encode both data dependencies and semantic constraints (tests should be written against the implemented code, documentation should reflect the merged implementation).

Context sharing between coding agents is mediated through code context registries that capture architectural decisions, implementation patterns, and active constraints. When a planning agent decomposes a feature into subtasks, it writes the architectural decisions and interface contracts to the registry. Implementation agents read these contracts before writing code. Testing agents read the implementation details to generate meaningful tests. This structured context sharing prevents the fragmentation that occurs when multiple agents operate with independent, potentially contradictory assumptions about the codebase.

The orchestrator also enforces merge serialization: when multiple agents produce changes that touch overlapping files, the orchestrator sequences merges to prevent conflicts and ensures that each agent's changes are validated against the most current state of the codebase.

### 4.3 Secured: Code-Specific Zero Trust

Security in the coding domain extends beyond network boundaries and credential management. A coding agent with unrestricted file system access can read secrets from configuration files, exfiltrate code to external services, or modify build scripts to introduce supply chain vulnerabilities. The SOSA Secured pillar, applied to coding agents, mandates several code-specific security constraints.

**Sandboxed execution environments.** Each coding agent operates within a sandboxed environment that restricts file system access to the target repository, limits network access to approved services (package registries, documentation sites, CI systems), and prevents execution of arbitrary binaries outside the development toolchain.

**Scoped repository permissions.** Each agent *A_i* is assigned a capability set *C_i* that specifies which repositories, branches, and file paths it may read or modify. An agent tasked with frontend development cannot modify backend infrastructure code—not because it lacks the technical ability, but because the security layer enforces this boundary at the file system level.

**Secrets isolation.** Coding agents must never have access to production credentials, API keys, or cryptographic material. The SOSA security layer ensures that environment variables, `.env` files, and secrets management systems are excluded from the agent's capability set. Agents that require service access for testing use scoped, time-limited credentials issued by the orchestrator.

**Immutable audit trails.** Every code change, file access, shell command, and external API call is logged to an immutable audit store. The audit trail captures not just what the agent did, but the reasoning chain that led to each decision—enabling post-hoc analysis of why an agent chose a particular implementation approach and whether that choice was appropriate given the available context.

### 4.4 Agents: The Coding Agent Specification

A SOSA-compliant coding agent is defined as a tuple **A_code = (R, T, M, P, K)** where R is the role specification, T is the tool manifest, M is the memory and context store, P is the planning policy, and K is the **codebase knowledge model**—an extension of the general SOSA agent tuple that captures the agent's understanding of the specific codebase it operates on.

The codebase knowledge model K encapsulates: the repository's architectural patterns and conventions, the dependency graph between modules, the team's coding standards and style guidelines, the history of recent changes and active branches, and the known technical debt and areas of fragility. K is populated through automated codebase analysis at agent initialization and updated incrementally as the agent observes changes to the repository.

**Table 2: SOSA Coding Agent Roles**

| Role | Responsibility | Key Tools |
|------|---------------|-----------|
| Planner | Decomposes requirements into implementation tasks, defines interfaces and contracts | Codebase search, architecture docs, task registry |
| Implementer | Writes production code following specifications from Planner | File read/write, shell, package manager |
| Tester | Generates and maintains test suites, validates implementation correctness | Test runner, coverage tools, assertion libs |
| Reviewer | Evaluates code quality, security, and architectural consistency | Static analysis, linters, security scanners |
| Deployer | Manages build, release, and deployment pipelines | CI/CD APIs, container registry, infra tools |
| Monitor | Observes production metrics, detects regressions, triggers rollbacks | APM dashboards, log aggregators, alerting |

These roles are not merely labels—they are enforced by the security layer. A Tester agent cannot directly merge code; an Implementer agent cannot trigger a production deployment.

## 5. The Plan-Code-Verify Execution Model

The SOSA execution model, when applied to coding agents, becomes the **Plan-Code-Verify** loop—a code-specific instantiation of Plan-Act-Verify that incorporates the unique constraints and verification opportunities of software engineering.

### 5.1 Plan

During the planning phase, the coding agent (typically in a Planner role) analyzes the task requirements against the codebase knowledge model K. The planner identifies which files need modification, which interfaces are affected, what tests need updating, and what architectural constraints apply. The output is a structured implementation plan: a partially ordered set of code changes with explicit preconditions and expected postconditions.

Crucially, the plan is a reviewable artifact. For changes that exceed the supervision threshold *θ_code*, the plan itself is subject to human review before implementation begins. This "plan review" is far more efficient than post-implementation code review—it allows the human supervisor to catch architectural mistakes, missing requirements, or misunderstood constraints before any code is written, preventing wasted agent compute and reducing review cycles.

### 5.2 Code

During the coding phase, implementation agents execute the plan by writing code, running local tests, and iterating on failures. Each agent operates within its scoped capability set, accessing only the files and tools specified in its manifest. The orchestration layer monitors for conflicts between concurrent coding agents and mediates access to shared resources.

The coding phase includes inline verification checkpoints: after each significant code change, the agent runs the relevant test subset and validates that the change satisfies its postcondition. If a checkpoint fails, the agent enters a local recovery loop—attempting alternative implementations, consulting the codebase knowledge model for similar patterns, or escalating to the orchestrator if recovery fails after a configurable number of attempts.

### 5.3 Verify

The verification phase in the code domain is uniquely rich because software provides objective verification mechanisms that most business domains lack. Verification includes: the full test suite passes, static analysis produces no new warnings, security scanning detects no new vulnerabilities, code coverage meets or exceeds the repository threshold, the change is consistent with the architectural patterns in K, and the diff is within the expected scope (agents that modify more files than planned trigger automatic escalation).

Verification results feed into the trust gradient. An agent that consistently produces changes that pass verification on the first attempt earns expanded autonomy. An agent whose changes frequently require multiple verification cycles is automatically restricted to lower-impact tasks.

The trust gradient for coding agents is computed as:

**τ(A_i, R_j) = f(pass_rate, review_approval_rate, post_merge_defect_rate, scope_compliance)**

where *A_i* is the agent and *R_j* is the repository. Agents whose *τ* exceeds the repository's trust threshold earn progressive autonomy expansions.

## 6. SOSA Across the Software Development Lifecycle

The SOSA methodology applies not just to individual coding sessions but to the entire software project lifecycle.

### 6.1 Requirements and Planning

SOSA Planner agents analyze requirements documents, user stories, and stakeholder inputs to produce structured implementation plans. The Supervised pillar ensures that plans for high-impact features require human approval. The Orchestrated pillar ensures that planning outputs are shared through the code context registry, providing downstream agents with the architectural intent behind each requirement. Planning agents operate at supervision level L2 or L3, ensuring human oversight of consequential architectural decisions.

### 6.2 Implementation

Implementer agents execute plans by writing production code. SOSA governance ensures that each implementer operates within its scoped permissions (Secured), follows the architectural contracts defined by the planner (Orchestrated), submits changes for review at the appropriate supervision level (Supervised), and maintains a complete audit trail of every file modification and the reasoning behind it (Agents). Multiple implementers can work concurrently on non-overlapping modules, with the orchestrator preventing merge conflicts and ensuring interface consistency.

### 6.3 Testing

Tester agents generate test cases from implementation specifications, execute test suites, analyze failures, and report coverage gaps. Under SOSA, tester agents are independent from implementer agents—they cannot be configured or influenced by the agent that wrote the code they are testing. This separation of concerns, enforced by the security layer, prevents the common anti-pattern where a coding agent writes both the implementation and the tests that validate it, creating a closed loop that may miss the very failure modes the tests should detect.

### 6.4 Code Review

Reviewer agents provide automated code review as a complement to (not replacement for) human review. SOSA-compliant reviewer agents evaluate code against the codebase knowledge model K, checking for pattern consistency, security anti-patterns, performance regressions, and documentation completeness. The Supervised pillar ensures that reviewer agents escalate concerns they cannot resolve—ambiguous architectural decisions, novel security patterns, or trade-offs that require business context—to human reviewers rather than making autonomous judgments beyond their competence.

### 6.5 Deployment and Release

Deployer agents manage CI/CD pipelines, orchestrate build processes, and coordinate releases. Under SOSA, deployment is typically classified at supervision level L3 or L4: production deployments require human approval regardless of the agent's trust score. The Secured pillar ensures that deployer agents access production infrastructure through scoped, time-limited credentials and that every deployment action is logged with full attribution.

### 6.6 Monitoring and Incident Response

Monitor agents observe production systems for anomalies, correlate errors with recent deployments, and initiate automated responses. SOSA governance constrains monitor agents to diagnostic actions (reading logs, querying metrics, generating reports) at L0-L1 supervision, while remediation actions (rollbacks, configuration changes, traffic rerouting) require L3 supervision. This prevents an overeager monitor agent from triggering cascading rollbacks in response to transient anomalies while still enabling rapid automated detection and escalation.

## 7. Implications for Engineering Organizations

### 7.1 Code Quality Assurance

By mandating the Plan-Code-Verify loop with codebase-aware governance, SOSA ensures that agent-authored code meets the same quality standards as human-authored code. The codebase knowledge model K provides agents with the contextual awareness that prevents architectural drift. The trust gradient ensures that quality standards are not static rules but adaptive expectations that tighten in response to observed failures and relax in response to demonstrated reliability.

### 7.2 Security and Compliance

The Secured pillar, with its sandboxed execution, scoped permissions, and immutable audit trails, provides the governance infrastructure required for regulated industries. Financial services organizations subject to SOC 2 requirements, healthcare organizations subject to HIPAA, and government contractors subject to FedRAMP can deploy SOSA-compliant coding agents with confidence that every code change is traceable, every access is authorized, and every decision is auditable.

### 7.3 Scalable Human Oversight

The graduated supervision model solves the review bottleneck inversion. By allowing low-impact changes to proceed autonomously (L0-L1) while requiring human review only for consequential changes (L2-L4), SOSA concentrates human attention where it adds the most value. Engineering managers review architectural decisions and security-critical changes; routine implementation is delegated to agents with demonstrated reliability.

### 7.4 Multi-Agent Team Coordination

As organizations deploy multiple coding agents—potentially from different vendors—across the same codebase, the orchestration layer becomes essential. SOSA's DAG-based task coordination, structured context registries, and merge serialization prevent the chaos that would result from multiple uncoordinated agents making concurrent changes to shared code.

## 8. Conclusion

The deployment of AI coding agents in professional software engineering is not a speculative future—it is a present reality reshaping how code is produced, reviewed, and maintained. The SOSA methodology, applied to this domain, provides the governance framework that transforms coding agents from impressive but unpredictable tools into reliable, accountable participants in the software development process.

By mapping each SOSA pillar to concrete coding governance primitives—graduated supervision levels for code changes, orchestrated multi-agent development coordination, zero-trust security for code access and execution, and formally specified agent roles with codebase knowledge models—we demonstrate that principled governance does not require sacrificing the productivity gains that coding agents provide. The Plan-Code-Verify execution model, with its adaptive trust gradient, creates a system where agents earn autonomy through verifiable performance rather than demanding it through configuration.

The implications extend beyond individual tools. As the software industry converges on agent-assisted development as a standard practice, organizations that adopt structured governance frameworks will deploy agents that produce consistent, secure, and architecturally coherent code. Organizations that do not will accumulate agent-authored technical debt at a pace that no human team can remediate.

Future work includes formal specification of the trust gradient function using techniques from reputation systems theory, development of standardized codebase knowledge model formats for interoperability between coding agents from different vendors, empirical measurement of SOSA governance overhead across different organization sizes and codebase complexities, and extension of the methodology to address the emerging challenge of agents that train or fine-tune other agents for code-specific tasks.

## References

[1] Stack Overflow. "Developer Survey 2025: AI Tools in Software Development." Stack Overflow Annual Survey, 2025.

[2] Shatz, M. "SOSA™: Supervised Orchestrated Secured Agents — A Methodology for Production-Grade Autonomous AI Operations." MSApps Research, March 2026.

[3] Chen, M., et al. "Evaluating Large Language Models Trained on Code." arXiv:2107.03374, 2021.

[4] Anthropic. "Claude Code: Agentic Coding Tool." Product documentation, 2025.

[5] Cognition AI. "Devin: The First AI Software Engineer." Product announcement, 2024.

[6] Kim, G., et al. "The DevOps Handbook: How to Create World-Class Agility, Reliability, & Security in Technology Organizations." IT Revolution Press, 2016.

[7] Beck, K., et al. "Manifesto for Agile Software Development." agilemanifesto.org, 2001.

[8] Beyer, B., et al. "Site Reliability Engineering: How Google Runs Production Systems." O'Reilly Media, 2016.

[9] Wu, Q., et al. "AutoGen: Enabling Next-Gen LLM Applications via Multi-Agent Conversation." arXiv:2308.08155, 2023.

[10] Yao, S., et al. "ReAct: Synergizing Reasoning and Acting in Language Models." ICLR, 2023.

[11] National Institute of Standards and Technology. "AI Risk Management Framework (AI RMF 1.0)." NIST, January 2023.

[12] European Parliament. "Regulation (EU) 2024/1689 Laying Down Harmonised Rules on Artificial Intelligence (AI Act)." Official Journal of the European Union, 2024.

[13] Rose, S., et al. "Zero Trust Architecture." NIST Special Publication 800-207, August 2020.

[14] Shinn, N., et al. "Reflexion: Language Agents with Verbal Reinforcement Learning." NeurIPS, 2023.

[15] Jimenez, C.E., et al. "SWE-bench: Can Language Models Resolve Real-World GitHub Issues?" arXiv:2310.06770, 2023.

---

© 2026 MSApps Research. All rights reserved.
