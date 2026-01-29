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

## Regression Fixtures
- Run: `bin/policy-authority verify --snapshot snapshots/kubernetes/security/snapshot_v0.1 --repo snapshots/kubernetes/security/snapshot_v0.1/sources/fixtures/pass`  
  Expected: PASS
- Run: `bin/policy-authority verify --snapshot snapshots/kubernetes/security/snapshot_v0.1 --repo snapshots/kubernetes/security/snapshot_v0.1/sources/fixtures/fail/case-001-privileged`  
  Expected: FAIL — Rule: K8S-SEC-BOUNDARY-001; Files: `**/*.yaml`, `**/*.yml`; Substring: `privileged: true`
- Run: `bin/policy-authority verify --snapshot snapshots/kubernetes/security/snapshot_v0.1 --repo snapshots/kubernetes/security/snapshot_v0.1/sources/fixtures/fail/case-002-hostnetwork`  
  Expected: FAIL — Rule: K8S-SEC-BOUNDARY-002; Files: `**/*.yaml`, `**/*.yml`; Substring: `hostNetwork: true`
- Run: `bin/policy-authority verify --snapshot snapshots/kubernetes/security/snapshot_v0.1 --repo snapshots/kubernetes/security/snapshot_v0.1/sources/fixtures/fail/case-003-run-as-root`  
  Expected: FAIL — Rule: K8S-SEC-INV-001; Files: `**/*.yaml`, `**/*.yml`; Substring: `runAsUser: 0`
