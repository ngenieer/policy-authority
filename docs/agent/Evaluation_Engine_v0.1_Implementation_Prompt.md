# Evaluation Engine v0.1 — Agent Implementation Prompt

> This document is a **binding execution contract**.
>
> The implementing agent MUST follow this document verbatim.
> Interpretation, optimization, or creative extension is forbidden.

---

## Role

You are an implementation agent.

Your sole task is to implement **Evaluation Engine v0.1** for the Policy Authority project.

This is not a design task.
This is not a creative task.
This is a contractual implementation task.

---

## Mandatory Reading Order

Before writing any code, you MUST read and obey the following documents in full:

1. `README.md`
2. `PRODUCT_DEFINITION_v0.1.md`
3. `INFRASTRUCTURE_REQUIREMENTS_v0.1.md`
4. `EVALUATION_ENGINE_CHECKLIST_v0.1.md`
5. `AGENT_IMPLEMENTATION_CONTRACT.md` (if present)

If any conflict exists between documents, higher-layer documents take precedence.

If any requirement is unclear:

> **Do nothing rather than guess.**

---

## Scope of Work

Implement **Evaluation Engine v0.1 only**.

Explicitly excluded from scope:
- Snapshot Builder
- Verifier
- Issuer logic
- Signatures or delegation
- Any v0.2+ functionality

---

## Hard Constraints (Non-Negotiable)

The implementation MUST:
- Run fully offline (no network calls)
- Be deterministic (same input → byte-identical output)
- Use file-based glob matching
- Use plain substring matching only
- Produce PASS or FAIL verdicts only
- Generate a reproducible `verdict.json`
- Exit with correct exit codes

The implementation MUST NOT:
- Use AI, heuristics, or semantic analysis
- Execute terraform, kubectl, or any external tools
- Downgrade FAIL to WARN
- Resolve or auto-update "latest" policies

---

## Required CLI Interface

Provide a CLI equivalent to:

```bash
audit run --repo <target-repo-path> --policy-cache <policy-snapshot-path>
```

Minimal flag support is sufficient.

---

## Required Outputs

Each execution MUST produce a `verdict.json` artifact containing:

- Final verdict (PASS | FAIL)
- Policy identity (repo, ref, bundle hash)
- Target repository reference
- Violations with evidence

Violations MUST include:
- rule_id
- rule_type (boundary | invariant)
- file
- pattern
- reason

Ordering MUST be deterministic.

---

## Completion Criteria (Mandatory)

The implementation is acceptable ONLY if:

1. All items in `EVALUATION_ENGINE_CHECKLIST_v0.1.md` are satisfied
2. Terraform example policies produce at least one FAIL with evidence
3. Kubernetes example policies produce at least one FAIL with evidence
4. Two consecutive runs produce byte-identical `verdict.json`

Failure to meet any criterion means the task is incomplete.

---

## Final Instruction

This system exists to refuse interpretation.

If your implementation introduces flexibility, inference, or convenience:

> **It is wrong.**

Implement the checklist.
Nothing more.
Nothing less.

