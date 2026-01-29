# Snapshot Frame — Kubernetes Network Sub-Frame (v0.1)

## Scope
- Applies only to network-related static Kubernetes manifest content (Services, Ingress, NetworkPolicies, CNI annotations).
- Does not cover security, compute/scheduling, storage, or other sub-frame scopes.

## Evaluation Model
- glob + substring matching only
- file-only inputs; no execution or external calls

## Intent to FAIL
- Fail when network-scoped manifests violate declared boundaries or invariants for this sub-frame.

## Out-of-Scope
- Cluster queries, runtime inspection, semantic analysis, or tool execution.
- Security posture, performance tuning, or non-network concerns.

## Evidence Minimum
Each violation must record `file` and `pattern`.

## Boundary Statement
Only this scope; does not cover others.
