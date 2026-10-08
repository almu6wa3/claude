#!/bin/bash
# Ensures Python and MarkItDown are available in every Claude Code session.
set -euo pipefail

if ! command -v python3 >/dev/null 2>&1; then
  echo "python3 not found; installing..." >&2
  if command -v apt-get >/dev/null 2>&1; then
    apt-get update -qq && apt-get install -y -qq python3 python3-pip >/dev/null
  else
    echo "Cannot install python3 automatically on this system." >&2
    exit 1
  fi
fi

if ! command -v markitdown >/dev/null 2>&1; then
  echo "Installing MarkItDown..." >&2
  python3 -m pip install --quiet --disable-pip-version-check 'markitdown[all]' \
    || python3 -m pip install --quiet --disable-pip-version-check --break-system-packages 'markitdown[all]'
fi

markitdown --version >/dev/null 2>&1 || true
echo "MarkItDown ready: $(python3 -m pip show markitdown 2>/dev/null | awk '/^Version/{print $2}')"
