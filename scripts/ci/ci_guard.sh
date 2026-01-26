#!/usr/bin/env bash
set -euo pipefail

# Unified CI Guard for Policy Authority:
# - Engine Freeze surface protection
# - Frame constitution presence & frame immutability
# - Authority change acknowledgment
# - Authority sealed files + sealed hashes verification
# - Boundary enforcement (engine must not depend on frames/snapshots/authority)

BASE_REF=${BASE_REF:-origin/main}

fail() {
  echo "ci_guard: $*" >&2
  exit 1
}

info() {
  echo "ci_guard: $*" >&2
}

read_diff_name_status() {
  if git rev-parse --verify "$BASE_REF" >/dev/null 2>&1; then
    git diff --name-status "$BASE_REF...HEAD"
  else
    info "BASE_REF not found locally; falling back to 'git diff --name-status HEAD'"
    git diff --name-status HEAD
  fi
}

read_changed_files() {
  if git rev-parse --verify "$BASE_REF" >/dev/null 2>&1; then
    git diff --name-only "$BASE_REF...HEAD"
  else
    info "BASE_REF not found locally; falling back to 'git diff --name-only HEAD'"
    git diff --name-only HEAD
  fi
}

########################################
# Bootstrap: repo root
########################################
ROOT_DIR="$(git rev-parse --show-toplevel)"
cd "$ROOT_DIR"

# Best-effort fetch (do not hard fail on network/permission issues)
git fetch --quiet origin main || true

########################################
# Engine Freeze Rules
########################################

# E0: Engine Freeze must be declared
if [ ! -f "engine/ENGINE_FREEZE.md" ]; then
  fail "missing engine/ENGINE_FREEZE.md (Engine Freeze must be declared)"
fi

# E1: Frozen engine meaning surfaces must not change (allow initial add only)
while IFS=$'\t' read -r status path; do
  [ -z "${path:-}" ] && continue
  case "$path" in
    engine/verdict.schema.json|engine/ENGINE_FREEZE.md)
      if [ "${status:0:1}" = "A" ]; then
        continue
      fi
      fail "unauthorized change under engine frozen surface: $status $path"
      ;;
    *)
      ;;
  esac
done < <(read_diff_name_status)

########################################
# Frame Rules
########################################

# F1: every frame must contain FRAME_CONSTITUTION.md
missing=0
while IFS= read -r dir; do
  [ -z "$dir" ] && continue
  if [ ! -f "$dir/FRAME_CONSTITUTION.md" ]; then
    echo "ci_guard: missing FRAME_CONSTITUTION.md in $dir" >&2
    missing=1
  fi
done < <(find frames -mindepth 1 -maxdepth 1 -type d -print)

if [ "$missing" -ne 0 ]; then
  exit 1
fi

# F2: only allowed change under frames/*/ is adding FRAME_CONSTITUTION.md
# Exception: explicit FRAME_UPDATE_ACK(<frame-name>) in the latest commit message allows editing that frame's constitution
commit_msg_latest="$(git log -1 --pretty=%B)"
while IFS=$'\t' read -r status path; do
  [ -z "${path:-}" ] && continue
  case "$path" in
    frames/*)
      # Allow add of FRAME_CONSTITUTION.md
      if [[ "$path" =~ ^frames/[^/]+/FRAME_CONSTITUTION\.md$ ]] && [ "${status:0:1}" = "A" ]; then
        continue
      fi
      # Allow add of authority.mapping.yml
      if [[ "$path" =~ ^frames/[^/]+/authority\.mapping\.yml$ ]] && [ "${status:0:1}" = "A" ]; then
        continue
      fi
      # Allow targeted edits to an existing FRAME_CONSTITUTION.md only when an ACK is present
      if [[ "$path" =~ ^frames/([^/]+)/FRAME_CONSTITUTION\.md$ ]] && [ "${status:0:1}" = "M" ]; then
        frame_name="${BASH_REMATCH[1]}"
        ack_token="FRAME_UPDATE_ACK(${frame_name})"
        if [[ "$commit_msg_latest" == *"$ack_token"* ]]; then
          info "frame constitution edit allowed by $ack_token"
          continue
        fi
      fi
      fail "unauthorized change under frames/: $status $path"
      ;;
    *)
      ;;
  esac
done < <(read_diff_name_status)

########################################
# Authority Acknowledgment Rule
########################################

# A1: authority/ changes require explicit ACK marker in commit message
authority_change=0
while IFS=$'\t' read -r status path; do
  [ -z "${path:-}" ] && continue
  case "$path" in
    authority/*)
      authority_change=1
      ;;
    *)
      ;;
  esac
done < <(read_diff_name_status)

if [ "$authority_change" -eq 1 ]; then
  msg=$(git log -1 --pretty=%B)
  if [[ "$msg" != *"AUTHORITY_CHANGE_ACK"* ]]; then
    fail "authority path changed without AUTHORITY_CHANGE_ACK in commit message"
  fi
fi

########################################
# Authority Immutability (Sealed) Rules
########################################

SEALED_FILES_YML="authority/SEALED_FILES.yml"
SEALED_HASHES_YML="authority/SEALED_HASHES.yml"

if [[ ! -f "$SEALED_FILES_YML" ]]; then
  fail "Missing: $SEALED_FILES_YML"
fi
if [[ ! -f "$SEALED_HASHES_YML" ]]; then
  fail "Missing: $SEALED_HASHES_YML (run scripts/gen_sealed_hashes.sh and commit it)"
fi

# Read sealed files from SEALED_FILES.yml
mapfile -t SEALED_FILES < <(
  grep -E '^\s*-\s+' "$SEALED_FILES_YML" \
    | sed -E 's/^\s*-\s+//' \
    | sed -E 's/\s+#.*$//' \
    | sed -E 's/^"(.*)"$/\1/' \
    | sed -E "s/^'(.*)'$/\1/" \
    | sed -E 's/^\s+|\s+$//g' \
    | grep -vE '^\s*$'
)

if [[ ${#SEALED_FILES[@]} -eq 0 ]]; then
  fail "No sealed files in $SEALED_FILES_YML"
fi

CHANGED_FILES="$(read_changed_files || true)"

# S1: Block any changes to sealed files in PR diff, unless explicitly declaring a new Authority instance
ALLOW_NEW_AUTHORITY_INSTANCE=${ALLOW_NEW_AUTHORITY_INSTANCE:-0}
commit_msg_latest="$(git log -1 --pretty=%B)"

for f in "${SEALED_FILES[@]}"; do
  if echo "$CHANGED_FILES" | grep -qx "$f"; then
    if [[ "$ALLOW_NEW_AUTHORITY_INSTANCE" = "1" || "$commit_msg_latest" == *"NEW_AUTHORITY_INSTANCE_ACK"* ]]; then
      info "sealed file changed but allowed by NEW_AUTHORITY_INSTANCE_ACK / ALLOW_NEW_AUTHORITY_INSTANCE=1: $f"
      continue
    fi
    fail "Sealed file changed: $f
This requires declaring a NEW Authority instance (set ALLOW_NEW_AUTHORITY_INSTANCE=1 and include NEW_AUTHORITY_INSTANCE_ACK in commit message)."
  fi
done

# S2: Verify hashes match SEALED_HASHES.yml (detect silent tampering)
verified_count=0
while IFS= read -r line; do
  # Strip trailing comments
  line="$(echo "$line" | sed -E 's/\s+#.*$//')"

  # Match: <indent><path>: <hash>
  if [[ "$line" =~ ^[[:space:]]+([^:#]+)[[:space:]]*:[[:space:]]*([0-9a-f]{64})[[:space:]]*$ ]]; then
    rel="${BASH_REMATCH[1]}"
    expected="${BASH_REMATCH[2]}"

    rel="$(echo "$rel" | sed -E 's/^\s+|\s+$//g')"

    if [[ -z "$rel" || -z "$expected" ]]; then
      continue
    fi

    if [[ ! -f "$rel" ]]; then
      fail "Sealed file missing from working tree: $rel"
    fi

    actual="$(sha256sum "$rel" | awk '{print $1}')"
    if [[ "$actual" != "$expected" ]]; then
      fail "Sealed hash mismatch: $rel
expected=$expected
actual  =$actual"
    fi

    verified_count=$((verified_count + 1))
  fi
done < "$SEALED_HASHES_YML"

if [[ "$verified_count" -eq 0 ]]; then
  fail "No valid hash entries parsed from $SEALED_HASHES_YML (format drift would disable verification)."
fi

########################################
# Boundary enforcement: engine must not depend on frames/snapshots/authority
########################################

ENGINE_FILES_CHANGED="$(echo "$CHANGED_FILES" | grep -E '^engine/' || true)"
if [[ -n "$ENGINE_FILES_CHANGED" ]]; then
  info "Engine changes detected; enforcing boundary rules."

  # Limit scans to changed engine files to avoid false positives in untouched docs
  readarray -t ENGINE_FILES_ARRAY <<<"$(echo "$ENGINE_FILES_CHANGED")"

  if command -v rg >/dev/null 2>&1; then
    if rg -n --hidden --no-ignore -S '(?:^|[^a-zA-Z0-9_])(frames/|snapshots/)(?:[^a-zA-Z0-9_]|$)' "${ENGINE_FILES_ARRAY[@]}"; then
      fail "engine/ references frames/ or snapshots/ (reverse dependency forbidden)"
    fi
    if rg -n --hidden --no-ignore -S '(?:^|[^a-zA-Z0-9_])(authority/)(?:[^a-zA-Z0-9_]|$)' "${ENGINE_FILES_ARRAY[@]}"; then
      fail "engine/ references authority/ (strict boundary). If you need this, CI should read authority, not engine code."
    fi
  else
    info "rg not found; using grep fallback for boundary enforcement."
    if grep -RInE '(^|[^a-zA-Z0-9_])(frames/|snapshots/)([^a-zA-Z0-9_]|$)' "${ENGINE_FILES_ARRAY[@]}" >/dev/null 2>&1; then
      grep -RInE '(^|[^a-zA-Z0-9_])(frames/|snapshots/)([^a-zA-Z0-9_]|$)' "${ENGINE_FILES_ARRAY[@]}" || true
      fail "engine/ references frames/ or snapshots/ (reverse dependency forbidden)"
    fi
    if grep -RInE '(^|[^a-zA-Z0-9_])(authority/)([^a-zA-Z0-9_]|$)' "${ENGINE_FILES_ARRAY[@]}" >/dev/null 2>&1; then
      grep -RInE '(^|[^a-zA-Z0-9_])(authority/)([^a-zA-Z0-9_]|$)' "${ENGINE_FILES_ARRAY[@]}" || true
      fail "engine/ references authority/ (strict boundary). If you need this, CI should read authority, not engine code."
    fi
  fi
fi

########################################
# Authority Spec (Machine-readable) Rules
########################################

if [ -f "scripts/ci/ci_authority_spec_guard.sh" ]; then
  info "Running authority spec guard (machine-readable constitution)."
  bash "scripts/ci/ci_authority_spec_guard.sh"
else
  info "Authority spec guard not present; skipping."
fi

info "All guards passed."
