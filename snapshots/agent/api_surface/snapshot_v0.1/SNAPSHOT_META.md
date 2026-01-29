# Snapshot Metadata: agent/api_surface/snapshot_v0.1

> Status: Minimal scaffold for agent API surface enforcement.
> Scope: Only public API exposure markers introduced by agents.

## Identity
- snapshot_id: agent/api_surface/snapshot_v0.1
- domain: agent/api_surface
- version: v0.1
- issuer: Authority Company (agent API-surface scaffold)

## Compatibility
- frame: frames/agent/api_surface/SNAPSHOT_FRAME.md (v0.1)
- engine_min_version: v0.1.0
- evaluation_model: glob + substring (case-sensitive)

## Purpose
Provides FAIL-only detection when agent artifacts introduce public-facing API surface markers.

## Inputs Assumed
- Repository code files within API-related paths
- glob + substring evaluation only
- No network access, execution, or runtime state

## Out of Scope
- File scope or path boundary checks
- Runtime or environment effects
- Semantic interpretation beyond substring/glob matches

## Enforcement
- mode: FAIL_ONLY
- evaluation_order: defined by `policy_index.yml` (`evaluation.order`)
- short_circuit: true (first violation halts evaluation)
