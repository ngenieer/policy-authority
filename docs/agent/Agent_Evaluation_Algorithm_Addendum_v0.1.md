# Agent Evaluation Algorithm Addendum v0.1

> This addendum constrains the **minimum acceptable rule evaluation algorithm** for v0.1.
>
> Goal: eliminate implementation ambiguity and prevent creative interpretation.

---

## 1. Priority Order

For v0.1, the evaluation order SHALL be:

1) `rules/boundaries.yml`
2) `rules/invariants.yml`
3) (ignore) `rules/deprecated.yml` for enforcement

If any enforced rule violates, the run MUST FAIL.

---

## 2. Supported Matching Model (v0.1)

### 2.1 File-Based Matching Only

The evaluator SHALL implement a **file-based matching model**:

- It examines files within a target repository path
- It evaluates rules using:
  - file path glob matching
  - plain-text pattern matching

It SHALL NOT attempt semantic understanding.

---

### 2.2 Change Scope

For v0.1, the evaluator MUST support **either**:

- `--diff-base <git-ref>`: evaluate only changed files between base and HEAD, OR
- evaluate all files under the provided repo path

If diff-mode is implemented, it MUST be deterministic and must not rely on network.

---

## 3. Rule Schema: Required Subset

The evaluator MUST support the following minimum schema subset.

### 3.1 Boundaries Rules (required)

Each boundary rule MUST support:

- `id` (string)
- `title` (string)
- `enforcement.mode` = `fail`
- `match.files` (list of globs)
- `match.forbidden_patterns` (list of string patterns)

**Meaning:** If a target file path matches any `match.files` glob AND the file content contains ANY `forbidden_patterns`, then this rule is violated.

Example (conceptual):

- files: `**/*.tf`
- forbidden_patterns: `0.0.0.0/0`, `*:*`, `"Action\": "*"`

---

### 3.2 Invariants Rules (required)

Each invariant rule MUST support:

- `id` (string)
- `title` (string)
- `enforcement.mode` = `fail`
- `match.files` (list of globs)
- `match.required_absent` (list of string patterns)

**Meaning:** If a target file path matches any `match.files` glob AND the file content contains ANY `required_absent` pattern, then this rule is violated.

Note: despite the field name, v0.1 implements it as a simple "must-not-appear" list.

---

## 4. Deterministic Pattern Matching Rules

- Matching is **case-sensitive** by default
- No regex is required in v0.1
- Pattern matching SHALL be implemented as substring search
- Globs SHALL follow standard glob semantics (`**` allowed)

---

## 5. Evidence Extraction (required)

When a violation is detected, the evaluator MUST produce evidence as:

- `file`: offending file path
- `pattern`: offending pattern string
- `excerpt`: up to 200 characters around first match (optional but recommended)
- `offset`: byte or character index of first match (optional)

At minimum, `file` and `pattern` MUST be present.

---

## 6. Output Binding (required)

Each violation entry in `verdict.json` MUST include:

- `rule_id`
- `rule_type` = `boundary` | `invariant`
- `file`
- `reason`
- `evidence`:
  - `pattern`
  - optional `excerpt`

---

## 7. Forbidden Enhancements (v0.1)

The evaluator MUST NOT:

- call external APIs
- run terraform/kubectl
- parse plans semantically
- infer intent
- downgrade FAIL to WARN

---

## 8. Completion Test (required)

The implementation SHALL be considered acceptable if:

- Given `examples/infra-target/terraform/` and the example policy bundle,
  at least one Terraform rule produces FAIL with evidence.
- Given `examples/infra-target/k8s/` and the example policy bundle,
  at least one Kubernetes rule produces FAIL with evidence.

---

## 9. Integration Note

This addendum is compatible with future upgrades where:

- substring matching is replaced by structured parsers
- policy rules evolve

But for v0.1, this is the minimum execution contract.

