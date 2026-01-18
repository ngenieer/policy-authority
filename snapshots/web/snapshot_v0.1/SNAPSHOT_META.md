# Snapshot Metadata: web/snapshot_v0.1

## Identity

- snapshot_id: web/snapshot_v0.1
- domain: web
- version: v0.1
- issuer: Authority Company (internal initial snapshot)

## Compatibility

- frame: frames/web/SNAPSHOT_FRAME.md (v0.1)
- engine_min_version: v0.1.0
- evaluation_model: glob + substring (case-sensitive)

## Enforcement

- mode: FAIL_ONLY
- rule_order:
  1) rules/boundaries.yml
  2) rules/invariants.yml

## Scope Note

This snapshot is intentionally minimal and conservative.
It is designed to demonstrate deterministic enforcement, not completeness.

