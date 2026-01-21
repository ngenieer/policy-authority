> Status: Completed.
> This document records the constraints and scope used to produce the v0.1 Level 2 Terraform proof.


# Policy Authority v0.1 (Terraform)
## Implementation Handoff Prompt

---

### Context

You are implementing **Policy Authority v0.1 Level 2 (Terraform)**.

This project is **not** a product, service, platform, or advisory system.  
It is a **mechanical proof** that fixed policy snapshots can be applied **deterministically** to infrastructure code.

All scope, constraints, and intent are already defined.  
Your task is **implementation only**, not interpretation or improvement.

---

### Authoritative Specification (Read First)

You MUST treat the following document as **the sole source of truth**:

- **`v0.1 Level 2 (Terraform) — Implementation Plan`**

If a behavior, feature, option, or output is **not explicitly required** in that document,  
it is **forbidden**.

---

### Absolute Rules (Non-Negotiable)

1. **Do NOT add features**
   - No extra options
   - No defaults
   - No convenience behavior
   - No logging beyond what is required
   - No explanations or recommendations

2. **Do NOT reinterpret requirements**
   - Follow wording literally
   - Do not “improve” UX or DX
   - Do not generalize for future use

3. **If anything is ambiguous**
   - STOP
   - Ask a clarification question
   - Do NOT improvise

---

### Execution Constraints

- Exactly **one execution path**
- Explicit snapshot and target paths (no auto-discovery)
- Deterministic output (same input → same output)
- PASS / FAIL only
- Offline execution only
- Terraform only (no Web, no runtime, no admission logic)

---

### Required Outputs (Definition of DONE)

Your work is considered **DONE** only if **ALL** of the following exist and work:

- A single `eval` command that runs end-to-end
- `verdict.json` produced for:
  - one PASS Terraform example
  - one FAIL Terraform example
- `engine/schemas/verdict.schema.json` validating `verdict.json`
- A reproducibility script that:
  - runs evaluation multiple times
  - produces byte-identical verdict outputs
  - fails on any diff

**Nothing more.**

Anything beyond this invalidates the proof.

---

### Governance Reference (For Scope Discipline)

The following file exists to prevent scope expansion:

- `authority/AUTHORITY_LIMITS.md`

You must not implement anything that conflicts with it.

---

### Implementation Philosophy

This system must behave like **physics**, not judgment.

- No reasoning
- No advice
- No adaptation
- No learning

Only:
- fixed inputs
- fixed rules
- fixed outputs

---

### Final Instruction

Implement **exactly** what is specified.  
When complete, stop.

Do not propose next steps.  
Do not suggest enhancements.  
Do not add documentation beyond what is required.

