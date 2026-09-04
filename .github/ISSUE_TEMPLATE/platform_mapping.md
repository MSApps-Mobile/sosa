---
name: Platform mapping
about: Map the four pillars onto an agent framework SOSA does not yet cover
title: 'Platform mapping: <framework>'
labels: enhancement, good first issue
assignees: ''
---

**Framework**
Name, version, and a link to its docs.

**Role spec (R)** — where does an agent's role/boundary live in this framework?

**Tool manifest (T)** — where are tools declared, and can permissions be scoped per tool?

**Memory (M)** — what persistence primitives exist, and what scopes (session / persistent / shared)?

**Planning (P)** — reactive, proactive, or scheduled? Where is that configured?

**Trust gradient** — what mechanism can halt an action for human approval?
(hooks, guardrails, graph conditionals, interrupt/resume…)

**Gaps**
Which pillar has *no* concrete artifact in this framework? That gap is the
interesting part — say so rather than stretching a mapping to fit.
