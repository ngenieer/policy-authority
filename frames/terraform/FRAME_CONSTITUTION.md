# Frame Constitution — Terraform (v0.1)
Version: v0.1  
Status: Normative (Frame-Binding)  
Applies-To: Terraform Frame  
Last-Updated: 2026-01-26

---

## 1. Purpose of This Document

This document is the constitutional self-binding contract
for the Terraform Frame admitted into the Policy Authority system.

This document does **not** describe usage or behavior guarantees.
It exists solely to define what this Frame explicitly refuses to do.

---

## 2. Identity of the Frame

- Frame Name: Terraform Frame
- Frame Identifier: terraform-v0.1
- Admission Reference: v0.1-authority-instance-2 (see RELEASE.md)
- Version: v0.1

This identity is immutable once admitted.
Any change constitutes a new Frame.

---

## 3. Formal Snapshot Boundary

This Frame is defined strictly by the following formal artifacts:

- Included file formats:
  - `**/*.tf`
  - `**/*.tfvars`
  - `**/*.auto.tfvars`
- Included directory scope: repository root and descendants
- Explicitly excluded files/directories:
  - `.terraform/`, `.terraform.lock.hcl`
  - Terraform state files (`*.tfstate`, `*.tfstate.backup`)
  - Provider caches, plugin binaries, plan files (`*.plan`, `*.tfplan`)

Anything not explicitly included here
is constitutionally outside the Frame.

---

## 4. Determinism Commitment

This Frame affirms that snapshots are derivable from static files only and do **not** depend on:
- Runtime state
- Execution results
- Network access
- Environment variables
- System clocks
- External services

If this commitment becomes false,
this Frame is constitutionally invalid.

---

## 5. Execution Exclusion Declaration

This Frame explicitly refuses:
- Execution of Terraform commands (`init/plan/apply`)
- Simulation of behavior
- Validation against real systems or cloud APIs
- Inspection of runtime outcomes

Any requirement for execution places the problem outside this Frame.

---

## 6. Semantic Non-Interpretation Clause

This Frame explicitly refuses to interpret:
- Business intent or architecture correctness
- Security/compliance posture
- Operational impact or cost
- Ethical or legal meaning
- Real-world consequences

Policy evaluation within this Frame
operates purely on formal structure (substring/glob matching).

---

## 7. Fail-Only Evaluation Guarantee

- Evaluation outcomes are binary: PASS or FAIL
- No partial success or auto-correction exists
- Ambiguity results in failure

---

## 8. Explicit Non-Goals

This Frame does **not**:
- Guarantee safety or correctness
- Prevent misuse or misconfiguration
- Detect malicious intent
- Protect users from consequences
- Align outcomes with stated intent

---

## 9. Responsibility Attribution

For this Frame:
- The Authority approves form only
- The Issuer bears full responsibility for policy meaning, execution results, operational impact, legal/ethical consequences
- No responsibility is transferred to the Authority

---

## 10. Frame Self-Invalidation Clause

If any statement in this constitution is violated or bypassed:
- The Frame MUST be considered invalid
- Past evaluations MUST NOT be relied upon
- Continued use is at the Issuer’s sole risk

No remediation obligation exists.

---

## 11. Final Declaration

This Frame exists only as long as it refuses to understand the world it observes.
Understanding contaminates. Execution corrupts. Convenience erodes trust.

This constitution binds the Frame, not the Authority.
