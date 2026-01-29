# Snapshot Metadata: kubernetes/security/snapshot_v0.1

> Status: Scaffold placeholder for security sub-frame.
> Scope: Only security-related Kubernetes manifest content; does not cover other concerns.

## Identity

- snapshot_id: kubernetes/security/snapshot_v0.1
- domain: kubernetes/security
- version: v0.1
- issuer: Authority Company (initial security sub-frame scaffold)

## Compatibility

- frame: frames/kubernetes/security/SNAPSHOT_FRAME.md (v0.1)
- engine_min_version: v0.1.0
- evaluation_model: glob + substring (case-sensitive)

## Purpose

Establishes a minimal, deterministic security-focused snapshot for Kubernetes manifests so the frozen engine can record FAIL-only verdicts tied to security scope without evaluating other concerns.

## Inputs Assumed
- Static Kubernetes manifest files within the repository
- glob + substring evaluation only
- No network access, execution, or runtime state

## Out of Scope
- Network configuration, performance, or availability concerns
- Live cluster interrogation or kubectl execution
- Semantic analysis beyond explicit substring/glob matches

## Enforcement

- mode: FAIL_ONLY
- evaluation_order: defined by `policy_index.yml` (`evaluation.order`)
- short_circuit: true (first violation halts evaluation)
