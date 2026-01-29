# Frame Constitution — Agent File Scope Sub-Frame (v0.1)
Version: v0.1
Status: Normative (Sub-Frame-Binding)
Applies-To: agent/file_scope
Last-Updated: 2026-01-29

## Scope
- Covers only agent actions scoped to file path references in repository artifacts.
- Does not cover API surface, runtime behavior, or any other sub-frame scopes.
- Anything outside this scope is constitutionally out of bounds.

## Determinism
Snapshots derive solely from repository files; no execution, network access, clocks, or external state are permitted.

## Execution Refusal
No command execution, simulation, or environment inspection; file-only inspection.

## Non-Interpretation
No semantic intent inference; evaluation is glob + substring only.

## Fail-Only
Outcomes are PASS with zero violations or FAIL with one or more violations; no auto-correction.

## Independence
Self-contained: MUST NOT reference or depend on other sub-frames.

## Self-Invalidation
If any commitment is violated, this sub-frame is invalid and prior evaluations must not be relied upon.
