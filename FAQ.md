# FAQ — Policy Authority

This document addresses **common misconceptions and boundary questions** that arise when first encountering Policy Authority.

The goal is not persuasion, but clarification.

---

## Q1. Is this an AI system that makes decisions?

**No.**

Policy Authority does not make decisions and does not exercise judgment.

All decisions are made **in advance by humans**, encoded as policy rules, and fixed into a Policy Snapshot.

The system merely executes those decisions deterministically.

If criteria are unclear or violated, the system fails rather than guessing.

---

## Q2. Is this a code review or quality analysis tool?

No.

Policy Authority does not assess code quality, style, performance, or best practices.

It enforces **explicit prohibitions and invariants** only.

If a rule is not written down, it does not exist.

---

## Q3. Does this replace human approval or governance processes?

No.

Policy Authority does not replace governance.
It **records and enforces** governance decisions that already exist.

Human approval, discussion, and responsibility occur *before* execution, not during it.

---

## Q4. Why is there no “warning” or “soft fail” mode?

Because ambiguity undermines accountability.

A warning that does not block execution shifts responsibility rather than fixing it.

In v0.1, every enforced rule either passes or fails.

---

## Q5. Can policies be updated automatically or continuously?

No.

There is no concept of a "latest" policy at runtime.

Every evaluation references an explicit Policy Snapshot by commit SHA and bundle hash.

Policy changes require deliberate publication of a new snapshot.

---

## Q6. Can AI help generate policies?

Optionally, yes — but **never as an authority**.

AI may assist in drafting or analyzing potential rules, but:

- Humans must decide
- Humans must publish
- Humans must take responsibility

AI-generated policies without human ownership defeat the purpose of the system.

---

## Q7. Why is the policy snapshot format and builder open source?

Because trust cannot be demanded from opaque mechanisms.

Anyone affected by a decision must be able to:

- inspect how a snapshot was built
- verify its identity
- reproduce a verdict independently

Authority comes from responsibility, not secrecy.

---

## Q8. If anyone can create a policy snapshot, what makes one “official”?

Execution behavior is identical for all snapshots.

What differs is **proof strength**.

An official snapshot is distinguished by:

- a recognized issuer
- a valid signature
- an issuance record

These elements establish who stands behind the policy.

---

## Q9. Does this system slow down development?

It slows down **unsafe execution**, not development.

By fixing criteria in advance, teams spend less time debating decisions during incidents and reviews.

---

## Q10. Is this system specific to infrastructure or Terraform/Kubernetes?

No, but v0.1 is.

The underlying model applies to any domain where:

- changes have impact
- responsibility matters
- criteria can be written down

Infrastructure is simply where these pressures appear first.

---

## Q11. Why is this called “Policy Authority” and not something more descriptive?

Because the system’s role is institutional, not functional.

It establishes *where authority over decisions resides*, not how changes are implemented.

---

## Q12. What happens if policies are wrong or incomplete?

Then responsibility lies with the issuer.

Policy Authority does not claim correctness.
It claims **traceability**.

Wrong policies can be replaced.
Unattributed decisions cannot.

---

## Q13. Is this meant to be a platform or a service?

Policy Authority is infrastructure.

It can be embedded in platforms or services, but it is not one by itself.

---

## One-Line Summary

> **Policy Authority exists to ensure that when decisions are enforced, their origin and ownership are never in doubt.**

