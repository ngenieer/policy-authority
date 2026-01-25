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

## v0.1-authority-instance-2
**Date:** 2026-01-25  
**Tag:** `v0.1-authority-instance-2`

### Event
Declared a new Authority instance after updating sealed constitutional files and regenerating sealed hashes.

### Declaration
- `authority/AUTHORITY_LIMITS.md` and `authority/OVERRIDE_BOUNDARIES.md` updated.
- `authority/SEALED_HASHES.yml` regenerated to reflect the new sealed file hashes.
- Commit messages include `NEW_AUTHORITY_INSTANCE_ACK` to record the instance boundary change.

### Enforcement
- `scripts/ci/ci_guard.sh` now permits sealed-file changes only when explicitly acknowledged (`NEW_AUTHORITY_INSTANCE_ACK` or `ALLOW_NEW_AUTHORITY_INSTANCE=1`), preserving auditability.
- Sealed hashes align with the updated sealed files for this instance.

### Scope
- Applies to Authority instance #2 for the v0.1 line.
- Does not alter Engine v0.1 semantics or the `v0.1-engine-freeze` event.

### Rationale
Maintains immutable historical record by capturing the new Authority instance boundary and sealed artifacts at the point of change.

---

_End of ledger._
