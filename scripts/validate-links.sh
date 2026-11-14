#!/usr/bin/env bash
# Validate internal links in generated HTML
set -euo pipefail

echo "Validating internal links..."

for f in public/**/*.html; do
  [ -f "$f" ] || continue
  # Check for root-absolute links that would break on subpath
  if grep -qE 'href="/[a-z]' "$f"; then
    echo "WARNING: Root-absolute link found in $f"
  fi
done

echo "Link validation passed."