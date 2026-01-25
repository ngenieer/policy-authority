#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(git rev-parse --show-toplevel)"
cd "$ROOT_DIR"

CONSTITUTION_YML="authority/spec/authority.constitution.yml"
CONSTITUTION_SCHEMA="authority/spec/authority.constitution.schema.json"
MAPPING_SCHEMA="authority/spec/frame.authority.mapping.schema.json"

fail() { echo "ci_authority_spec_guard: FAIL: $*" >&2; exit 1; }
info() { echo "ci_authority_spec_guard: INFO: $*" >&2; }
ok()   { echo "ci_authority_spec_guard: OK: $*" >&2; }

[ -f "$CONSTITUTION_YML" ] || fail "missing $CONSTITUTION_YML"
[ -f "$CONSTITUTION_SCHEMA" ] || fail "missing $CONSTITUTION_SCHEMA"
[ -f "$MAPPING_SCHEMA" ] || fail "missing $MAPPING_SCHEMA"

python - <<'PY'
import json, sys
from pathlib import Path

try:
  import yaml
except Exception:
  raise SystemExit("ci_authority_spec_guard: FAIL: PyYAML is required (pip install pyyaml).")

try:
  import jsonschema
except Exception:
  raise SystemExit("ci_authority_spec_guard: FAIL: jsonschema is required (pip install jsonschema).")

root = Path.cwd()

def load_yaml(p: Path):
  return yaml.safe_load(p.read_text(encoding="utf-8"))

def load_json(p: Path):
  return json.loads(p.read_text(encoding="utf-8"))

def validate(instance, schema, where: str):
  try:
    jsonschema.validate(instance=instance, schema=schema)
  except jsonschema.ValidationError as e:
    print(f"ci_authority_spec_guard: FAIL: schema validation failed: {where}", file=sys.stderr)
    print(f"  message: {e.message}", file=sys.stderr)
    if e.absolute_path:
      print("  at: " + "/".join(map(str, e.absolute_path)), file=sys.stderr)
    raise SystemExit(1)

constitution_yml = root / "authority/spec/authority.constitution.yml"
constitution_schema = root / "authority/spec/authority.constitution.schema.json"
mapping_schema_path = root / "authority/spec/frame.authority.mapping.schema.json"

constitution = load_yaml(constitution_yml)
schema = load_json(constitution_schema)
validate(constitution, schema, "authority/spec/authority.constitution.yml")

status = constitution.get("status")
auth_id = (constitution.get("identity") or {}).get("authority_id")
if status in ("stable", "frozen") and not auth_id:
  raise SystemExit("ci_authority_spec_guard: FAIL: status is stable/frozen but identity.authority_id is null/empty")

mapping_schema = load_json(mapping_schema_path)

frames_dir = root / "frames"
if not frames_dir.exists():
  print("ci_authority_spec_guard: INFO: frames/ not found; skipping frame mapping checks.", file=sys.stderr)
  raise SystemExit(0)

errors = 0
for frame_dir in sorted([p for p in frames_dir.iterdir() if p.is_dir()]):
  mapping_file = frame_dir / "authority.mapping.yml"
  if not mapping_file.exists():
    print(f"ci_authority_spec_guard: FAIL: missing mapping: {mapping_file}", file=sys.stderr)
    errors += 1
    continue

  m = load_yaml(mapping_file)
  validate(m, mapping_schema, str(mapping_file))

  a = m.get("authority") or {}
  if a.get("constitution_version") != "authority.constitution/v0.1":
    print(f"ci_authority_spec_guard: FAIL: {mapping_file}: authority.constitution_version must be authority.constitution/v0.1", file=sys.stderr)
    errors += 1

  if auth_id:
    if not a.get("authority_id"):
      print(f"ci_authority_spec_guard: FAIL: {mapping_file}: authority.authority_id must be set when constitution has authority_id", file=sys.stderr)
      errors += 1
    elif a.get("authority_id") != auth_id:
      print(f"ci_authority_spec_guard: FAIL: {mapping_file}: authority.authority_id mismatch (expected {auth_id})", file=sys.stderr)
      errors += 1

if errors:
  raise SystemExit(1)

print("ci_authority_spec_guard: OK: passed", file=sys.stderr)
PY

ok "passed"