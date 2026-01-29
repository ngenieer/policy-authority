# Policy Authority

> Policy Authority is a deterministic, constitution-driven system that fixes what may change — and what must never change.
>
> It is infrastructure, not a service.  
> It enforces decisions fixed in advance.  
> It does not review, advise, or judge.

📚 **Start here:** See [INDEX.md](./INDEX.md) for the constitutional map and normative documents of Policy Authority v0.1.


---

## Overview

Policy Authority is an open infrastructure for enforcing **pre-defined, human-authored decision criteria** in environments where AI agents and automation execute changes faster than humans can review them.

This system does **not** make decisions.
It executes decisions that were deliberately fixed **before execution**, and preserves evidence of *who decided what, and why*.

The **intent and scope of v0.1** are formally specified in the following normative documents:

- `Product_Definition_v0.1.md`
- `Infrastructure_Requirements_v0.1.md`

All implementations, agents, and tools **MUST conform** to these documents.

---

## What This System Is

- A deterministic policy enforcement engine
- A mechanism for binding execution to pre-declared criteria
- An audit-ready system that preserves attribution and evidence
- Infrastructure designed to be embedded into other systems

---

## What This System Is Not

- Not an AI decision-maker
- Not a code review or quality analysis tool
- Not an advisory or recommendation system
- Not a governance platform or approval workflow

If a rule is not written down, this system does not enforce it.

---

## Core Concepts

### Policy Snapshot

A **Policy Snapshot** is an immutable bundle of policy rules that represents a fixed set of enforcement criteria at a specific point in time.

Each snapshot:
- Is versioned and hash-identified
- Is referenced explicitly during execution
- Can be verified independently

There is no concept of a "latest" policy.

---

### Evaluation Engine

The Evaluation Engine applies policy snapshots to a target repository **deterministically**.

For v0.1, the engine:
- Uses file-based glob matching
- Performs plain-text substring checks
- Produces PASS or FAIL verdicts only

The binding implementation requirements are defined in:
- `docs/audit/Evaluation_Engine_Checklist_v0.1.md`

---

### Verdict Artifact

Every evaluation produces a `verdict.json` artifact containing:
- The final verdict (PASS / FAIL)
- Policy snapshot identity
- Target repository reference
- Evidence for any violations

Verdicts are reproducible and verifiable.

---

## Documentation Structure

Policy Authority documentation is layered intentionally.

### Institutional Layer
- `DECLARATION.md` — Why this system exists
- `GOVERNANCE.md` — Authority, responsibility, and issuance rules
- `FAQ.md` — Boundary clarifications and misconceptions
- `CONTRIBUTING.md` — Contribution constraints and rejection criteria

### Product Definition Layer (v0.1)
- `Product_Definition_v0.1.md` — What this product is and is not
- `Infrastructure_Requirements_v0.1.md` — Fixed scope and system requirements

### Execution Contract Layer
- `docs/audit/Evaluation_Engine_Checklist_v0.1.md` — Binding implementation checklist
- `docs/agent/Agent_Implementation_Contract.md` — Agent execution constraints

Lower layers MUST NOT contradict upper layers.

---

### Tutorial

- **Your First Recorded Failure** — A minimal walkthrough that intentionally produces a FAIL to demonstrate what Policy Authority records and what it refuses to interpret.  
  See: `docs/tutorial/FIRST_FAILURE.md`

## v0.1 Starter Pack
- frames/kubernetes/security
- snapshots/kubernetes/security/snapshot_v0.1
- frames/kubernetes/network
- snapshots/kubernetes/network/snapshot_v0.1
- frames/terraform
- snapshots/terraform/snapshot_v0.1

---

### Dependency
PyYAML (see requirements.txt)

---

## Status

Policy Authority v0.1 is **frozen and in maintenance-only mode**.
No semantic changes are permitted; only non-semantic maintenance may be applied.

The principles, scope, and constraints of v0.1 are fixed.

Implementation of the evaluation engine and snapshot builder is in progress.

The following documents are considered **stable and binding**:
- Product Definition v0.1
- Infrastructure Requirements v0.1
- Evaluation Engine Checklist v0.1

This repository publishes v0.1 as a **public reference baseline**, frozen at the tag `v0.1-engine-freeze`.

---

## CI Guard

Policy Authority enforces its constitutional constraints through a single, unified **CI Guard**.

The CI Guard is a mandatory gate executed in CI and is not an optional developer tool.
It acts as the sole constitutional enforcer of this repository.

The CI Guard enforces:

- **Engine Freeze**
  - The semantic meaning of the Engine is frozen.
  - `engine/ENGINE_FREEZE.md` must exist.
  - Frozen engine surfaces (e.g. `engine/verdict.schema.json`) must not change.

- **Frame Integrity**
  - Every frame must contain `FRAME_CONSTITUTION.md`.
  - Frames are immutable after admission (only new frames may be added).

- **Authority Governance**
  - Changes under `authority/` require explicit acknowledgment in commit messages.
  - Sealed Authority files must never change in-place.
  - Sealed hashes are verified to detect silent tampering.

- **Boundary Enforcement**
  - The Engine must not depend on `frames/`, `snapshots/`, or `authority/`.


All constitutional enforcement is centralized in: 

scripts/ci/ci_guard.sh

No other CI guard scripts are authoritative.


---

## License

This project is licensed under the Apache 2.0 License.

---

> **If an implementation conflicts with the Product Definition or Infrastructure Requirements, the implementation is wrong.**
