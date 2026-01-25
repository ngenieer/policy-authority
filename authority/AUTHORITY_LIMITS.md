# Authority Limits and Self‑Binding Declaration

## 1. Purpose

This document defines the **self‑imposed limits** of the Authority Company.

It exists to make clear that authority in this system is not based on discretion, expertise, or moral judgment, but on **procedural restraint, public record, and user choice**.

This document is binding on the Authority Company itself.

---

## 2. Definition of Authority Company

In this document, **Authority Company** refers to the legal entity that:

- Defines and maintains the Authority Frame
- Publishes official Policy Snapshots
- Maintains Evaluation Engine specifications
- Records and publishes frame and snapshot changes

It does **not** refer to organizations that merely use this system.

---

## 3. Scope of Authority

The Authority Company MAY:

- Define the structure (schema) of the Authority Frame
- Publish new versions of the Authority Frame
- Publish official Policy Snapshots
- Approve or revoke Issuer status

The Authority Company MAY NOT:

- Determine whether a user decision is correct or incorrect
- Enforce how users act on PASS or FAIL outcomes
- Retroactively alter past evaluations
- Modify a Policy Snapshot without public record

---

## 3.1 Explicitly Refused Domains

The Authority Company explicitly refuses to exercise authority over
domains whose policy meaning depends on runtime interaction or
request-time semantics.

This includes, but is not limited to:

- Web-facing infrastructure (routing, headers, CDN, edge, request-level configuration)

This refusal is **by design, not by omission**.
No Authority Frame or Policy Snapshot may claim coverage over these domains.

---

## 4. Immutability and Public Record

All Authority Frame versions:

- Are published in a public repository
- Are versioned and tagged
- Remain permanently accessible

Past versions MUST NOT be deleted or silently altered.

This guarantees that historical decisions remain inspectable and reproducible.

---

## 5. Change as a Declared Event

Any change to the Authority Frame:

- MUST be published as a new version
- MUST include a written change declaration
- MUST describe scope, motivation, and impact
- MUST NOT invalidate past snapshots or verdicts

Undeclared or silent changes are considered non‑official and void.

---

## 5.1 Release Ledger Binding

The Authority is explicitly bound by the constitutional events recorded in `RELEASE.md`.

Once a freeze or boundary is recorded in the Release Ledger, the Authority:

- MUST NOT reinterpret or override the declared meaning retroactively.
- MUST NOT alter frozen semantics through policy, process, or exception.
- MAY introduce new versions or lines only through new, explicit ledger entries.

In particular, Engine freeze events recorded in the Release Ledger define
immutable semantic boundaries that the Authority itself cannot bypass.

---


## 6. Non‑Coercion Principle

Use of any Authority Frame version is **voluntary**.

The Authority Company:

- MAY recommend newer versions
- MAY deprecate older versions
- MAY NOT force migration

Users retain full autonomy over version selection.

---

## 7. No Outcome Control

The Authority Company:

- Provides evaluation mechanisms
- Records evaluation outcomes

It does NOT:

- Mandate operational decisions
- Override human or organizational judgment
- Assume responsibility for outcomes

Responsibility for decisions remains with the user organization.

---

## 8. Issuer Revocation

Issuer approval MAY be revoked if:

- Issuer violates declared issuance procedures
- Issuer falsifies records or attribution

Revocation MUST:

- Be publicly recorded
- Include stated reasons
- Not alter previously issued snapshots

---

## 9. Verification Over Trust

This system does not ask users to trust the Authority Company.

Instead, it provides:

- Publicly inspectable rules
- Reproducible evaluation mechanisms
- Immutable historical records

Trust emerges from **verifiability**, not reputation.

---

## 10. Final Declaration

The Authority Company binds itself to the constraints defined in this document.

Authority exists only within these limits.

Any action outside these limits is non‑authoritative by definition.

