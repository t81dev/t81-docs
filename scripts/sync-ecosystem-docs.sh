#!/usr/bin/env bash
set -euo pipefail

owner="${1:-t81dev}"

scripts/generate-repo-metadata.sh "$owner" docs/repos.json
scripts/validate-repo-metadata.sh docs/repos.json docs/repos.schema.json
scripts/generate-repo-pages.sh docs/repos.json docs/repos docs/repositories.md
scripts/generate-repo-inventory.sh "$owner" docs/repository-inventory.md
scripts/check-doc-links.sh docs

echo "Ecosystem docs synced for ${owner}"
