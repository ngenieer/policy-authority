# Sources — Terraform snapshot_v0.1

Fixtures:
- fixtures/pass/: Minimal S3 bucket with no disallowed patterns (expected PASS).
- fixtures/fail/case-001-public-ingress/: Security group rule with `0.0.0.0/0` to trigger no_public_ingress (expected FAIL).
- fixtures/fail/case-002-wildcard-iam/: IAM policy containing `*` action/resource to trigger no_wildcard_iam (expected FAIL).
- fixtures/fail/case-003-encryption-disabled/: EBS volume with `encrypted = false` to trigger require_encryption_at_rest and encryption_must_not_be_disabled (expected FAIL).
