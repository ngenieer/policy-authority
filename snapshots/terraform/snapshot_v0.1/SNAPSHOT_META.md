# Snapshot Metadata: terraform/snapshot_v0.1

## Identity

- snapshot_id: terraform/snapshot_v0.1
- domain: terraform
- version: v0.1
- issuer: Authority Company (initial infrastructure snapshot)

## Compatibility

- frame: frames/terraform/SNAPSHOT_FRAME.md (v0.1)
- engine_min_version: v0.1.0
- evaluation_model: glob + substring (case-sensitive)

## Enforcement

- mode: FAIL_ONLY
- evaluation_order: defined by `policy_index.yml` (`evaluation.order`)
- short_circuit: true (first violation halts evaluation)

## Snapshot Hash (Deterministic Identity)

The snapshot hash MUST be computed deterministically as follows:

1) **Included files** (and only these):
   - `policy_index.yml`
   - all files under `rules/` with extension `.yml` (e.g., `rules/boundaries.yml`, `rules/invariants.yml`, `rules/deprecated.yml`)

2) **Path ordering**: sort included file paths lexicographically (byte order).

3) **Content normalization** for each file before hashing:
   - interpret as UTF-8 bytes
   - normalize newlines to LF (`\n`)
   - do not trim whitespace

4) **Concatenation format** (repeat for each sorted path):

```
<relative_path>\n<file_bytes>\n
```

5) Compute `sha256` over the final concatenated byte stream.

Any change to this algorithm requires a version bump.

## Deprecated Rules Semantics

Deprecated rules are retained for **historical and audit continuity only**.

- Deprecated rules MAY overlap with boundaries or invariants.
- When overlap occurs, **evaluation order in `policy_index.yml` determines which rule records the violation evidence**.
- Deprecated rules do not introduce new enforcement semantics beyond FAIL-only behavior.

## Scope Note

This snapshot is intentionally minimal and infrastructure-only, aligned with the v0.1 product boundary.

## Regression Fixtures
- Run: `bin/policy-authority verify --snapshot snapshots/terraform/snapshot_v0.1 --repo snapshots/terraform/snapshot_v0.1/sources/fixtures/pass`  
  Expected: PASS
- Run: `bin/policy-authority verify --snapshot snapshots/terraform/snapshot_v0.1 --repo snapshots/terraform/snapshot_v0.1/sources/fixtures/fail/case-001-public-ingress`  
  Expected: FAIL — Rule: no_public_ingress; Files: `**/*.tf`; Substring: `0.0.0.0/0`
- Run: `bin/policy-authority verify --snapshot snapshots/terraform/snapshot_v0.1 --repo snapshots/terraform/snapshot_v0.1/sources/fixtures/fail/case-002-wildcard-iam`  
  Expected: FAIL — Rule: no_wildcard_iam; Files: `**/*.tf`; Substring: `*`
- Run: `bin/policy-authority verify --snapshot snapshots/terraform/snapshot_v0.1 --repo snapshots/terraform/snapshot_v0.1/sources/fixtures/fail/case-003-encryption-disabled`  
  Expected: FAIL — Rules: require_encryption_at_rest, encryption_must_not_be_disabled (both share the same match); Files: `**/*.tf`; Substring: `encrypted = false`
