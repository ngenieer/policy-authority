# GOVERNANCE — Policy Authority

This document defines how **authority, responsibility, and recognition** are handled within the Policy Authority ecosystem.

It is intentionally procedural, not aspirational.

---

## 1. Purpose of Governance

Policy Authority separates **mechanism** from **authority**.

- Mechanisms (evaluation, enforcement, verification) are open and reproducible.
- Authority (policy issuance and responsibility) is deliberate and attributable.

This document defines how authority is granted, recognized, and constrained.

---

## 2. Definition of an Issuer

An **Issuer** is an entity that publicly accepts responsibility for a Policy Snapshot.

Issuance is not a technical act alone. It is a declaration of accountability.

By issuing a Policy Snapshot, an Issuer asserts:

> “We recognize these criteria as binding, and we accept responsibility for their consequences.”

---

## 3. Issuer Levels

Policy Authority recognizes three issuer levels.

### 3.1 Unofficial Issuer

- No signature
- No formal recognition
- No governance requirements

Unofficial snapshots:
- MAY be executed
- MUST be labeled as `UNOFFICIAL`
- MUST NOT be represented as authoritative

---

### 3.2 Organization Issuer

An Organization Issuer represents a legal or operational organization.

Requirements:

- Explicit ownership of the policy repository
- Delegated issuer key recognized by the Platform Root
- Acceptance of issuance responsibility

Organization Issuers:
- MAY issue official policy snapshots
- MUST maintain internal review procedures
- MUST be identifiable in verdict artifacts

---

### 3.3 Platform Root Issuer

The Platform Root Issuer is the ultimate trust anchor.

Characteristics:

- Singular (there is only one)
- Issues delegation to Organization Issuers
- Maintains the root of the trust chain

The Platform Root Issuer:
- DOES NOT define organizational policy
- DOES define issuance validity

---

## 4. Issuance Process

A Policy Snapshot becomes **official** only when:

1. The snapshot content is fixed and versioned
2. The snapshot identity (hash) is computed
3. The Issuer signs the snapshot identity
4. The issuance is recorded

Unsigned or unrecorded snapshots remain unofficial.

---

## 5. Delegation and Revocation

### 5.1 Delegation

- Delegation is explicit and revocable
- Delegation does not transfer policy authorship
- Delegation only transfers issuance authority

---

### 5.2 Revocation

Issuer recognition MAY be revoked if:

- Issuance procedures are violated
- Responsibility is denied or obscured
- Delegated keys are compromised

Revocation affects **recognition**, not execution capability.

---

## 6. What Governance Does Not Do

Governance does not:

- Judge policy quality
- Approve individual rules
- Interfere with enforcement decisions
- Override deterministic verdicts

Governance exists to clarify **who stands behind a decision**, not whether the decision was correct.

---

## 7. Transparency Requirements

All official issuances MUST:

- Reference a publicly inspectable snapshot
- Be verifiable via open tooling
- Preserve attribution over time

Opacity invalidates authority.

---

## 8. Evolution of Governance

Governance rules may evolve, but:

- Existing issued snapshots remain verifiable
- Historical authority claims remain inspectable

Governance changes SHALL NOT retroactively alter verdict meaning.

---

## Closing Statement

> **Authority is not a feature.**  
> **It is a responsibility that must be explicitly accepted and visibly carried.**

Policy Authority governance exists to ensure that this responsibility cannot be silently shifted or erased.
