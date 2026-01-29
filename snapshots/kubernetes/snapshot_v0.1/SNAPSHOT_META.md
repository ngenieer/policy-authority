# Snapshot Metadata: kubernetes/snapshot_v0.1

> Status: Non-executable placeholder.
> Reason: Kubernetes domain requires different base rules than v0.1 (Terraform) glob+substring model.
> Not part of v0.1 Level 2 execution proof.


## Identity

- snapshot_id: kubernetes/snapshot_v0.1
- domain: kubernetes
- version: v0.1
- issuer: Authority Company (initial infrastructure snapshot)

## Compatibility

- frame: frames/kubernetes/SNAPSHOT_FRAME.md (v0.1)
- engine_min_version: v0.1.0
- evaluation_model: glob + substring (case-sensitive)

## Enforcement

- mode: FAIL_ONLY
- rule_order:
  1) rules/boundaries.yml
  2) rules/invariants.yml

## Scope Note

This snapshot is intentionally minimal and infrastructure-only, aligned with the v0.1 product boundary.

## Regression Fixtures
- Run: `bin/policy-authority verify --snapshot snapshots/kubernetes/snapshot_v0.1 --repo snapshots/kubernetes/snapshot_v0.1/sources/fixtures/pass`  
  Expected: PASS
- Run: `bin/policy-authority verify --snapshot snapshots/kubernetes/snapshot_v0.1 --repo snapshots/kubernetes/snapshot_v0.1/sources/fixtures/fail/case-001-privileged`  
  Expected: FAIL — Rule: K8S-BOUNDARY-001; Files: `**/*.yaml`, `**/*.yml`; Substring: `privileged: true`
- Run: `bin/policy-authority verify --snapshot snapshots/kubernetes/snapshot_v0.1 --repo snapshots/kubernetes/snapshot_v0.1/sources/fixtures/fail/case-002-ingress-public`  
  Expected: FAIL — Rule: K8S-BOUNDARY-002; Files: `**/*.yaml`, `**/*.yml`; Substring: `0.0.0.0/0`
- Run: `bin/policy-authority verify --snapshot snapshots/kubernetes/snapshot_v0.1 --repo snapshots/kubernetes/snapshot_v0.1/sources/fixtures/fail/case-003-imagepull-never`  
  Expected: FAIL — Rule: K8S-INVARIANT-002; Files: `**/*.yaml`, `**/*.yml`; Substring: `imagePullPolicy: Never`
