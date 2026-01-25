# FRAME_PROPOSAL_SKELETON.md
Version: v0.1
Status: Non-Normative (Submitter-Facing)
Audience: Frame Proposers
Last-Updated: 2026-01-XX

---

## IMPORTANT NOTICE

This document does NOT help you get a Frame admitted.

This document exists to make rejection explicit, predictable,
and responsibility-preserving.

If your proposal feels uncomfortable to write,
that discomfort is intentional.

---

## 1. Frame Identifier

- Frame Name:
- Short Description (formal, non-semantic):
- Proposed Snapshot Boundary (file types + directory scope):

---

## 2. Formal Representation Boundary

Describe ONLY the formal artifacts included in the Snapshot.

- Included file formats:
- Explicitly excluded artifacts:
- Maximum snapshot scope (what MUST NOT be included):

If the boundary cannot be described without referencing execution,
this Frame is invalid.

---

## 3. Determinism Declaration

Explain how Snapshot derivation remains deterministic.

Explicitly confirm that Snapshot derivation does NOT depend on:

- [ ] Runtime state
- [ ] Execution results
- [ ] Network access
- [ ] Environment variables
- [ ] System clocks
- [ ] External services

If any box cannot be checked, STOP.
This Frame MUST be rejected.

---

## 4. Execution Exclusion Statement

Explain why this Frame does NOT require:

- Execution
- Simulation
- Validation against real systems
- Interpretation of runtime behavior

If execution is necessary for understanding policy impact,
this Frame MUST be rejected.

---

## 5. Semantic Ignorance Justification

Explain how policy evaluation can occur WITHOUT:

- Understanding intent
- Understanding correctness
- Understanding safety implications
- Understanding real-world meaning

If semantic interpretation is required,
this Frame MUST be rejected.

---

## 6. Failure Mode Enumeration

List ALL known ways this Frame could fail or be misused.

Examples:
- Misinterpretation by Issuers
- False sense of safety
- Policy passing despite catastrophic outcomes

If you are unable to list failure modes,
this Frame MUST be rejected.

---

## 7. Explicit Non-Goals (Mandatory)

This Frame explicitly does NOT:

- Guarantee safety
- Prevent misuse
- Ensure correctness
- Protect users from consequences
- Validate execution outcomes

Add any additional non-goals specific to this Frame.

---

## 8. Issuer Responsibility Acceptance

By submitting this proposal, the proposer explicitly agrees:

- Authority approves form, not content
- All consequences remain the Issuer’s responsibility
- No expectation of safety, correctness, or suitability is implied

Signature (conceptual acknowledgment):

- Proposer Name:
- Date:

---

## 9. Self-Rejection Assessment (Mandatory)

Answer the following honestly:

> Why SHOULD this Frame be rejected?

List all reasons, even if you disagree with them.

If you cannot convincingly argue for rejection,
this proposal is incomplete and MUST be rejected.
