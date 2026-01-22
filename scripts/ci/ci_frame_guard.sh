#!/usr/bin/env bash
set -euo pipefail

# CI guard for frame constitution presence and frame directory protection.

BASE_REF=${BASE_REF:-origin/main}

read_diff() {
  if git rev-parse --verify "$BASE_REF" >/dev/null 2>&1; then
    git diff --name-status "$BASE_REF...HEAD"
  else
    git diff --name-status
  fi
}

fail() {
  echo "ci_frame_guard: $*" >&2
  exit 1
}

# Rule 1: every frame must contain FRAME_CONSTITUTION.md
missing=0
while IFS= read -r dir; do
  [ -z "$dir" ] && continue
  if [ ! -f "$dir/FRAME_CONSTITUTION.md" ]; then
    echo "ci_frame_guard: missing FRAME_CONSTITUTION.md in $dir" >&2
    missing=1
  fi
done < <(find frames -mindepth 1 -maxdepth 1 -type d -print)

if [ "$missing" -ne 0 ]; then
  exit 1
fi

# Rule 2: only allowed change under frames/*/ is adding FRAME_CONSTITUTION.md
while IFS=$'\t' read -r status path; do
  [ -z "${path:-}" ] && continue
  case "$path" in
    frames/*)
      if [[ "$path" =~ ^frames/[^/]+/FRAME_CONSTITUTION\.md$ ]] && [ "${status:0:1}" = "A" ]; then
        continue
      fi
      fail "unauthorized change under frames/: $status $path"
      ;;
    *)
      ;;
  esac
done < <(read_diff)

# Rule 3: authority paths require explicit acknowledgment marker in commit message
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
done < <(read_diff)

if [ "$authority_change" -eq 1 ]; then
  msg=$(git log -1 --pretty=%B)
  if [[ "$msg" != *"AUTHORITY_CHANGE_ACK"* ]]; then
    fail "authority path changed without AUTHORITY_CHANGE_ACK in commit message"
  fi
fi
