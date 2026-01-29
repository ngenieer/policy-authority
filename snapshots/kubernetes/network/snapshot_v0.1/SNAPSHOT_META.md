# Snapshot Metadata: kubernetes/network/snapshot_v0.1

> Status: Scaffold placeholder for network sub-frame.
> Scope: Only network-related Kubernetes manifest content; does not cover other concerns.

## Identity

- snapshot_id: kubernetes/network/snapshot_v0.1
- domain: kubernetes/network
- version: v0.1
- issuer: Authority Company (initial network sub-frame scaffold)

## Compatibility

- frame: frames/kubernetes/network/SNAPSHOT_FRAME.md (v0.1)
- engine_min_version: v0.1.0
- evaluation_model: glob + substring (case-sensitive)

## Purpose

Establishes a minimal, deterministic network-focused snapshot for Kubernetes manifests so the frozen engine can record FAIL-only verdicts tied to network scope without evaluating other concerns.

## Inputs Assumed
- Static Kubernetes manifest files within the repository
- glob + substring evaluation only
- No network access, execution, or runtime state

## Out of Scope
- Security posture, compute/scheduling, or storage concerns
- Live cluster interrogation or kubectl execution
- Semantic analysis beyond explicit substring/glob matches

## Enforcement

- mode: FAIL_ONLY
- evaluation_order: defined by `policy_index.yml` (`evaluation.order`)
- short_circuit: true (first violation halts evaluation)

## Regression Fixtures
- Run: `bin/policy-authority verify --snapshot snapshots/kubernetes/network/snapshot_v0.1 --repo snapshots/kubernetes/network/snapshot_v0.1/sources/fixtures/pass`  
  Expected: PASS
- Run: `bin/policy-authority verify --snapshot snapshots/kubernetes/network/snapshot_v0.1 --repo snapshots/kubernetes/network/snapshot_v0.1/sources/fixtures/fail/case-001-hostnetwork`  
  Expected: FAIL — Rule: K8S-NET-BOUNDARY-001; Files: `**/*.yaml`, `**/*.yml`; Substring: `hostNetwork: true`
- Run: `bin/policy-authority verify --snapshot snapshots/kubernetes/network/snapshot_v0.1 --repo snapshots/kubernetes/network/snapshot_v0.1/sources/fixtures/fail/case-002-loadbalancer`  
  Expected: FAIL — Rule: K8S-NET-INV-001; Files: `**/*service*.yaml`, `**/*service*.yml`; Substrings: `type: LoadBalancer`
- Run: `bin/policy-authority verify --snapshot snapshots/kubernetes/network/snapshot_v0.1 --repo snapshots/kubernetes/network/snapshot_v0.1/sources/fixtures/fail/case-003-ingress-empty-host`  
  Expected: FAIL — Rule: K8S-NET-INV-002; Files: `**/*ingress*.yaml`, `**/*ingress*.yml`; Substring: `host: ""`
