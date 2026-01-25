# Engine Freeze Declaration (v0.1)

This document freezes the meaning of the Policy Authority Engine at **v0.1**.
It is a **semantic freeze**: implementation details may evolve, but the meaning of the Engine’s output MUST NOT.

## 1. What Is Frozen

### 1.1 Frozen Output Contract
The Engine’s only normative output is a **Verdict** document that conforms to:

- `engine/verdict.schema.json` (Policy Authority Verdict v0.1)

The schema version is carried in the verdict as:

- `spec_version: "v0.1"`

The Engine MUST NOT emit fields outside the schema (the schema forbids additional properties).

### 1.2 Frozen Meaning of PASS / FAIL
The Engine is **FAIL-only** and **non-interpretive**.

- `verdict = "PASS"` means:
  - The submitted snapshot is **Engine-admissible** under the invoked Frame rules, and
  - No invariant violations were detected by the Engine.
  - Therefore, `violations` MUST be an empty array.

- `verdict = "FAIL"` means:
  - The submitted snapshot is **not acceptable for recording** under the invoked Frame rules, because
  - At least one invariant violation was detected by the Engine.
  - Therefore, `violations` MUST contain at least one item.

The Engine MUST NOT claim that a policy is correct, secure, compliant, recommended, or effective.

### 1.3 Frozen Snapshot Identity Semantics
The verdict MUST include `snapshot.hash`:

- `snapshot.hash` is a **content identity** string in the form `sha256:<64-hex>`.
- The Engine MUST treat `snapshot.hash` as the stable identifier of the snapshot input,
  and MUST NOT reinterpret past snapshots by changing hash semantics.

(How the hash is computed is defined by the Snapshot/Frame specification, not by the Engine.)

## 2. What Is Not Frozen (Allowed Changes)

The following changes are allowed **only if** they do not change the semantics above:

- Performance improvements
- Refactoring (internal code movement)
- CLI ergonomics and UX
- Logging, error messages, and diagnostics
- Packaging / distribution changes

Any such change MUST preserve the verdict meaning and schema compliance.

## 3. Prohibited Changes (Violation of Freeze)

The following are prohibited in Engine v0.1:

- Changing the meaning of `PASS` or `FAIL`
- Allowing `PASS` with non-empty `violations`, or `FAIL` with empty `violations`
- Introducing domain-specific logic (e.g., Terraform/Kubernetes/Web semantics) into the Engine
- Adding “severity”, “risk scoring”, “recommendations”, or any interpretive judgement to the verdict
- Emitting additional fields not defined in the v0.1 verdict schema as normative output
- Reinterpreting historical verdicts by changing input identity semantics

If any prohibited change is desired, it MUST be introduced as a **new Engine line** (e.g., v0.2 or v1),
without invalidating or reinterpreting v0.1 verdicts.

## 4. Relationship to Frames and Authority

- Frames define how domain snapshots are shaped and which invariants apply.
- The Engine remains domain-agnostic and only enforces admissibility and invariant violations.
- Authority may admit new Frames, but Authority cannot override the Engine’s frozen meaning.

## 5. Compliance Requirement

Any implementation claiming to be “Policy Authority Engine v0.1” MUST:

- Emit verdicts conforming to the v0.1 verdict schema
- Preserve the PASS/FAIL semantics and violation constraints defined here
- Remain deterministic for the same inputs

---

End of declaration.
