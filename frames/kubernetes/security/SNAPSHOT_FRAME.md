# Snapshot Frame — Kubernetes Security Sub-Frame (v0.1)

## Scope
- Applies only to security-related static Kubernetes manifest content (RBAC, Pod security settings, secrets usage hints).
- Does not cover network, performance, or other sub-frame scopes.

## Evaluation Model
- glob + substring matching only
- file-only inputs; no execution or external calls

## Intent to FAIL
- Fail when security-scoped manifests violate declared boundaries or invariants for this sub-frame.

## Out-of-Scope
- Cluster queries, runtime inspection, semantic analysis, or tool execution.
- Network configuration, availability/performance objectives, or non-security concerns.

## Evidence Minimum
Each violation must record `file` and `pattern`.

## Boundary Statement
Only this scope; does not cover others.
