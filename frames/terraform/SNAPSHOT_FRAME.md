# Snapshot Frame: Terraform (v0.1)

## 1. Purpose

This Snapshot Frame defines what a **Terraform Snapshot** means in v0.1.

Terraform Snapshot evaluation in v0.1 is intentionally limited to:
- static `.tf` / `.tfvars` file content
- glob + substring matching only

## 2. In-Scope Artifacts (v0.1)

- Terraform source: `**/*.tf`
- Terraform variables: `**/*.tfvars`, `**/*.auto.tfvars`

The evaluator MAY be configured to scan:
- all files under repo path, OR
- changed files via deterministic diff scope

## 3. Out-of-Scope (v0.1)

Terraform Snapshot MUST NOT:
- run `terraform init/plan/apply`
- parse state files semantically
- infer resource graphs
- evaluate cloud provider runtime state
- perform policy reasoning (only pattern matching)

## 4. Determinism

- No network calls
- No external command execution

## 5. Evidence

Violations MUST include at minimum:
- offending `file`
- matched `pattern`

## 6. Override Boundaries

All overrides MUST comply with:
- `authority/OVERRIDE_BOUNDARIES.md`

