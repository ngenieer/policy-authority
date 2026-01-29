# Sources
- Purpose: Minimal fixtures to prove PASS/FAIL behavior of kubernetes/network snapshot v0.1 via glob+substring rules.
- Fixtures:
  - pass/ : ClusterIP Service without hostNetwork/hostPort and not LoadBalancer/NodePort (expected PASS)
  - fail/case-001-hostnetwork/ : triggers K8S-NET-BOUNDARY-001 (substring: "hostNetwork: true") (expected FAIL)
  - fail/case-002-loadbalancer/ : triggers K8S-NET-INV-001 (substring: "type: LoadBalancer") (expected FAIL)
  - fail/case-003-ingress-empty-host/ : triggers K8S-NET-INV-002 (substring: "host: \"\"") (expected FAIL)
