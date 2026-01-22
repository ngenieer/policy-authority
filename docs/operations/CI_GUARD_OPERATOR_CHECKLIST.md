# CI Guard Operator Checklist

Purpose: Day-to-day operational checklist for maintaining refusal discipline in Policy Authority.

This checklist is used **by humans**, not by the system.
Its purpose is to ensure operators do not weaken CI guard behavior through habit, empathy, or convenience.

---

## 0. Pre-Action Check (Before Any Response)

Before responding to a CI failure, confirm:

- [ ] The failure was produced by CI guard (not engine logic)
- [ ] The failure message is deterministic
- [ ] No automatic remediation is expected

If all three are true, proceed without discussion.

---

## 1. Frame-Related Failures

### 1.1 Missing FRAME_CONSTITUTION.md

**CI Signal**
- Missing FRAME_CONSTITUTION.md under frames/*

**Operator Action**
- Do NOT investigate intent
- Do NOT offer workaround
- Respond with:

> "This Frame lacks a required constitution file. Add FRAME_CONSTITUTION.md and retry."

Stop.

---

### 1.2 Unauthorized Change Under frames/*

**CI Signal**
- Added/modified/deleted files under frames/* not explicitly permitted

**Operator Action**
- Do NOT suggest exceptions
- Do NOT accept partial fixes
- Respond with:

> "Changes under frames/* are prohibited and enforced by CI."

Stop.

---

## 2. Authority-Related Failures

### 2.1 authority/* Modified Without ACK

**CI Signal**
- authority/* or authority/frame_admission/* changed
- AUTHORITY_CHANGE_ACK missing from commit message

**Operator Action**
- Do NOT review content
- Do NOT discuss correctness
- Respond with:

> "Authority documents require explicit acknowledgement. Include AUTHORITY_CHANGE_ACK and retry."

Stop.

---

## 3. Questions You MUST NOT Answer

If asked:
- "Why is this so strict?"
- "Can we make an exception?"
- "Isn't this inconvenient?"
- "Just this once?"

**Required Response**

> "The rule is enforced by CI."

No elaboration.

---

## 4. Emotional Pressure Handling

When feeling:
- Sympathy for contributor
- Urge to help manually
- Desire to explain rationale

**Operator Reminder**
- CI exists to remove discretion
- Helping is policy erosion
- Silence is compliance

---

## 5. Escalation Criteria (Rare)

Escalation is permitted ONLY if:

- [ ] The rule itself is incorrect
- [ ] The failure contradicts written constitutional documents

Escalation path:
- Open a proposal to modify the rule
- Follow Authority-level change process

Never bypass CI.

---

## 6. Post-Incident Review (Optional)

After repeated similar failures:

- [ ] Update training cards
- [ ] Clarify documentation location (docs/)
- [ ] Do NOT relax CI guard

---

## Final Operator Reminder

CI guard is not a tool.
It is a boundary.

Your job is not to help changes pass.
Your job is to ensure they stop.
