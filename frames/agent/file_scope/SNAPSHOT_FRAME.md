# Snapshot Frame — Agent File Scope Sub-Frame (v0.1)

## Intent to FAIL
- Fail when artifacts reference or include paths outside allowed agent file scope.

## Not Covered
- Public API surface markers
- Runtime behavior or execution effects
- Any scope outside file path references

## Evaluation Model
- glob + substring matching only
- file-only inputs; no execution or external calls

## Evidence Minimum
Each violation must record `file` and `pattern`.
