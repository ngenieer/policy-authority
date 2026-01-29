# Snapshot Frame — Agent API Surface Sub-Frame (v0.1)

## Intent to FAIL
- Fail when artifacts introduce or expose new public API surface markers.

## Not Covered
- File scope or path boundaries
- Runtime behavior or execution effects
- Internal-only code without public exposure markers

## Evaluation Model
- glob + substring matching only
- file-only inputs; no execution or external calls

## Evidence Minimum
Each violation must record `file` and `pattern`.
