# Evaluation Engine v0.1 — Audit Checklist

This document certifies whether an Evaluation Engine implementation complies with Policy Authority v0.1.

Each checklist item is **self-contained**. There are no implicit meanings outside each bullet.

---

## A. Structural Compliance
- [ ] The engine exists as a standalone CLI binary or script that can be executed directly without wrappers.
- [ ] The engine executes successfully in an air-gapped environment with all network access disabled.
- [ ] The engine does not invoke external tools such as terraform, kubectl, helm, or similar subprocesses.

---

## B. Determinism
- [ ] Two executions with identical inputs produce byte-identical `verdict.json` files.
- [ ] The ordering of violations inside `verdict.json` is stable across repeated runs.
- [ ] The computed policy bundle hash value is identical across repeated runs with the same inputs.

---

## C. Policy Handling
- [ ] A policy snapshot must be explicitly provided; execution fails if it is omitted.
- [ ] There is no fallback to a "latest", default, or implicit policy resolution mechanism.
- [ ] The fields `policy_repo`, `policy_ref`, and `policy_bundle_hash` are present in `verdict.json`.
- [ ] The file `rules/deprecated.yml` is loaded but never enforced.

---

## D. Rule Evaluation Semantics
- [ ] Boundary rules are evaluated before invariant rules.
- [ ] Target files are selected using glob matching only (`**` supported).
- [ ] Pattern detection uses plain substring search and is case-sensitive.
- [ ] No semantic parsing, AST analysis, or contextual inference is performed.

---

## E. Verdict Semantics
- [ ] Verdict values are strictly `PASS` or `FAIL` with no additional states.
- [ ] Any single rule violation results in a `FAIL` verdict.
- [ ] No WARN, INFO, advisory, or partial-success outcomes exist.

---

## F. Evidence Integrity
- [ ] Each violation includes a `rule_id` field.
- [ ] Each violation includes a `rule_type` field (`boundary` or `invariant`).
- [ ] Each violation records the offending file path.
- [ ] Each violation records the matched pattern string.
- [ ] Each violation includes a human-readable reason for failure.

---

## G. Exit Codes
- [ ] Exit code `0` is returned when the verdict is PASS.
- [ ] Exit code `1` is returned when the verdict is FAIL due to policy violation.
- [ ] Exit code greater than `1` is returned for execution errors.

---

## H. Forbidden Capabilities
- [ ] The engine performs no external API or network calls during execution.
- [ ] The engine contains no AI, ML, or heuristic scoring logic.
- [ ] The engine performs no automatic remediation or fix suggestions.
- [ ] The engine does not mutate or auto-update policy at runtime.

---

## I. Conformance Verdict
- [ ] FULLY COMPLIANT with Evaluation Engine v0.1.
- [ ] NON-COMPLIANT (violations listed below).

Auditor notes:

```

```

