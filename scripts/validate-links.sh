#!/usr/bin/env bash
# Validate internal links in generated HTML
set -euo pipefail

echo "Validating internal links..."

# Build the site first
hugo --gc --minify

FAIL=0

for f in public/**/*.html; do
  [ -f "$f" ] || continue

  while IFS= read -r href; do
    [ -n "$href" ] || continue

    # Skip external links, fragments, and placeholder URLs
    if [[ "$href" == http://* || "$href" == https://* || "$href" == mailto:* || "$href" == tel:* || "$href" == "#"* || "$href" == *"<"* || "$href" == *">"* ]]; then
      continue
    fi

    # Strip fragment and query for file existence check
    target="${href%%#*}"
    target="${target%%\?*}"

    # Root-relative link: resolve against public/
    if [[ "$target" == /* ]]; then
      target_path="public${target}"
      # Default to index.html for directory URLs
      if [[ "$target" == */ ]]; then
        target_path="${target_path}index.html"
      elif [ ! -f "$target_path" ] && [ -d "public${target}" ]; then
        target_path="public${target}/index.html"
      fi
      if [ ! -f "$target_path" ]; then
        echo "ERROR: Broken link in $f -> $href (target not found: $target_path)"
        FAIL=1
      fi
    else
      # Relative link: resolve against the linking file's directory
      link_dir="$(dirname "$f")"
      target_path="$link_dir/$target"
      # Default to index.html for directory URLs
      if [[ "$target" == */ ]]; then
        target_path="${target_path}index.html"
      elif [ ! -f "$target_path" ] && [ -d "$target_path" ]; then
        target_path="$target_path/index.html"
      fi
      if [ ! -f "$target_path" ]; then
        echo "ERROR: Broken link in $f -> $href (target not found: $target_path)"
        FAIL=1
      fi
    fi
  done < <(grep -oE 'href="[^"]*"' "$f" | sed 's/href="//;s/"$//')
done

if [ "$FAIL" -ne 0 ]; then
  echo "Link validation FAILED."
  exit 1
fi

echo "Link validation passed."
