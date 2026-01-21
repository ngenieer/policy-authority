# Agent Evaluation Algorithm Addendum (v0.1)

> Status: Completed.
> This document specifies the exact evaluation algorithm used for the v0.1 Level 2 Terraform proof.

## 1. Evaluation Inputs

The Agent receives:
- `--snapshot <path>`: a snapshot directory
- `--target <path>`: a target Terraform repository

No other inputs are permitted.

## 2. Rule Structure (v0.1)

Rules are defined using the following structure only:

```yaml
boundaries:
  - id: <string>
    description: <string>
    match:
      files: [glob]
      contains: [substring]

invariants:
  - id: <string>
    description: <string>
    match:
      files: [glob]
      contains: [substring]
```

`deprecated` rules follow the same structure and semantics.

No other rule schema is valid in v0.1.

## 3. Matching Semantics

- Files are selected using glob patterns
- Matching is **substring-based only** (case-sensitive)
- No semantic interpretation is performed

## 4. Evaluation Order

Evaluation order is defined exclusively by:

```yaml
evaluation:
  order: [...]
```

in `policy_index.yml`.

The Agent MUST NOT hardcode rule ordering.

## 5. Enforcement Rules

- All rules are FAIL-only
- Evaluation MUST short-circuit on the first violation
- Deprecated rules MAY overlap with other rules

## 6. Algorithm Steps

1. Load `policy_index.yml`
2. Read evaluation order from `evaluation.order`
3. For each rule group in order:
   - Load rule file
   - Evaluate rules sequentially
   - Stop on first match
4. Produce verdict

## 7. Completion Test (v0.1)

Completion is satisfied when:
- Terraform PASS example yields PASS
- Terraform FAIL example yields FAIL
- `repro_check.sh` confirms byte-identical verdicts

Kubernetes is explicitly **out of scope** for v0.1.

