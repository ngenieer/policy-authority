# Frame Constitution — Agent API Surface Sub-Frame (v0.1)
Version: v0.1
Status: Normative (Sub-Frame-Binding)
Applies-To: agent/api_surface
Last-Updated: 2026-01-29

## Scope
- Covers only agent-introduced public API surface markers in code artifacts.
- Does not cover file scope, internal-only changes, runtime behavior, or other sub-frame scopes.
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
