# CONTRIBUTING — Policy Authority

Thank you for your interest in contributing to Policy Authority.

This project welcomes contributions, but **not all changes are acceptable**.

Policy Authority is infrastructure for fixed responsibility, not a general-purpose tool. This document explains what kinds of contributions are encouraged, restricted, or rejected.

---

## 1. Guiding Principle

> **Contributions are accepted only if they preserve determinism, auditability, and attributable authority.**

Any change that weakens these properties will be rejected, regardless of technical merit.

---

## 2. What This Project Values

We value contributions that:

- Increase **determinism** (same input → same output)
- Improve **traceability** and audit evidence
- Clarify **boundaries** and explicit constraints
- Reduce ambiguity in evaluation or execution

---

## 3. Encouraged Contributions

The following contributions are generally welcome:

- Bug fixes that remove nondeterministic behavior
- Improvements to documentation and specifications
- Clarifications to policy schemas or rule definitions
- Additional test fixtures that demonstrate FAIL conditions
- Performance improvements that do not alter semantics

All contributions must include tests or reproducible examples.

---

## 4. Restricted Contributions (Require Strong Justification)

The following may be considered, but require strong justification:

- New rule schema fields
- New evaluation modes (e.g., diff-based vs full-scan)
- Additional target formats (beyond Terraform/Kubernetes)

Such changes must:

- Preserve offline execution
- Preserve snapshot immutability
- Preserve explicit policy referencing (no "latest")

---

## 5. Rejected by Design

The following types of contributions will be rejected:

- AI-driven decision-making or heuristic scoring
- "Warning", "advisory", or "soft fail" modes
- Automatic remediation or fix suggestions
- Runtime policy mutation or auto-updates
- Features that require network access during evaluation
- UI dashboards or approval workflows

These features contradict the core purpose of the project.

---

## 6. Backward Compatibility

Contributions MUST NOT:

- Break verification of existing Policy Snapshots
- Alter the meaning of historical verdict artifacts

If a change requires incompatibility, it must be proposed as a new major version with explicit migration rationale.

---

## 7. How to Propose Changes

1. Open an issue describing:
   - the problem being addressed
   - why it cannot be solved within existing constraints
2. Reference relevant specification documents
3. Explain how responsibility and authority remain explicit

Pull requests without prior discussion may be closed.

---

## 8. Contribution Review Criteria

Maintainers will review contributions using these questions:

- Does this change introduce ambiguity?
- Does it weaken reproducibility?
- Does it blur responsibility?
- Does it expand scope without necessity?

If the answer to any is "yes", the contribution will likely be rejected.

---

## 9. Code of Conduct

Contributors are expected to engage respectfully.

Disagreements about design are expected; disagreements about responsibility are not.

---

## Closing Statement

> **Policy Authority is conservative by design.**
> 
> If a contribution makes the system more flexible, it is probably wrong.
> If it makes the system more rigid and explicit, it is probably right.
