# Contributing to SOSA™

Thanks for helping govern the agents. SOSA is a **specification**, so most
contributions are one of four shapes:

| Shape | Where it goes | Review bar |
|---|---|---|
| **Platform mapping** — how the four pillars land in a framework we don't cover yet (Semantic Kernel, Pydantic AI, Mastra, Strands…) | `README.md` → Platform Adaptation Guide, plus a section in `docs/SPECIFICATION.md` | Must show the *concrete artifact* for Role, Tools and Trust Gradient — not a claim that it "supports" them |
| **Linter rule** — a new check in `scripts/sosa-lint.sh` | `scripts/` | Must map to a numbered pillar check and must not produce false positives on this repo |
| **Spec clarification** — an ambiguity in a compliance level or the `A = (R, T, M, P)` tuple | `docs/SPECIFICATION.md` | Open an issue first; spec changes are versioned |
| **Field report** — you ran SOSA on a real agent fleet and something didn't fit | [Discussions](https://github.com/MSApps-Mobile/sosa/discussions) | None. These are the most useful contributions we get. |

## Ground rules

1. **Platform-agnostic or it doesn't ship.** SOSA describes governance, not a
   vendor. A rule that only works with one SDK belongs in that SDK's adapter
   repo ([sosa-openai](https://github.com/MSApps-Mobile/sosa-openai)), not here.
2. **Every claim in the README must be executable.** If you document a script,
   a workflow, or a command, CI has to run it. We shipped a broken
   `sosa-lint.sh` once; the CI workflow in `.github/workflows/sosa-lint.yml`
   exists so it can't happen twice.
3. **No unversioned spec drift.** Changing what L1/L2/L3 *require* is a spec
   version bump, discussed in an issue before the PR.

## Local check before you push

```bash
bash -n scripts/sosa-lint.sh      # the script must parse
./scripts/sosa-lint.sh .          # and run against this repo
```

## PR checklist

Every PR carries the four-pillar checklist:

- [ ] **Supervised:** are approval gates defined for high-risk actions?
- [ ] **Orchestrated:** is the execution efficient — no bloated context or redundant tools?
- [ ] **Secured:** no hardcoded secrets? injection scanning? least privilege?
- [ ] **Agents:** role spec complete? tool manifest declared? memory scope defined?

## Good first issues

Look for the [`good first issue`](https://github.com/MSApps-Mobile/sosa/labels/good%20first%20issue)
label. Platform mappings are the easiest place to start — you need to know one
agent framework well, not SOSA.

## Licence

By contributing you agree your work ships under the [MIT Licence](LICENSE).
