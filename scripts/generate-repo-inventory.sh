#!/usr/bin/env bash
set -euo pipefail

owner="${1:-t81dev}"
out_file="${2:-docs/repository-inventory.md}"
snapshot_date="$(date +%F)"

tmp_json="$(mktemp)"
trap 'rm -f "$tmp_json"' EXIT

curl -fsSL "https://api.github.com/users/${owner}/repos?per_page=100" > "$tmp_json"

{
  echo "# Repository Inventory"
  echo
  echo "Complete inventory of currently visible repositories under \`https://github.com/${owner}\`."
  echo
  echo "Snapshot date: \`${snapshot_date}\`."
  echo
  echo "## Table"
  echo
  echo "| Repository | Detail Page | Primary Language | Notes |"
  echo "| --- | --- | --- | --- |"
  jq -r '
    sort_by(.name | ascii_downcase)[] |
    [
      .name,
      (.language // "-"),
      (.description // "Description not set.")
    ] |
    @tsv
  ' "$tmp_json" | while IFS=$'\t' read -r name language description; do
    safe_desc="$(printf '%s' "$description" | tr '\n' ' ' | sed 's/|/\\|/g')"
    echo "| [\`${name}\`](https://github.com/${owner}/${name}) | [\`${name}\`](repos/${name}.md) | ${language} | ${safe_desc} |"
  done
} > "$out_file"

echo "Wrote ${out_file}"
