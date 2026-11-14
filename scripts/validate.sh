#!/usr/bin/env bash
# Unified validation: content -> markdown lint -> hugo build -> link validation
set -euo pipefail

echo "=== Running full InfraDocs validation ==="

echo "1/4 Content validation..."
./scripts/validate-content.sh

echo "2/4 Markdown linting..."
if command -v markdownlint >/dev/null 2>&1; then
  markdownlint '**/*.md'
else
  echo "SKIP: markdownlint not installed (install with: npm install -g markdownlint-cli)"
fi

echo "3/4 Hugo build..."
hugo --gc --cleanDestinationDir --minify

echo "4/4 Link validation..."
./scripts/validate-links.sh

echo "=== All validation steps passed ==="
