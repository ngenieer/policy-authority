# Override Boundaries for Snapshot Instantiation

> This document defines **what may and may not be overridden** when instantiating domain-specific Snapshot Frames (e.g., Web, Terraform, Kubernetes).
>
> Purpose: prevent authority dilution while allowing domain-appropriate configuration.

---

## 1. Layered Model

Overrides are evaluated against three layers:

1. **Constitution Layer (Authority Frame)** — absolute, non-overridable
2. **Domain Frame Layer (Snapshot Frame)** — scope/value overrides only
3. **Policy Content Layer (Snapshot Rules)** — content overrides allowed

Any override outside its permitted layer is invalid by definition.

---

## 2. Constitution Layer (Non-Overridable)

The following elements MUST NOT be overridden under any circumstances.
Changing any of these constitutes a different system.

### 2.1 Responsibility Model

- Authority Company does not decide outcomes
- Authority Company does not enforce operational actions
- Responsibility for snapshot content and outcomes rests with the Issuer

### 2.2 Irreversibility

- Past snapshots and verdicts MUST NOT be altered or deleted
- Retroactive modification is forbidden

### 2.3 Transparency and Record

- All official frames and snapshots must be versioned
- Silent changes are forbidden
- Change declarations are mandatory

### 2.4 Non-Coercion

- Users retain version selection rights
- Forced migration is forbidden

### 2.5 Evaluation Engine Constraints (v0.1)

- No external API calls
- No network access
- No semantic inference or intent deduction
- FAIL verdicts MUST NOT be downgraded

### 2.6 Verdict Schema Minimums

- `rule_id`
- `rule_type`
- `file`
- `reason`
- `evidence.pattern`

---

## 3. Domain Frame Layer (Restricted Overrides)

The Domain Frame defines **what is evaluated**, not **how evaluation works**.

### 3.1 Allowed Overrides

The following MAY be overridden:

- Target file types and roots (e.g., `**/*.tf`, `**/*.yaml`)
- Evaluation scope (full scan vs deterministic diff-based scan)
- Evidence verbosity (e.g., include excerpt or not)
- Rule bundle composition (which rule sets are applied)

### 3.2 Forbidden Overrides

The following MUST NOT be overridden:

- Matching model (e.g., substring → AST/semantic/LLM)
- Verdict semantics (FAIL vs WARN vs PASS)
- Rule priority order (e.g., boundaries before invariants)
- Evidence minimum requirements

---

## 4. Policy Content Layer (Content Overrides Allowed)

Policy Content is where Issuers exercise discretion.

### 4.1 Allowed Overrides

Issuers MAY override:

- Rule definitions and counts
- File glob patterns within rules
- Forbidden or required-absent pattern strings
- Domain-specific rule bundles (e.g., `terraform-base`, `k8s-min-safe`)

### 4.2 Recommended Guardrails (Non-Binding)

The following are recommended but not enforced:

- Avoid overly broad file globs (e.g., `**/*`)
- Avoid overly generic patterns that cause excessive false positives
- Document rationale for strict rules

---

## 5. Validation Principle

Overrides are validated by **layer conformity**, not by content correctness.

If an override attempts to change a non-overridable element, it is invalid regardless of intent.

---

## 6. Summary

- **Authority Frame**: no overrides
- **Snapshot Frame**: scope and configuration only
- **Policy Content**: rules are issuer-defined

Authority is preserved by restricting *meaning* changes while allowing *context* changes.

---

## 7. Final Note

This document protects the Authority Company by making authority boundaries explicit.

Any snapshot or frame that violates these boundaries is non-authoritative by definition.

