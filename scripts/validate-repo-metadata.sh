#!/usr/bin/env bash
set -euo pipefail

repos_file="${1:-docs/repos.json}"
schema_file="${2:-docs/repos.schema.json}"

if [[ ! -f "$repos_file" ]]; then
  echo "Missing ${repos_file}"
  exit 1
fi

if [[ ! -f "$schema_file" ]]; then
  echo "Missing ${schema_file}"
  exit 1
fi

schema_json="$(cat "$schema_file")"

jq --argjson schema "$schema_json" '
  # Minimal schema validation for this repository shape.
  # We enforce required keys and primitive types without external tooling.
  def is_string_or_null: (. == null or (type == "string"));

  ($schema.items.required) as $required |
  if (type != "array") then
    error("repos.json must be an array")
  else
    .
    | to_entries[]
    | .key as $idx
    | .value as $row
    | if ($row | type != "object") then
        error("Entry \($idx): must be an object")
      elif (($required | all(. as $k | ($row | has($k)))) | not) then
        error("Entry \($idx): missing required keys")
      elif (($row.name | type) != "string") then
        error("Entry \($idx): name must be a string")
      elif (($row.full_name | type) != "string") then
        error("Entry \($idx): full_name must be a string")
      elif (($row.html_url | type) != "string") then
        error("Entry \($idx): html_url must be a string")
      elif (($row.description | is_string_or_null) | not) then
        error("Entry \($idx): description must be string|null")
      elif (($row.language | is_string_or_null) | not) then
        error("Entry \($idx): language must be string|null")
      elif (($row.fork | type) != "boolean") then
        error("Entry \($idx): fork must be boolean")
      elif (($row.archived | type) != "boolean") then
        error("Entry \($idx): archived must be boolean")
      elif (($row.default_branch | is_string_or_null) | not) then
        error("Entry \($idx): default_branch must be string|null")
      elif (($row.homepage | is_string_or_null) | not) then
        error("Entry \($idx): homepage must be string|null")
      elif (($row.topics | type) != "array") then
        error("Entry \($idx): topics must be array")
      elif (($row.topics | all(type == "string")) | not) then
        error("Entry \($idx): topics array must contain only strings")
      elif (($row.stargazers_count | type) != "number") then
        error("Entry \($idx): stargazers_count must be numeric")
      elif (($row.watchers_count | type) != "number") then
        error("Entry \($idx): watchers_count must be numeric")
      elif (($row.forks_count | type) != "number") then
        error("Entry \($idx): forks_count must be numeric")
      elif (($row.open_issues_count | type) != "number") then
        error("Entry \($idx): open_issues_count must be numeric")
      elif (($row.size | type) != "number") then
        error("Entry \($idx): size must be numeric")
      elif (($row.created_at | type) != "string") then
        error("Entry \($idx): created_at must be string")
      elif (($row.updated_at | type) != "string") then
        error("Entry \($idx): updated_at must be string")
      elif (($row.pushed_at | type) != "string") then
        error("Entry \($idx): pushed_at must be string")
      else
        empty
      end
  end
' "$repos_file" >/dev/null

echo "Validated ${repos_file} against expected schema shape"
