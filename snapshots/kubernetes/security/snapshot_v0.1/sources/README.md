# Sources — Kubernetes Security snapshot_v0.1

Fixtures:
- fixtures/pass/: Pod without privileged, hostNetwork, hostPath, root, default SA, or disallowed image settings (expected PASS).
- fixtures/fail/case-001-privileged/: Pod with `privileged: true` to trigger K8S-SEC-BOUNDARY-001 (expected FAIL).
- fixtures/fail/case-002-hostnetwork/: Pod with `hostNetwork: true` to trigger K8S-SEC-BOUNDARY-002 (expected FAIL).
- fixtures/fail/case-003-run-as-root/: Pod with `runAsUser: 0` to trigger K8S-SEC-INV-001 (expected FAIL).
