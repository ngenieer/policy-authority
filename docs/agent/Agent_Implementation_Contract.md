# Agent Implementation Contract (v0.1)

> Status: Completed.
> This document is binding for v0.1 Level 2 Terraform proof only.

## 1. Purpose

This contract defines the **strict implementation boundaries** for an Agent participating in **Policy Authority v0.1**.
The Agent acts solely as an implementer and **MUST NOT introduce new semantics, abstractions, or future-facing features**.

## 2. Authority Hierarchy (v0.1)

The Agent MUST follow the authority order below. Higher layers override lower layers.

1. `frames/terraform/SNAPSHOT_FRAME.md`
2. `snapshots/*/SNAPSHOT_META.md`
3. `snapshots/*/policy_index.yml`
4. This contract
5. `Agent_Evaluation_Algorithm_Addendum_v0.1.md`

Any conflict MUST be resolved in favor of the higher-ranked document.

## 3. Scope of Work

The Agent MAY:
- Implement deterministic evaluation logic for **static Terraform files**
- Read snapshot rules and evaluation order from snapshot documents
- Produce PASS/FAIL verdicts with deterministic evidence

The Agent MUST NOT:
- Perform semantic parsing (AST, resource graphs, execution)
- Introduce remote access, sync, fetch, or verification steps
- Add CI/CD integration or background services
- Infer meaning beyond explicit substring matching

## 4. Execution Model

- Execution is **offline only**
- Evaluation is **deterministic**
- Evaluation input is limited to:
  - snapshot directory
  - target repository directory

No implicit discovery, defaults, or environment-based behavior is allowed.

## 5. CLI Contract (v0.1)

Only the following command is valid in v0.1:

```text
policy-authority eval --snapshot <path> --target <path> [--out <path>]
```

Any other subcommands or flags are **out of scope**.

## 6. Verdict Contract

- Output MUST be a single `verdict.json`
- Verdict MUST be either `PASS` or `FAIL`
- Verdict MUST include:
  - snapshot_id
  - snapshot_hash (as defined in SNAPSHOT_META.md)
  - target_ref (path)
  - violations[] (empty if PASS)

## 7. Determinism Requirements

- File traversal MUST be sorted
- Rule evaluation order MUST follow `policy_index.yml`
- Snapshot hash MUST follow the algorithm defined in `SNAPSHOT_META.md`

If any required input is missing or ambiguous, the Agent MUST FAIL explicitly.

## 8. Completion Criteria

Implementation is considered complete when:
- PASS and FAIL examples both execute successfully
- Repeated execution produces byte-identical verdicts
- No behavior exceeds the scope defined above

