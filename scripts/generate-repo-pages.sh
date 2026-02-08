#!/usr/bin/env bash
set -euo pipefail

repos_file="${1:-docs/repos.json}"
out_dir="${2:-docs/repos}"
index_file="${3:-docs/repositories.md}"

if [[ ! -f "$repos_file" ]]; then
  echo "Missing ${repos_file}. Run scripts/generate-repo-metadata.sh first."
  exit 1
fi

mkdir -p "$out_dir"

snapshot_date="$(date +%F)"
repo_names="$(jq -r '.[].name' "$repos_file")"

resolve_repo_alias() {
  local dep_name="$1"
  case "$dep_name" in
    duotroic-whitepaper) echo "duotronic-whitepaper" ;;
    t81-foundation-core) echo "t81-foundation" ;;
    *) echo "$dep_name" ;;
  esac
}

tmp_index="$(mktemp)"
trap 'rm -f "$tmp_index"' EXIT

{
  echo "# Repository Pages"
  echo
  echo "Generated index of per-repository documentation pages."
  echo
  echo "Snapshot date: \`${snapshot_date}\`."
  echo
  echo "## Table"
  echo
  echo "| Repository | Detail Page | Primary Language | Last Push (UTC) |"
  echo "| --- | --- | --- | --- |"
} > "$tmp_index"

jq -r '.[] | @base64' "$repos_file" | while IFS= read -r row; do
  json="$(printf '%s' "$row" | base64 --decode)"

  name="$(printf '%s' "$json" | jq -r '.name')"
  repo_url="$(printf '%s' "$json" | jq -r '.html_url')"
  desc="$(printf '%s' "$json" | jq -r '.description // "Description not set."')"
  lang="$(printf '%s' "$json" | jq -r '.language // "-"')"
  fork="$(printf '%s' "$json" | jq -r '.fork')"
  archived="$(printf '%s' "$json" | jq -r '.archived')"
  default_branch="$(printf '%s' "$json" | jq -r '.default_branch // "main"')"
  homepage="$(printf '%s' "$json" | jq -r '.homepage // ""')"
  pushed_at="$(printf '%s' "$json" | jq -r '.pushed_at // "-"')"
  created_at="$(printf '%s' "$json" | jq -r '.created_at // "-"')"
  updated_at="$(printf '%s' "$json" | jq -r '.updated_at // "-"')"
  stars="$(printf '%s' "$json" | jq -r '.stargazers_count // 0')"
  forks_count="$(printf '%s' "$json" | jq -r '.forks_count // 0')"
  issues="$(printf '%s' "$json" | jq -r '.open_issues_count // 0')"
  topics="$(printf '%s' "$json" | jq -r 'if (.topics | length) == 0 then "-" else (.topics | join(", ")) end')"

  dep_refs="$(printf '%s' "$desc" | grep -oE 't81dev/[A-Za-z0-9._-]+' | sed -E 's/[[:punct:]]$//' | sort -u || true)"

  status="active"
  if [[ "$archived" == "true" ]]; then
    status="archived"
  elif [[ "$fork" == "true" ]]; then
    status="fork"
  fi

  out_file="${out_dir}/${name}.md"
  {
    echo "# ${name}"
    echo
    echo "- Repository: [\`${name}\`](${repo_url})"
    echo "- Status: \`${status}\`"
    echo "- Primary language: \`${lang}\`"
    echo "- Default branch: \`${default_branch}\`"
    echo "- Last push (UTC): \`${pushed_at}\`"
    echo "- Created (UTC): \`${created_at}\`"
    echo "- Last updated (UTC): \`${updated_at}\`"
    echo
    echo "## Summary"
    echo
    echo "${desc}"
    echo
    echo "## Signals"
    echo
    echo "- Stars: \`${stars}\`"
    echo "- Forks: \`${forks_count}\`"
    echo "- Open issues: \`${issues}\`"
    echo "- Topics: ${topics}"
    if [[ -n "$homepage" ]]; then
      echo "- Homepage: ${homepage}"
    fi
    echo
    echo "## Known Dependencies"
    echo
    if [[ -n "$dep_refs" ]]; then
      while IFS= read -r dep; do
        dep_name="${dep#t81dev/}"
        dep_name="$(resolve_repo_alias "$dep_name")"
        echo "- [\`${dep}\`](https://github.com/${dep})"
        if printf '%s\n' "$repo_names" | grep -Fxq "$dep_name"; then
          echo "See also: [\`${dep_name}\`](${dep_name}.md)"
        else
          echo "See also: unresolved local page for \`${dep_name}\`"
        fi
      done <<< "$dep_refs"
    else
      echo "- No explicit cross-repository dependency references were detected in metadata."
    fi
  } > "$out_file"

  echo "| [\`${name}\`](${repo_url}) | [\`${name}\`](repos/${name}.md) | ${lang} | \`${pushed_at}\` |" >> "$tmp_index"
done

mv "$tmp_index" "$index_file"
echo "Wrote ${index_file}"
echo "Wrote ${out_dir}/*.md"
