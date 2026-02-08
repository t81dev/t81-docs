#!/usr/bin/env bash
set -euo pipefail

owner="${1:-t81dev}"
out_file="${2:-docs/repos.json}"

mkdir -p "$(dirname "$out_file")"

curl -fsSL "https://api.github.com/users/${owner}/repos?per_page=100" \
  | jq '
      sort_by(.name | ascii_downcase)
      | map({
          name,
          full_name,
          html_url,
          description,
          language,
          fork,
          archived,
          default_branch,
          homepage,
          topics,
          stargazers_count,
          watchers_count,
          forks_count,
          open_issues_count,
          size,
          created_at,
          updated_at,
          pushed_at
        })
    ' > "$out_file"

echo "Wrote ${out_file}"
