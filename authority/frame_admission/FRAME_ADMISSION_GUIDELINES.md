# FRAME_ADMISSION_GUIDELINES.md
Version: v0.1
Status: Normative (Boundary-Defining)
Last-Updated: 2026-01-XX

---

## 1. Purpose of This Document

This document does **not** explain how to add a Frame.

This document exists solely to define **when a Frame MUST NOT be admitted**
into the Policy Authority system.

Any Frame admitted in violation of these guidelines
invalidates the Authority’s constitutional guarantees.

This document is intentionally unfriendly.

---

## 2. What Admitting a Frame Means

Admitting a Frame means:

- Declaring that a specific **formal representation boundary**
  is eligible for policy snapshotting.
- Fixing the **maximum scope** of what the Authority is willing to assert.
- Explicitly refusing to reason about execution, meaning, or outcomes.

Admitting a Frame does **NOT** mean:

- Supporting a technology
- Understanding a domain
- Endorsing a workflow
- Guaranteeing correctness
- Ensuring safety
- Validating real-world effects

A Frame admission is a **constitutional act**, not a feature addition.

---

## 3. Mandatory Boundary Conditions

A Frame MUST satisfy **all** conditions below.
Violation of any single condition is grounds for rejection.

### 3.1 Snapshot Determinism

- A Snapshot MUST be derivable from files only.
- Snapshot derivation MUST NOT depend on:
  - Runtime state
  - Network access
  - Execution results
  - Environment variables
  - System clocks

If determinism cannot be guaranteed, the Frame MUST NOT be admitted.

---

### 3.2 Execution Exclusion

- The Authority MUST NOT:
  - Execute Frame artifacts
  - Simulate execution
  - Inspect execution outputs
  - Infer runtime behavior

If execution is required to understand policy impact,
the Frame MUST NOT be admitted.

---

### 3.3 Semantic Ignorance

- The Engine MUST remain agnostic to:
  - Business meaning
  - Safety implications
  - Correctness of intent
  - Operational consequences

If policy evaluation requires semantic interpretation,
the Frame MUST NOT be admitted.

---

### 3.4 Fail-Only Evaluation

- Policy evaluation MUST be:
  - Deterministic
  - Binary (PASS / FAIL)
  - Explanation-free by default

If partial success, auto-correction, or tolerance is required,
the Frame MUST NOT be admitted.

---

## 4. Frame Admission Checklist (Fail-Oriented)

A Frame MUST be rejected if **any** of the following apply:

- ❌ Requires inspecting live systems
- ❌ Requires execution to validate correctness
- ❌ Depends on implicit defaults
- ❌ Performs value normalization or auto-fixing
- ❌ Accepts ambiguous or incomplete input
- ❌ Uses “best effort” parsing
- ❌ Introduces convenience-based exceptions
- ❌ Attempts to be user-friendly

Passing this checklist does **not** imply suitability.
It only means rejection is not yet mandatory.

---

## 5. Explicit Non-Goals

For any admitted Frame, the Authority explicitly does NOT:

- Guarantee safety
- Prevent misuse
- Ensure correctness
- Detect malicious intent
- Protect users from consequences
- Align outcomes with stated intent

Any expectation beyond this list is invalid.

---

## 6. Issuer Responsibility Declaration

For every admitted Frame:

- The Authority approves **form**, not **content**
- The Issuer assumes **full responsibility** for:
  - Policy meaning
  - Execution results
  - Operational impact
  - Legal and ethical consequences

The Authority records.
The Issuer bears responsibility.

---

## 7. Rejection Is the Default

Frame admission is an exception.

The burden of proof lies entirely with the proposer.
Silence, ambiguity, or uncertainty MUST be interpreted as rejection.

---

## 8. Final Declaration

Policy Authority remains trustworthy only as long as it
refuses to understand the worlds it observes.

Understanding is contamination.
Execution is corruption.
Convenience is decay.

This document exists to preserve refusal.
