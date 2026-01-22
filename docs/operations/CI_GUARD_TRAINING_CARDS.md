# CI Guard Training Cards

Purpose: Operational Training for Policy Authority CI Guard

This document provides **intentional failure scenarios** to train operational instinct when managing CI guards in Policy Authority.
The goal is not correctness, but **refusal discipline**.

These exercises MUST be performed only on temporary branches and reverted after execution.

---

## Card 1 — Frame Constitution Missing

**Action**
```bash
mv frames/terraform/FRAME_CONSTITUTION.md frames/terraform/FRAME_CONSTITUTION.md.bak
```

**Expected Result**
- CI FAIL
- Message indicates missing FRAME_CONSTITUTION.md

**Recovery**
```bash
mv frames/terraform/FRAME_CONSTITUTION.md.bak frames/terraform/FRAME_CONSTITUTION.md
```

---

## Card 2 — Unauthorized File Added Under Frame

**Action**
```bash
echo "x" > frames/terraform/NOT_ALLOWED.txt
```

**Expected Result**
- CI FAIL
- Unauthorized change under frames/*

**Recovery**
```bash
rm -f frames/terraform/NOT_ALLOWED.txt
```

---

## Card 3 — Modification of Existing Frame File

**Action**
```bash
echo "" >> frames/terraform/FRAME_CONSTITUTION.md
```

**Expected Result**
- CI FAIL

**Recovery**
```bash
git checkout -- frames/terraform/FRAME_CONSTITUTION.md
```

---

## Card 4 — Deletion of Frame Constitution

**Action**
```bash
rm -f frames/terraform/FRAME_CONSTITUTION.md
```

**Expected Result**
- CI FAIL (multiple rules may trigger)

**Recovery**
```bash
git checkout -- frames/terraform/FRAME_CONSTITUTION.md
```

---

## Card 5 — Frame Directory Rename

**Action**
```bash
mv frames/terraform frames/terraform_tmp
```

**Expected Result**
- CI FAIL due to rename/delete detection

**Recovery**
```bash
mv frames/terraform_tmp frames/terraform
```

---

## Card 6 — Authority Modification Without ACK

**Action**
```bash
echo "" >> authority/AUTHORITY_LIMITS.md
git add authority/AUTHORITY_LIMITS.md
git commit -m "test: touch authority without ack"
bash scripts/ci/ci_frame_guard.sh
```

**Expected Result**
- CI FAIL
- Missing AUTHORITY_CHANGE_ACK

**Recovery**
```bash
git reset --hard HEAD~1
```

---

## Card 7 — Authority Modification With ACK

**Action**
```bash
echo "" >> authority/AUTHORITY_LIMITS.md
git add authority/AUTHORITY_LIMITS.md
git commit -m "test: touch authority AUTHORITY_CHANGE_ACK"
bash scripts/ci/ci_frame_guard.sh
```

**Expected Result**
- CI PASS

**Recovery**
```bash
git reset --hard HEAD~1
```

---

## Card 8 — Docs-Only Change

**Action**
```bash
mkdir -p docs/tmp
echo "x" > docs/tmp/test.txt
bash scripts/ci/ci_frame_guard.sh
```

**Expected Result**
- CI PASS

**Recovery**
```bash
rm -rf docs/tmp
```

---

## Card 9 — BASE_REF Alignment Test

**Action**
```bash
git fetch origin
BASE_REF=origin/main bash scripts/ci/ci_frame_guard.sh
```

**Expected Result**
- CI behavior matches remote execution

**Operational Insight**
Local pass but CI fail usually indicates BASE_REF mismatch.

---

## Card 10 — Exception Pressure Response Drill

**Scenario**
A contributor requests adding README.md under frames/terraform.

**Correct Response**
> "Changes under frames/* are prohibited and enforced by CI. Please place documentation under docs/."

No further explanation is provided.

---

## Training Principle

- Failure is normal
- Rejection is correct behavior
- Explanation is not required
- CI exists to prevent human discretion

Mastery is achieved when refusal feels automatic.

