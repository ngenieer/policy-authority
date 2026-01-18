# Agent Implementation Contract v0.1

> This document defines **non-negotiable implementation instructions** for any AI Agent tasked with building the AI Decision Audit & Enforcement System.
>
> This is not guidance. This is a contract.

---

## 0. Authority of This Document

This contract is **subordinate only to**:
- Product_Definition_v0.1 (EN/KR)
- Infrastructure_Requirements_v0.1 (EN/KR)

If any ambiguity exists, **this contract SHALL be interpreted conservatively** in favor of:
- determinism
- auditability
- immutability

---

## 1. Role of the AI Agent

The AI Agent SHALL act as:
- an **implementer**, not a designer
- an **executor of fixed decisions**, not a decision-maker

The Agent SHALL NOT:
- reinterpret product intent
- expand scope
- introduce convenience features

---

## 2. Implementation Scope (v0.1)

The Agent SHALL implement **only**:

- Standalone CLI program
- Infrastructure-only auditing
- Git-based Policy Snapshot loading
- Deterministic PASS / FAIL enforcement
- Verdict artifact generation

Any feature outside this list is **explicitly forbidden**.

---

## 3. Mandatory Architectural Constraints

### 3.1 Offline Determinism

- All enforcement decisions MUST be executable offline
- Network access during `audit run` is forbidden
- Policy Snapshots MUST be pre-fetched or locally available

---

### 3.2 Policy Snapshot Immutability

- Policy Snapshots SHALL be treated as read-only
- No runtime modification is permitted
- Policy identity SHALL be bound to:
  - policy repository URL
  - commit SHA
  - computed bundle hash

---

### 3.3 No "Latest" Semantics

- The Agent SHALL NOT implement:
  - "latest" policy resolution
  - implicit policy upgrades

All policy usage MUST reference an explicit commit SHA.

---

## 4. CLI Contract

### 4.1 Required Commands

The CLI MUST implement:

- `audit sync`
  - Fetch policy repository
  - Checkout exact commit SHA
  - Cache snapshot locally

- `audit run`
  - Execute audit using cached snapshot
  - Produce verdict artifact

Optional:
- `audit verify`
  - Verify policy snapshot signature (if present)

---

### 4.2 CLI Exit Codes

- `0` → PASS
- `1` → FAIL (policy violation)
- `>1` → Execution error

Exit codes MUST be stable.

---

## 5. Enforcement Semantics

### 5.1 PASS / FAIL Rules

- PASS is permitted **only if no enforced rule is violated**
- Any enforced rule violation MUST result in FAIL

Partial PASS or warnings SHALL NOT exist in v0.1.

---

### 5.2 Evidence Binding

Every FAIL MUST include:
- rule identifier
- file or resource identifier
- reason
- evidence reference

Human-readable explanations are optional.

---

## 6. Verdict Artifact Contract

A verdict artifact MUST be produced on every execution.

Minimum required fields:

- verdict
- policy_repo
- policy_ref
- policy_bundle_hash
- target_repo_commit
- violations[]

Artifacts SHALL be written to disk.

---

## 7. Forbidden Behaviors (Critical)

The Agent MUST NOT:

- auto-fix or remediate changes
- suggest improvements
- request human approval
- persist state outside designated output directories
- introduce UI, dashboards, or services

---

## 8. Implementation Philosophy

The correct implementation is:
- boring
- explicit
- repeatable

If a feature feels "helpful", it is probably **out of scope**.

---

## 9. Completion Criteria

Implementation is considered complete only if:

- Given identical inputs, identical outputs are produced
- Verdicts can be reproduced months later using stored artifacts
- No hidden state or implicit behavior exists

---

## 10. Final Clause

If a design decision is unclear:

> **Do nothing rather than guess.**

Ambiguity SHALL result in a failed build, not creative interpretation.

