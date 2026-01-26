# Frame Author Minimum Interface (PA v2)
**Contract document for Frame Authors. Grounded strictly in repository evidence lines. Compatible with Engine v0.1 freeze.**
**Use as the authoritative interface; do not add requirements beyond cited evidence.**
Analyzed commit: `6e9c46dc7040fa2857cde684bc3bca746c704c97`

## 1. Purpose
Frame Authors MUST supply artifacts that let the frozen Engine v0.1 produce verdicts deterministically against Frame-defined snapshots.  
Evidence: engine/ENGINE_FREEZE.md#L1-L85

## 2. Definitions
- **Verdict**: JSON conforming to `engine/schemas/verdict.schema.json` with required fields `spec_version`, `verdict`, `snapshot`, `target`, `violations`.  
  Evidence: engine/schemas/verdict.schema.json#L5-L127
- **PASS**: verdict with empty `violations`. **FAIL**: verdict with ≥1 violation.  
  Evidence: engine/schemas/verdict.schema.json#L86-L127
- **Snapshot hash**: `sha256:<64-hex>` string in `snapshot.hash`.  
  Evidence: engine/schemas/verdict.schema.json#L33-L36

## 3. Required Artifacts (MUST)
- `frames/<frame>/SNAPSHOT_FRAME.md` specifying in-scope globs, out-of-scope actions, determinism, evidence minimums, and override boundaries.  
  Evidence (Terraform): frames/terraform/SNAPSHOT_FRAME.md#L1-L44; Evidence (Kubernetes): frames/kubernetes/SNAPSHOT_FRAME.md#L1-L43
- `frames/<frame>/FRAME_CONSTITUTION.md` declaring frame identity, scope, determinism commitment, execution exclusions, non-interpretation, fail-only guarantee, responsibility, and self-invalidation.  
  Evidence (Terraform): frames/terraform/FRAME_CONSTITUTION.md#L1-L135; Evidence (Kubernetes): frames/kubernetes/FRAME_CONSTITUTION.md#L1-L132
- `frames/<frame>/authority.mapping.yml` linking the frame to authority constitution version and capability `ISSUE_SNAPSHOT`.  
  Evidence: frames/terraform/authority.mapping.yml#L1-L26; frames/kubernetes/authority.mapping.yml#L1-L26
- Snapshots MUST provide metadata and rule index files:
  - `snapshots/<domain>/snapshot_v*/SNAPSHOT_META.md` with identity, frame, engine_min_version, evaluation model, enforcement mode.  
    Evidence (Terraform): snapshots/terraform/snapshot_v0.1/SNAPSHOT_META.md#L1-L31; Evidence (Kubernetes): snapshots/kubernetes/snapshot_v0.1/SNAPSHOT_META.md#L1-L24
  - `snapshots/<domain>/snapshot_v*/policy_index.yml` with evaluation order and rule paths.  
    Evidence (Terraform): snapshots/terraform/snapshot_v0.1/policy_index.yml#L1-L17; Evidence (Kubernetes): snapshots/kubernetes/snapshot_v0.1/policy_index.yml#L1-L12
- Snapshot hashing for Terraform snapshots MUST follow the defined deterministic algorithm (file set, ordering, newline normalization, path+content concatenation, sha256).  
  Evidence: snapshots/terraform/snapshot_v0.1/SNAPSHOT_META.md#L19-L45

## 4. Optional Artifacts (MAY)
- Kubernetes Frame MAY include rendered manifests (e.g., Helm output) as static YAML.  
  Evidence: frames/kubernetes/SNAPSHOT_FRAME.md#L15-L17
- Deprecated rules bundle for audit continuity MAY be present; evaluation order decides which rule records evidence.  
  Evidence: snapshots/terraform/snapshot_v0.1/SNAPSHOT_META.md#L47-L55

## 5. Prohibited Assumptions (MUST NOT)
- MUST NOT rely on engine emitting fields outside verdict schema; `additionalProperties: false` forbids extras.  
  Evidence: engine/schemas/verdict.schema.json#L4-L12
- MUST NOT expect PASS with violations or FAIL with zero violations.  
  Evidence: engine/schemas/verdict.schema.json#L86-L127
- MUST NOT require network access or external command execution in snapshot evaluation.  
  Evidence (Terraform): frames/terraform/SNAPSHOT_FRAME.md#L16-L33; Evidence (Kubernetes): frames/kubernetes/SNAPSHOT_FRAME.md#L28-L32
- MUST NOT require semantic parsing or runtime interaction (engine is glob+substring, non-interpretive).  
  Evidence (Terraform): frames/terraform/SNAPSHOT_FRAME.md#L7-L28; Evidence (Kubernetes): frames/kubernetes/SNAPSHOT_FRAME.md#L7-L27
- MUST NOT change meaning of snapshot hash format (`sha256:<64-hex>`).  
  Evidence: engine/ENGINE_FREEZE.md#L34-L41; engine/schemas/verdict.schema.json#L33-L36

## 6. Enforcement Boundary (FAIL conditions)
- Verdicts violating schema (missing required fields, extra fields, wrong `spec_version`, PASS/FAIL inconsistency) are invalid.  
  Evidence: engine/schemas/verdict.schema.json#L5-L127
- Engine interpretation change (domain logic, severity, recommendations) is prohibited under freeze; such changes require new engine line.  
  Evidence: engine/ENGINE_FREEZE.md#L19-L67
- Snapshot requirements of each Frame (in-scope globs, out-of-scope prohibitions, determinism) are mandatory; violating them renders the Frame constitutionally invalid.  
  Evidence (Terraform): frames/terraform/FRAME_CONSTITUTION.md#L31-L74; Evidence (Kubernetes): frames/kubernetes/FRAME_CONSTITUTION.md#L31-L72
- Execution of terraform/kubectl or cloud/cluster interaction causes non-compliance.  
  Evidence: frames/terraform/SNAPSHOT_FRAME.md#L22-L28; frames/kubernetes/SNAPSHOT_FRAME.md#L21-L27; frames/terraform/FRAME_CONSTITUTION.md#L65-L74; frames/kubernetes/FRAME_CONSTITUTION.md#L63-L72

## 7. Stability Notes (v2 readiness)
- Engine semantics (verdict meaning, hash identity, schema) are frozen at v0.1 and MUST remain unchanged; new semantics require a new engine line.  
  Evidence: engine/ENGINE_FREEZE.md#L3-L67
- Snapshot evaluation model is glob + substring only; no semantic parsing.  
  Evidence: frames/terraform/SNAPSHOT_FRAME.md#L7-L9; frames/kubernetes/SNAPSHOT_FRAME.md#L7-L9
- Frames declare deterministic, file-only inputs with no network/exec; this is the stability expectation for reproducible evaluation.  
  Evidence: frames/terraform/FRAME_CONSTITUTION.md#L50-L74; frames/kubernetes/FRAME_CONSTITUTION.md#L48-L72
