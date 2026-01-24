# Policy Authority – Release Ledger

This document records **irreversible constitutional events** in the evolution of Policy Authority.

It is not a changelog of features.
It is a ledger of moments where meaning, authority, or boundaries were deliberately frozen.

---

## v0.1-engine-freeze
**Date:** 2026-01-24  
**Tag:** `v0.1-engine-freeze`

### Event
Semantic freeze of the Policy Authority Engine v0.1.

### Declaration
From this tag forward, the meaning of Engine v0.1 is immutable.

- The Engine is **FAIL-only** and **non-interpretive**.
- The normative output contract is frozen in `engine/verdict.schema.json (v0.1)`.
- The semantic meaning of `PASS` and `FAIL` MUST NOT change.

### Enforcement
- `engine/ENGINE_FREEZE.md` declares the frozen semantics.
- A unified CI Guard (`scripts/ci/ci_guard.sh`) enforces:
  - Frozen engine surfaces
  - Frame immutability
  - Authority governance
  - Boundary constraints
- The CI Guard is wired into GitHub Actions as a mandatory gate.

### Scope
- This freeze applies only to **Engine v0.1**.
- New Engine lines (e.g. v0.2) MUST be introduced as separate, explicit freeze events.
- Existing v0.1 verdicts MUST NEVER be reinterpreted or re-evaluated.

### Rationale
The Engine serves as the fixed reference point for all Frames, Snapshots, and Authority actions.
Freezing its semantics establishes time irreversibility and prevents retroactive reinterpretation.

### Maintenance Status

As of this release, Engine v0.1 is in maintenance-only mode.
Only changes that do not affect semantics, meaning, or interpretation
(e.g. documentation fixes, CI stability, or tooling robustness)
may be applied.

---

_End of ledger._
