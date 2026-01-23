#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(git rev-parse --show-toplevel)"
SEALED_FILES_YML="${ROOT_DIR}/authority/SEALED_FILES.yml"
SEALED_HASHES_YML="${ROOT_DIR}/authority/SEALED_HASHES.yml"

if [[ ! -f "$SEALED_FILES_YML" ]]; then
  echo "[FAIL] Missing: authority/SEALED_FILES.yml" >&2
  exit 1
fi

# Simple YAML parser for this very limited file:
# Extract lines that look like "  - path"
mapfile -t FILES < <(grep -E '^\s*-\s+' "$SEALED_FILES_YML" | sed -E 's/^\s*-\s+//')

if [[ ${#FILES[@]} -eq 0 ]]; then
  echo "[FAIL] No sealed files found in authority/SEALED_FILES.yml" >&2
  exit 1
fi

tmp="$(mktemp)"
{
  echo "# authority/SEALED_HASHES.yml"
  echo "# Auto-generated. Do not edit manually."
  echo "sealed_hashes:"
} > "$tmp"

for rel in "${FILES[@]}"; do
  abs="${ROOT_DIR}/${rel}"
  if [[ ! -f "$abs" ]]; then
    echo "[FAIL] Sealed file not found: ${rel}" >&2
    rm -f "$tmp"
    exit 1
  fi
  hash="$(sha256sum "$abs" | awk '{print $1}')"
  printf "  %s: %s\n" "$rel" "$hash" >> "$tmp"
done

mv "$tmp" "$SEALED_HASHES_YML"
echo "[OK] Wrote: authority/SEALED_HASHES.yml"
