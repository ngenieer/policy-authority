# Snapshot Frame: Kubernetes (v0.1)

## 1. Purpose

This Snapshot Frame defines what a **Kubernetes Snapshot** means in v0.1.

Kubernetes Snapshot evaluation in v0.1 is intentionally limited to:
- static manifest content
- glob + substring matching only

## 2. In-Scope Artifacts (v0.1)

- YAML manifests: `**/*.yaml`, `**/*.yml`

Optionally, organizations may evaluate:
- rendered manifests (e.g., Helm output) as static YAML files
But v0.1 does not require template rendering.

## 3. Out-of-Scope (v0.1)

Kubernetes Snapshot MUST NOT:
- query the cluster (no kubeconfig usage)
- act as an admission controller
- infer runtime security posture
- run kubectl or any external tools
- do semantic parsing beyond substring matching

## 4. Determinism

- local files only
- deterministic diff-scope optional (no network)

## 5. Evidence

Violations MUST include at minimum:
- `file`
- `pattern`

## 6. Override Boundaries

All overrides MUST comply with:
- `authority/OVERRIDE_BOUNDARIES.md`

