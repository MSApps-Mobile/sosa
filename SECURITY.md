# Security Policy

SOSA is a governance specification plus a shell linter — it holds no
credentials and reaches no network. The realistic vulnerability classes here
are:

* a **linter rule that fails open** (reports PASS on a genuinely non-compliant
  agent), and
* **spec guidance that would make an implementing system less safe**.

Both are in scope and both are worth reporting.

## Reporting

Email **michal@msapps.mobi** with `[SOSA SECURITY]` in the subject, or open a
[private security advisory](https://github.com/MSApps-Mobile/sosa/security/advisories/new).

Please include: the rule or spec section, a minimal agent definition that
demonstrates the miss, and what the correct verdict should have been.

Expect an acknowledgement within 5 working days.

## Out of scope

* Findings against systems that merely *implement* SOSA — report those to that
  system's maintainer.
* Prompt-injection findings against a specific LLM vendor — report to that
  vendor's bug bounty programme.

## Supported versions

The `main` branch is the supported version. SOSA spec versions are documented
in [`docs/SPECIFICATION.md`](docs/SPECIFICATION.md).
