# Snapshot Metadata: agent/file_scope/snapshot_v0.1

> Status: Minimal scaffold for agent file-scope enforcement.
> Scope: Only file path references related to agent changes.

## Identity
- snapshot_id: agent/file_scope/snapshot_v0.1
- domain: agent/file_scope
- version: v0.1
- issuer: Authority Company (agent file-scope scaffold)

## Compatibility
- frame: frames/agent/file_scope/SNAPSHOT_FRAME.md (v0.1)
- engine_min_version: v0.1.0
- evaluation_model: glob + substring (case-sensitive)

## Purpose
Provides FAIL-only detection when agent artifacts indicate modifications outside permitted file scopes.

## Inputs Assumed
- Repository artifacts containing file path references
- glob + substring evaluation only
- No network access, execution, or runtime state

## Out of Scope
- Public API surface markers
- Runtime or environment effects
- Semantic interpretation beyond substring/glob matches

## Regression Fixtures
- Run: `bin/policy-authority verify --snapshot snapshots/agent/file_scope/snapshot_v0.1 --repo snapshots/agent/file_scope/snapshot_v0.1/sources/fixtures/pass`  
  Expected: PASS
- Run: `bin/policy-authority verify --snapshot snapshots/agent/file_scope/snapshot_v0.1 --repo snapshots/agent/file_scope/snapshot_v0.1/sources/fixtures/fail/case-001-boundary-001`  
  Expected: FAIL (AGENT-FILE-BOUNDARY-001)
- Run: `bin/policy-authority verify --snapshot snapshots/agent/file_scope/snapshot_v0.1 --repo snapshots/agent/file_scope/snapshot_v0.1/sources/fixtures/fail/case-002-boundary-002`  
  Expected: FAIL (AGENT-FILE-BOUNDARY-002)
- Run: `bin/policy-authority verify --snapshot snapshots/agent/file_scope/snapshot_v0.1 --repo snapshots/agent/file_scope/snapshot_v0.1/sources/fixtures/fail/case-003-invariant-001`  
  Expected: FAIL (AGENT-FILE-INV-001)

Note: FAIL fixtures embed explicit marker strings (e.g., `OUT_OF_SCOPE_PATH: authority/`) solely to trigger substring-based rules; they symbolize out-of-scope paths and do not assert meaning about actual repository directories.

## Enforcement
- mode: FAIL_ONLY
- evaluation_order: defined by `policy_index.yml` (`evaluation.order`)
- short_circuit: true (first violation halts evaluation)
