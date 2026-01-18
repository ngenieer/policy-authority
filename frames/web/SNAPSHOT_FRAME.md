# Snapshot Frame: Web (v0.1)

## 1. Purpose

This Snapshot Frame defines what a **Web Snapshot** means in v0.1.

It constrains:
- what files are considered in-scope
- what is explicitly out-of-scope
- what this domain snapshot DOES NOT attempt to judge

This frame does **not** define policy content; it only defines the boundary of evaluation.

## 2. In-Scope Artifacts (v0.1)

A Web Snapshot MAY target repositories that include:

- application source: `**/*.js`, `**/*.ts`, `**/*.tsx`, `**/*.py`, `**/*.php`, `**/*.rb`, `**/*.go`, `**/*.java`, `**/*.kt`
- configuration: `**/*.yml`, `**/*.yaml`, `**/*.json`, `**/*.toml`, `**/*.ini`, `**/*.env*` (policy may forbid)
- CI/CD: `.github/workflows/**/*.yml`, `.gitlab-ci.yml`, `Jenkinsfile`
- container: `Dockerfile`, `**/Dockerfile`, `docker-compose.yml`

Evaluation is always **file-based**:
- glob match for paths
- substring match for patterns (case-sensitive by default)

## 3. Out-of-Scope (v0.1)

The Web Snapshot MUST NOT attempt:

- semantic code understanding
- vulnerability scanning
- dependency resolution
- runtime environment inspection
- network calls or API queries

## 4. Determinism

Evaluation MUST be deterministic:
- local filesystem only
- optional diff-scope is allowed if it does not rely on network

## 5. Output and Evidence

Any violation MUST produce evidence containing at least:
- `file`
- `pattern`

## 6. Override Boundaries

Instantiation MUST respect:
- `authority/OVERRIDE_BOUNDARIES.md`
Non-overridable authority semantics apply unchanged.

