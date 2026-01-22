# Policy Authority – Recommended Execution Plan (v0.1.x)

Status: Operational Guidance  
Audience: AI Agent / Maintainers  
Scope: v0.1.x (Pre–Frame Expansion Phase)

---

## 0. Purpose of This Document

This document defines the **authorized execution order**
for strengthening Policy Authority at version v0.1.x.

This is NOT a roadmap.
This is NOT a feature plan.
This is a **constitutional hardening sequence**.

Agents MUST NOT skip steps, reorder phases,
or introduce additional behavior outside this document.

---

## 1. Guiding Principles (Non-Negotiable)

- Constitutional documents MUST be fixed before enforcement logic
- Reversible changes MUST precede irreversible ones
- Frame existence MUST be formally enforced before Frame expansion
- Convenience, automation, or inference are prohibited

If any instruction conflicts with perceived usefulness,
this document takes precedence.

---

## 2. Phase Overview

The execution plan is divided into four phases:

```
PHASE 0 — Baseline Fixation (already completed)
PHASE 1 — CI Guard Enforcement (mandatory, low risk)
PHASE 2 — Engine Invariant Enforcement (mandatory, medium risk)
PHASE 3 — Snapshot Meta Binding (optional, high risk)
```

Only PHASE 1 is required for the current step.
Later phases MUST NOT be executed prematurely.

---

## 3. PHASE 0 — Baseline Fixation (READ-ONLY)

Status: Completed / Frozen

The following elements are assumed to be fixed
and MUST NOT be modified in v0.1.x:

- Authority constitutional documents
- Snapshot hash computation rules
- FAIL-only evaluation semantics
- Deterministic engine behavior
- Frame concept and terminology

Any modification here constitutes a constitutional revision
and is OUT OF SCOPE.

---

## 4. PHASE 1 — CI Guard Enforcement (EXECUTE NOW)

### 4.1 Objective

Prevent invalid Frames from entering the repository.

This phase MUST:
- Fail fast
- Be reversible
- Avoid engine-level changes

---

### 4.2 Mandatory Rules

#### Rule 1 — Frame Existence Condition

Every directory under `frames/*/` MUST contain:

```
FRAME_CONSTITUTION.md
```

If missing:
- CI MUST FAIL
- No snapshot generation is allowed

---

#### Rule 2 — Authority Document Protection

Any modification under:

```
authority/
authority/frame_admission/
```

MUST be explicitly acknowledged.

If modified without explicit intent:
- CI MUST FAIL

---

### 4.3 Implementation Constraints

- Use shell-based CI guard scripts
- Do NOT modify engine logic
- Do NOT modify snapshot format
- Do NOT auto-generate missing files

---

### 4.4 Suggested Implementation Location

```
scripts/
└── ci/
    └── ci_frame_guard.sh
```

---

### 4.5 Commit Units

Agents MUST split commits as follows:

**Commit A**
```
feat(ci): enforce FRAME_CONSTITUTION presence for all frames
```

**Commit B**
```
chore(ci): protect authority and frame admission documents
```

No other changes are permitted in this phase.

---

## 5. PHASE 2 — Engine Invariant Enforcement (DO NOT EXECUTE YET)

### 5.1 Objective

Enforce Frame validity at engine evaluation time.

This phase MUST NOT be started until PHASE 1
is fully merged and stable.

---

### 5.2 Planned Invariants (For Reference Only)

- `frame_has_constitution`
- `constitution_is_snapshot_input`

These invariants will:
- Fail snapshot generation if constitution is missing
- Bind Frame constitution to snapshot identity

---

### 5.3 Explicit Prohibition

Agents MUST NOT:
- Implement these invariants yet
- Modify invariants.yml in v0.1.x unless explicitly instructed

---

## 6. PHASE 3 — Snapshot Meta Binding (DEFERRED)

### 6.1 Objective

Permanently bind snapshots to:
- Frame constitution
- Authority admission rules

This phase introduces:
- Snapshot identity changes
- Backward incompatibility

---

### 6.2 Status

DEFERRED.

This phase is NOT authorized in v0.1.x
unless explicitly approved by a maintainer.

---

## 7. Prohibited Actions (Global)

Agents MUST NOT:

- Add new Frames
- Modify existing Frame semantics
- Introduce plugin systems
- Add “how-to” documentation
- Add convenience features
- Infer intent or meaning
- Auto-fix or normalize inputs

Violation of these rules invalidates the work.

---

## 8. Completion Criteria for Current Step

This execution plan is considered satisfied when:

- CI fails if a Frame lacks `FRAME_CONSTITUTION.md`
- Authority documents are protected from accidental change
- No engine or snapshot logic is modified

At that point, STOP.

No further action is authorized without new instruction.

---

## 9. Authority Override and Invalid Work Clause

Any work performed by an Agent that violates this document is **constitutionally invalid**.

Invalid work MUST:
- NOT be merged
- NOT be reviewed for quality
- NOT be partially salvaged
- NOT be amended or corrected

Violation nullifies the entire execution attempt.

Intent, usefulness, or perceived improvement are irrelevant.

---

## 10. Agent Acknowledgement Requirement

Before executing any task related to Policy Authority v0.1.x,
Agents MUST explicitly acknowledge:

> "I have read and will strictly follow
> Policy Authority – Recommended Execution Plan (v0.1.x).
> I understand that deviation invalidates my work."

Execution without acknowledgement is unauthorized.

---

## 11. Final Instruction to Agents

Preserve refusal.
Preserve boundaries.
Fail early.
Stop when instructed.

This system gains trust by saying “no”.