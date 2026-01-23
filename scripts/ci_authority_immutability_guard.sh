#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(git rev-parse --show-toplevel)"
cd "$ROOT_DIR"

SEALED_FILES_YML="authority/SEALED_FILES.yml"
SEALED_HASHES_YML="authority/SEALED_HASHES.yml"

# Determine diff base (CI-friendly)
BASE_REF="${BASE_REF:-origin/main}"

echo "[INFO] Using BASE_REF=$BASE_REF"
git fetch --quiet origin main || true

if [[ ! -f "$SEALED_FILES_YML" ]]; then
  echo "[FAIL] Missing: $SEALED_FILES_YML" >&2
  exit 1
fi

if [[ ! -f "$SEALED_HASHES_YML" ]]; then
  echo "[FAIL] Missing: $SEALED_HASHES_YML (run scripts/gen_sealed_hashes.sh and commit it)" >&2
  exit 1
fi

# Read sealed files
mapfile -t SEALED_FILES < <(grep -E '^\s*-\s+' "$SEALED_FILES_YML" | sed -E 's/^\s*-\s+//')

if [[ ${#SEALED_FILES[@]} -eq 0 ]]; then
  echo "[FAIL] No sealed files in $SEALED_FILES_YML" >&2
  exit 1
fi

# 1) Block any changes to sealed files in PR diff
CHANGED_FILES="$(git diff --name-only "$BASE_REF"...HEAD || true)"

for f in "${SEALED_FILES[@]}"; do
  if echo "$CHANGED_FILES" | grep -qx "$f"; then
    echo "[FAIL] Sealed file changed: $f" >&2
    echo "       This requires declaring a NEW Authority instance (not allowed in-place)." >&2
    exit 1
  fi
done
echo "[OK] No sealed files changed in diff."

# 2) Verify hashes match SEALED_HASHES.yml (detects silent tampering)
# Parse entries like: "  path: hash"
while IFS= read -r line; do
  [[ "$line" =~ ^[[:space:]]{2}[^[:space:]].*:\  ]] || continue
  rel="$(echo "$line" | sed -E 's/^\s{2}([^:]+):\s+([0-9a-f]{64})\s*$/\1/')"
  expected="$(echo "$line" | sed -E 's/^\s{2}([^:]+):\s+([0-9a-f]{64})\s*$/\2/')"
  if [[ -z "$rel" || -z "$expected" ]]; then
    continue
  fi
  if [[ ! -f "$rel" ]]; then
    echo "[FAIL] Sealed file missing from working tree: $rel" >&2
    exit 1
  fi
  actual="$(sha256sum "$rel" | awk '{print $1}')"
  if [[ "$actual" != "$expected" ]]; then
    echo "[FAIL] Sealed hash mismatch: $rel" >&2
    echo "       expected=$expected" >&2
    echo "       actual  =$actual" >&2
    exit 1
  fi
done < "$SEALED_HASHES_YML"
echo "[OK] Sealed hashes verified."

# 3) Boundary enforcement: engine must not depend on frames/snapshots
# (You can widen/narrow patterns as you like.)
ENGINE_FILES_CHANGED="$(echo "$CHANGED_FILES" | grep -E '^engine/' || true)"
if [[ -n "$ENGINE_FILES_CHANGED" ]]; then
  echo "[INFO] Engine changes detected; enforcing boundary rules."
  # Search within engine directory for forbidden references
  # - frames/
  # - snapshots/
  # - authority/ (optional: keep as warn; here we FAIL for strictness)
  if rg -n --hidden --no-ignore -S '(?:^|[^a-zA-Z0-9_])(frames/|snapshots/)(?:[^a-zA-Z0-9_]|$)' engine; then
    echo "[FAIL] engine/ references frames/ or snapshots/ (reverse dependency forbidden)" >&2
    exit 1
  fi
  # Optional strict rule: engine must not import authority/
  if rg -n --hidden --no-ignore -S '(?:^|[^a-zA-Z0-9_])(authority/)(?:[^a-zA-Z0-9_]|$)' engine; then
    echo "[FAIL] engine/ references authority/ (strict boundary). If you need this, CI should read authority, not engine code." >&2
    exit 1
  fi
fi

echo "[OK] Authority immutability guard passed."
