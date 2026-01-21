#!/usr/bin/env bash
set -euo pipefail

# Reproducibility check for Policy Authority v0.1 (Terraform Level 2).

SNAPSHOT_PATH=${SNAPSHOT_PATH:-snapshots/terraform/snapshot_v0.1}
CLI=${CLI:-bin/policy-authority}
OUT_DIR=${OUT_DIR:-/tmp/policy-authority-repro}

run_case() {
  local target=$1
  local label=$2
  local expected_exit=$3
  mkdir -p "$OUT_DIR/$label"
  for i in 1 2 3; do
    set +e
    "$CLI" eval \
      --snapshot "$SNAPSHOT_PATH" \
      --target "$target" \
      --out "$OUT_DIR/$label/verdict_$i.json"
    status=$?
    set -e
    if [[ "$status" -ne "$expected_exit" ]]; then
      echo "unexpected exit code for $label run $i: got $status expected $expected_exit" >&2
      exit 1
    fi
  done
  diff "$OUT_DIR/$label/verdict_1.json" "$OUT_DIR/$label/verdict_2.json"
  diff "$OUT_DIR/$label/verdict_2.json" "$OUT_DIR/$label/verdict_3.json"
}

run_case "examples/target-repos/terraform-pass" "pass" 0
run_case "examples/target-repos/terraform-fail" "fail" 1

echo "Reproducibility check passed for PASS and FAIL cases."
