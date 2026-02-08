#!/usr/bin/env bash
set -euo pipefail

root="${1:-.}"

mapfile -t md_files < <(find "$root" -type f -name '*.md' | sort)

if [[ "${#md_files[@]}" -eq 0 ]]; then
  echo "No markdown files found under ${root}"
  exit 0
fi

fail=0

check_local_link() {
  local source_file="$1"
  local url="$2"
  local clean="${url%%#*}"

  [[ -z "$clean" ]] && return 0
  [[ "$clean" =~ ^mailto: ]] && return 0
  [[ "$clean" =~ ^https?:// ]] && return 0

  local base_dir
  base_dir="$(dirname "$source_file")"
  local target="${base_dir}/${clean}"

  if [[ ! -e "$target" ]]; then
    echo "Broken local link in ${source_file}: ${url}"
    fail=1
  fi
}

check_github_link() {
  local source_file="$1"
  local url="$2"
  if [[ "$url" =~ ^https://github\.com/ ]]; then
    local code
    code="$(curl -o /dev/null -L -s -w '%{http_code}' "$url" || true)"
    if [[ "$code" -ge 400 || "$code" -lt 200 ]]; then
      echo "Broken GitHub link in ${source_file}: ${url} (HTTP ${code})"
      fail=1
    fi
  fi
}

for file in "${md_files[@]}"; do
  while IFS= read -r match; do
    url="$(printf '%s' "$match" | sed -E 's/^[^]]*\]\(([^)]+)\)$/\1/')"
    check_local_link "$file" "$url"
    check_github_link "$file" "$url"
  done < <(grep -oE '\[[^]]+\]\(([^)]+)\)' "$file" || true)
done

if [[ "$fail" -ne 0 ]]; then
  exit 1
fi

echo "All checked markdown links are valid"
