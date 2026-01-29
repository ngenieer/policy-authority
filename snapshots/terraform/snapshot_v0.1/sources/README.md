# Sources
- Purpose: Minimal fixtures to prove PASS/FAIL behavior of terraform snapshot v0.1 via glob+substring rules.
- Fixtures:
  - pass/ : Minimal S3 bucket with no disallowed patterns (expected PASS)
  - fail/case-001-public-ingress/ : triggers no_public_ingress (substring: "0.0.0.0/0") (expected FAIL)
  - fail/case-002-wildcard-iam/ : triggers no_wildcard_iam (substring: "*") (expected FAIL)
  - fail/case-003-encryption-disabled/ : triggers both require_encryption_at_rest and encryption_must_not_be_disabled (substring: "encrypted = false") (expected FAIL)
