# Sources — Agent File Scope snapshot_v0.1

Fixtures:
- fixtures/pass/: clean content with no restricted path references (expected PASS).
- fixtures/fail/case-001-boundary-001/: contains "authority/" to trigger AGENT-FILE-BOUNDARY-001 (expected FAIL).
- fixtures/fail/case-002-boundary-002/: contains "engine/" to trigger AGENT-FILE-BOUNDARY-002 (expected FAIL).
- fixtures/fail/case-003-invariant-001/: contains "snapshots/" to trigger AGENT-FILE-INV-001 (expected FAIL).
