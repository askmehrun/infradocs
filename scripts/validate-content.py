#!/usr/bin/env python3
"""Validate InfraDocs content structure and front matter.

Recursively discovers all Markdown files under content/ and validates:
- Front matter presence
- Front matter well-formedness (YAML)
- Non-empty title
- Supported document types (when type is present)
- Boolean draft field (when present)
- Non-negative integer weight field (when present)

Returns non-zero exit code on any error.
"""

import os
import sys

try:
    import yaml
except ImportError:
    print("ERROR: PyYAML is required. Install with: pip install pyyaml")
    sys.exit(1)

CONTENT_DIR = "content"
VALID_TYPES = {"default", "infrastructure", "platform", "service", "runbook", "adr"}

errors = []


def find_markdown_files(root):
    """Recursively find all .md files under root."""
    matches = []
    for dirpath, _dirs, files in os.walk(root):
        for name in files:
            if name.endswith(".md"):
                matches.append(os.path.join(dirpath, name))
    return sorted(matches)


def parse_front_matter(path):
    """Return (front_matter_dict, body, error) for a Markdown file.

    error is a string if parsing failed, None otherwise.
    """
    with open(path, "r", encoding="utf-8") as f:
        lines = f.readlines()

    if not lines or lines[0].strip() != "---":
        return None, None, "missing front matter (file must start with ---)"

    # Find closing ---
    close_index = None
    for i in range(1, len(lines)):
        if lines[i].strip() == "---":
            close_index = i
            break

    if close_index is None:
        return None, None, "unclosed front matter (no closing ---)"

    fm_text = "".join(lines[1:close_index])
    body = "".join(lines[close_index + 1 :])

    try:
        data = yaml.safe_load(fm_text)
    except yaml.YAMLError as exc:
        return None, None, f"malformed YAML front matter: {exc}"

    if not isinstance(data, dict):
        return None, None, "front matter must be a YAML mapping"

    return data, body, None


def validate_file(path):
    data, body, error = parse_front_matter(path)
    if error:
        errors.append(f"{path}: {error}")
        return

    # Title required and non-empty
    title = data.get("title")
    if title is None or not str(title).strip():
        errors.append(f"{path}: missing or empty title")
        return

    # Type validation (when present)
    doc_type = data.get("type")
    if doc_type is not None and doc_type not in VALID_TYPES:
        errors.append(
            f"{path}: unknown document type '{doc_type}' (valid: {', '.join(sorted(VALID_TYPES))})"
        )

    # draft must be boolean (when present)
    draft = data.get("draft")
    if draft is not None and not isinstance(draft, bool):
        errors.append(f"{path}: 'draft' must be a boolean, got {type(draft).__name__}")

    # weight must be non-negative integer (when present)
    weight = data.get("weight")
    if weight is not None:
        if not isinstance(weight, int) or isinstance(weight, bool) or weight < 0:
            errors.append(
                f"{path}: 'weight' must be a non-negative integer, got {weight!r}"
            )


def main():
    if not os.path.isdir(CONTENT_DIR):
        print(f"ERROR: {CONTENT_DIR}/ directory not found")
        sys.exit(1)

    files = find_markdown_files(CONTENT_DIR)
    if not files:
        print(f"ERROR: no Markdown files found under {CONTENT_DIR}/")
        sys.exit(1)

    for path in files:
        validate_file(path)

    if errors:
        print(f"Content validation FAILED ({len(errors)} error(s)):")
        for err in errors:
            print(f"  {err}")
        sys.exit(1)

    print(f"Content validation passed ({len(files)} file(s) checked).")


if __name__ == "__main__":
    main()
