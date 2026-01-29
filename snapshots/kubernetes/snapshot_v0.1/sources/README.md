# Sources — Kubernetes snapshot_v0.1

Fixtures:
- fixtures/pass/: Pod with non-root settings and valid image pull policy (expected PASS).
- fixtures/fail/case-001-privileged/: Pod with `privileged: true` to trigger K8S-BOUNDARY-001 (expected FAIL).
- fixtures/fail/case-002-ingress-public/: Ingress including `0.0.0.0/0` to trigger K8S-BOUNDARY-002 (expected FAIL).
- fixtures/fail/case-003-imagepull-never/: Pod with `imagePullPolicy: Never` to trigger K8S-INVARIANT-002 (expected FAIL).
