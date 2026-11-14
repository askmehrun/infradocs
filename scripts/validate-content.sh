#!/usr/bin/env bash
# Validate InfraDocs content structure and front matter
set -euo pipefail

echo "Validating InfraDocs content..."

# Check all markdown files have valid front matter
for f in content/**/*.md; do
  [ -f "$f" ] || continue
  if ! head -1 "$f" | grep -q '^---$'; then
    echo "ERROR: Missing front matter in $f"
    exit 1
  fi
done

echo "Content validation passed."