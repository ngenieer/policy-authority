# Snapshot Metadata: kubernetes/snapshot_v0.1

> Status: Non-executable placeholder.
> This snapshot is not part of v0.1 Level 2 execution proof.

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
