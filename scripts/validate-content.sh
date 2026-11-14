#!/usr/bin/env bash
# Validate InfraDocs content structure and front matter
set -euo pipefail

echo "Validating InfraDocs content..."

python3 scripts/validate-content.py
