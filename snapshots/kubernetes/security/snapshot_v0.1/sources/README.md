# Sources
- Purpose: Minimal fixtures to prove PASS/FAIL behavior of kubernetes/security snapshot v0.1 via glob+substring rules.
- Fixtures:
  - pass/ : Pod without privileged, hostNetwork, hostPath, root, default SA, or disallowed image settings (expected PASS)
  - fail/case-001-privileged/ : triggers K8S-SEC-BOUNDARY-001 (substring: "privileged: true") (expected FAIL)
  - fail/case-002-hostnetwork/ : triggers K8S-SEC-BOUNDARY-002 (substring: "hostNetwork: true") (expected FAIL)
  - fail/case-003-run-as-root/ : triggers K8S-SEC-INV-001 (substring: "runAsUser: 0") (expected FAIL)
