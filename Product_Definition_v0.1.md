# Product Definition v0.1 (EN)

## 1. What This System Is
This system is an **AI Decision Audit & Enforcement Infrastructure**.

It exists to determine **whether changes produced by AI agents should be accepted or rejected**, based on **predefined, versioned, and auditable criteria**, without relying on human judgment at runtime.

The system does **not assist decision-making**. It **executes decisions that have already been fixed into policy**.

---

## 2. What This System Is Not
- Not an AI coding assistant
- Not a code quality analyzer
- Not a recommendation or advisory tool
- Not a human-in-the-loop review system

This system does **not** explain *how* to change code. It only explains **why a change is accepted or rejected**.

---

## 3. Core Problem Addressed
AI agents increasingly:
- generate infrastructure definitions (Terraform, Kubernetes, IAM)
- propose changes with high blast radius
- act faster than human review can reliably follow

Organizations face a structural gap:
- **AI executes changes**
- **Humans remain accountable**

This system closes that gap by:
- fixing decision criteria in advance
- executing those criteria mechanically
- producing auditable evidence for every decision

---

## 4. Core Concept: Policy Snapshot
A **Policy Snapshot** is an immutable bundle that represents:
- all decision criteria valid at a specific point in time
- the authority that issued those criteria
- a cryptographic identity (hash, optional signature)

All decisions are bound to a Policy Snapshot.

There is no concept of "latest" at decision time — only **explicitly referenced snapshots**.

---

## 5. Authority and Trust Model
The system distinguishes between:
- **Decision Execution** (always local, deterministic)
- **Policy Issuance** (centralized, authoritative)

Policy Snapshots may be:
- Unofficial (Git-only, unsigned)
- Official (signed by the platform issuer)
- Organization-certified (co-signed by the organization)

Trust level affects **proof strength**, not execution behavior.

---

## 6. Why Infrastructure First
Infrastructure changes:
- have immediate impact
- have weak or no test coverage
- trigger audits faster than application code

Therefore, infrastructure is the fastest domain where:
- human judgment fails first
- system-level criteria are demanded

---

## 7. Product Boundary (v0.1)
Included:
- Infrastructure change auditing
- Policy Snapshot execution
- PASS / FAIL enforcement
- Verifiable decision artifacts

Excluded:
- Application code auditing
- Data logic auditing
- UI dashboards
- Pricing, billing, or user management

---

## 8. Long-Term Direction
This system is designed to become:
- a **decision authority layer**
- independent of specific AI models
- reusable across infrastructure, code, and data domains

It is built as infrastructure, not as a service.

