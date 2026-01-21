# Repository Structure (Canonical, As‑Is)

> This document defines the **authoritative repository structure as it currently exists**.
> It is both **descriptive** (what is present) and **normative** (what each location means).
>
> Any future change to this structure MUST be intentional and documented,
> as structure itself is part of the authority and governance model.

---

## 1. Purpose of the Structure

This repository layout is a **governance mechanism**, not an organizational preference.

It exists to:

- Physically separate authority, policy, and execution
- Prevent accidental override of non‑overridable elements
- Make Agent and Issuer responsibilities unambiguous
- Allow domain expansion without authority fragmentation

If files drift across these boundaries, authority semantics are considered broken.

---

## 2. Top‑Level Layout (Current State)

```
/
├── authority/
├── docs/
├── engine/
├── examples/
├── frames/
├── snapshots/
├── CONTRIBUTING.md
├── FAQ.md
├── Infrastructure_Requirements_v0.1.md
├── Product_Definition_v0.1.md
└── README.md
```

Top‑level files are **entry‑point documents only**.
They MUST NOT contain executable logic or mutable authority rules.

---

## 3. `/authority/` — Constitution Layer (Non‑Overridable)

```
authority/
├── AUTHORITY_LIMITS.md
└── OVERRIDE_BOUNDARIES.md
```

**Role**

- Defines what authority *is* and *is not*
- Binds the Authority Company via self‑imposed limits
- Defines override permissions across all layers

**Rules**

- No domain‑specific logic
- No policy rules
- Treated as immutable by Agents and Issuers
- Any change requires explicit declaration and versioning

---

## 4. `/docs/` — Contractual and Explanatory Layer

Human‑readable documents that bind, explain, or audit the system.
No executable behavior is allowed in this directory.

```
docs/
├── agent/
│   ├── Agent_Evaluation_Algorithm_Addendum_v0.1.md
│   ├── Agent_Implementation_Contract.md
│   └── Evaluation_Engine_v0.1_Implementation_Prompt.md
│
├── audit/
│   ├── Evaluation_Engine_Checklist_v0.1.md
│   └── Evaluation_Engine_v0.1_Audit_Checklist.md
│
├── governance/
│   ├── DECLARATION.md
│   ├── GOVERNANCE.md
│   └── REPOSITORY_STRUCTURE.md
│
├── guides/
├── legal/
└── product/
```

### 4.1 `docs/agent/`

Binds **implementers and AI agents**.

- Defines minimum evaluation algorithms
- Defines what Agents MUST and MUST NOT do
- Serves as the execution contract for automated implementation

### 4.2 `docs/audit/`

Defines **verification and acceptance criteria**.

- Audit checklists
- Deterministic pass/fail expectations
- Used to validate Evaluation Engine implementations

### 4.3 `docs/governance/`

Explains and records **authority and governance semantics**.

- DECLARATION.md: intent and positioning
- GOVERNANCE.md: operational governance rules
- REPOSITORY_STRUCTURE.md: this document

---

## 5. `/engine/` — Evaluation Engine (Execution Layer)

```
engine/
├── cli/
├── core/
├── schemas/
├── validators/
└── VERSION.md
```

**Role**

- Implements the evaluation algorithm
- Enforces authority and frame constraints
- Produces deterministic verdicts

**Rules**

- Domain‑agnostic
- Must not encode policy intent
- Must not modify frames or snapshots

---

## 6. `/frames/` — Domain Snapshot Frames

Defines **what constitutes a Snapshot in each domain**.

```
frames/
├── terraform/
│   └── SNAPSHOT_FRAME.md
└── kubernetes/
    └── SNAPSHOT_FRAME.md
```

**Role**

- Declares snapshot scope and boundaries per domain
- Fixes what is included and excluded from evaluation
- Does NOT define policy content

Snapshot Frames MAY evolve per domain,
but MUST NOT alter authority semantics.

---

## 7. `/snapshots/` — Policy Content Layer (Issuer‑Defined)

Contains **actual policy snapshots** issued under a Snapshot Frame.

```
snapshots/
├── terraform/
│   └── snapshot_v0.1/
│       ├── policy_index.yml
│       ├── rules/
│       │   ├── boundaries.yml
│       │   ├── invariants.yml
│       │   └── deprecated.yml
│       ├── sources/
│       └── SNAPSHOT_META.md
└── kubernetes/
    └── snapshot_v0.1/
        ├── policy_index.yml
        ├── rules/
        │   ├── boundaries.yml
        │   ├── invariants.yml
        │   └── deprecated.yml
        ├── sources/
        └── SNAPSHOT_META.md
```

**Rules**

- Snapshots are immutable once issued
- New versions require new directories
- Policy content is Issuer‑defined but schema‑bound
- Past snapshots MUST remain accessible

---

## 8. `/examples/` — Non‑Authoritative Samples

```
examples/
├── sample-snapshots/
├── sample-verdicts/
└── target-repos/
```

Examples are:

- Illustrative only
- Safe for experimentation
- NEVER treated as authoritative

---

## 9. Authority Enforcement by Structure

Authority is preserved by **physical separation**:

- Authority cannot be modified by Engine code
- Snapshots cannot redefine Frames
- Frames cannot redefine Authority

Any artifact placed outside its designated layer is
**non‑authoritative by definition**.

---

## 10. Summary Table

| Layer | Directory | Override Policy |
|------|----------|-----------------|
| Constitution | `/authority` | Not allowed |
| Governance | `/docs/governance` | Descriptive only |
| Agent Contract | `/docs/agent` | Binding for Agents |
| Audit | `/docs/audit` | Verification only |
| Domain Frame | `/frames` | Scope‑only |
| Policy Content | `/snapshots` | Issuer‑defined |
| Execution | `/engine` | No policy |

---

## 11. Final Note

This repository structure is part of the system's authority model.

Changing structure without explicit declaration
is equivalent to changing authority semantics.
