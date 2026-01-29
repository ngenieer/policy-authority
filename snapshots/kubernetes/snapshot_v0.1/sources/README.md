# Sources
- Purpose: Minimal fixtures to prove PASS/FAIL behavior of kubernetes snapshot v0.1 via glob+substring rules.
- Fixtures:
  - pass/ : Pod with non-root settings and valid image pull policy (expected PASS)
  - fail/case-001-privileged/ : triggers K8S-BOUNDARY-001 (substring: "privileged: true") (expected FAIL)
  - fail/case-002-ingress-public/ : triggers K8S-BOUNDARY-002 (substring: "0.0.0.0/0") (expected FAIL)
  - fail/case-003-imagepull-never/ : triggers K8S-INVARIANT-002 (substring: "imagePullPolicy: Never") (expected FAIL)
