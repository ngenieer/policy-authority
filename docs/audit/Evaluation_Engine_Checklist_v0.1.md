# Evaluation Engine v0.1 — Agent Checklist

> This document defines the **minimum acceptable implementation checklist** for the Policy Authority evaluation engine (v0.1).
> 
> This checklist is **binding** for any AI Agent or human implementer.

---

## A. Non-Negotiables
- Offline execution only (no network calls during `audit run`)
- Deterministic behavior (same input → identical verdict and ordering)
- No semantic parsing (no Terraform/K8s execution, no AST)
- No "latest" policy resolution (explicit commit SHA only)

---

## B. Inputs & Modes
- Accept target repository path (`--repo <path>`)
- Accept policy snapshot reference (`--policy-cache <path>` or `--policy-lock <file>`)
- Support at least one scan mode:
  - Full scan of repository files (sufficient for v0.1)
  - Diff-based scan is optional

---

## C. Policy Snapshot Loading
- Validate presence of required files:
  - `policy_index.yml`
  - `rules/boundaries.yml`
  - `rules/invariants.yml`
  - `rules/deprecated.yml` (non-enforcing)
- Compute stable policy bundle hash (sha256, sorted inputs)
- Record `policy_repo`, `policy_ref`, `policy_bundle_hash` in verdict

---

## D. Rule Evaluation Order
- Enforce rules in strict order:
  1. `boundaries.yml`
  2. `invariants.yml`
- Ignore `deprecated.yml` for enforcement
- Any violation results in final verdict = FAIL
- No WARN or partial PASS states

---

## E. Matching Model
- File path selection via glob matching (`**` supported)
- File content evaluation via plain substring matching
- Case-sensitive by default
- Binary or unreadable files handled deterministically

---

## F. Minimum Rule Schema Support

### Boundaries Rules
- Required fields:
  - `id`, `title`, `enforcement.mode=fail`
  - `match.files` (glob list)
  - `match.forbidden_patterns` (string list)
- Violation condition:
  - File path matches AND forbidden pattern is found

### Invariants Rules
- Required fields:
  - `id`, `title`, `enforcement.mode=fail`
  - `match.files` (glob list)
  - `match.required_absent` (string list)
- Violation condition:
  - File path matches AND required_absent pattern is found

---

## G. Evidence Requirements
Each violation MUST include:
- `rule_id`
- `rule_type` (boundary | invariant)
- `file`
- `pattern`
- `reason`

Optional but recommended:
- `excerpt` (≤200 chars)
- `offset` (first match index)

---

## H. Verdict Artifact
- Generate `verdict.json` on every run
- Required fields:
  - `verdict` (PASS | FAIL)
  - `policy_repo`
  - `policy_ref`
  - `policy_bundle_hash`
  - `target_repo_commit`
  - `violations[]`
- Ensure deterministic ordering of violations

---

## I. Exit Codes
- `0` → PASS
- `1` → FAIL (policy violation)
- `>1` → execution error

---

## J. Completion Tests
Implementation is acceptable only if:
- Terraform example produces FAIL with evidence
- Kubernetes example produces FAIL with evidence
- Repeated runs produce byte-identical `verdict.json`

---

## K. Forbidden Actions
The evaluator MUST NOT:
- Call external APIs
- Execute terraform or kubectl
- Use AI or heuristic scoring
- Downgrade FAIL to WARN
- Mutate or auto-update policy at runtime

---

> **If a requirement is unclear, do nothing rather than guess.**
> 
> Ambiguity must result in failure, not interpretation.
