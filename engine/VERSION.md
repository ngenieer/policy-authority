# Evaluation Engine Version

## Current Version

- Engine: v0.1.0
- Status: initial public execution line

This document is **authoritative** for what the Evaluation Engine v0.1 means and guarantees.

---

## 1. Compatibility Contract (v0.1)

Evaluation Engine v0.1 MUST comply with the following binding documents:

- `docs/agent/Agent_Evaluation_Algorithm_Addendum_v0.1.md`
- `docs/agent/Agent_Implementation_Contract.md`
- `docs/audit/Evaluation_Engine_v0.1_Audit_Checklist.md`

If any behavior conflicts with these documents, the implementation is invalid by definition.

---

## 2. Execution Model (Fixed in v0.1)

Engine v0.1 is strictly:

- **File-based**: evaluates local filesystem content only
- **Deterministic**: no network access, no external APIs
- **Syntactic**: glob matching + plain substring matching only
- **FAIL-only**: violations always result in FAIL; no WARN or downgrade semantics

Semantic understanding, inference, or intent deduction is explicitly out of scope.

---

## 3. Inputs

The engine accepts the following inputs:

- Target repository path (local filesystem)
- Policy Snapshot path (local filesystem)
- Optional: `--diff-base <git-ref>` for deterministic change-scoped evaluation

Diff-based evaluation, if used, MUST:
- rely only on local git data
- produce deterministic results

---

## 4. Outputs

### 4.1 Verdict

- Output file: `verdict.json`
- Location: execution working directory

Each verdict entry MUST include the minimum fields defined by:
- `docs/agent/Agent_Evaluation_Algorithm_Addendum_v0.1.md`

At minimum:
- `rule_id`
- `rule_type`
- `file`
- `reason`
- `evidence.pattern`

### 4.2 Exit Codes

- Exit code `0`: PASS (no violations)
- Non-zero exit code: FAIL (one or more violations)

---

## 5. Schema Reference

Verdict structure is validated against schemas located in:

- `engine/schemas/`

Engine v0.1 MUST NOT emit fields that contradict these schemas.

---

## 6. Domain Independence

The engine is **domain-agnostic**.

It MUST NOT:
- encode domain-specific policy
- infer intent from content
- modify Frames or Snapshots

All domain meaning is supplied exclusively by:
- Snapshot Frames (`frames/*/SNAPSHOT_FRAME.md`)
- Policy Snapshots (`snapshots/**/snapshot_v*/`)

---

## 7. Change Policy

Any change to:

- evaluation semantics
- matching model
- verdict meaning

REQUIRES a new engine version.

Older versions remain valid for reproducing historical evaluations.

---

## 8. Final Declaration

Evaluation Engine v0.1 is intentionally limited.

Its purpose is not to be correct or intelligent, but to be:

- predictable
- reproducible
- auditable

Any behavior outside this declaration is non-authoritative by definition.

