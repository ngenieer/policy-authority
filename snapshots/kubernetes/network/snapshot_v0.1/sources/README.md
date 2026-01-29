# Sources — Kubernetes Network snapshot_v0.1

Fixtures:
- fixtures/pass/: ClusterIP Service with no hostNetwork/hostPort and no LoadBalancer/NodePort (expected PASS).
- fixtures/fail/case-001-hostnetwork/: Pod with `hostNetwork: true` to trigger K8S-NET-BOUNDARY-001 (expected FAIL).
- fixtures/fail/case-002-loadbalancer/: Service with `type: LoadBalancer` to trigger K8S-NET-INV-001 (expected FAIL).
- fixtures/fail/case-003-ingress-empty-host/: Ingress rule with empty host to trigger K8S-NET-INV-002 (expected FAIL).
