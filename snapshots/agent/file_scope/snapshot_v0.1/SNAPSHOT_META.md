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

## Enforcement
- mode: FAIL_ONLY
- evaluation_order: defined by `policy_index.yml` (`evaluation.order`)
- short_circuit: true (first violation halts evaluation)
