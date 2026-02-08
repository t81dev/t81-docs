# Maintenance Workflow

Use this workflow to keep docs synchronized with `https://github.com/t81dev`.

## One-Command Sync

```bash
./scripts/sync-ecosystem-docs.sh t81dev
```

This command regenerates:

- `docs/repos.json`
- `docs/repositories.md`
- `docs/repos/*.md`
- `docs/repository-inventory.md`

## Script Breakdown

- `scripts/generate-repo-metadata.sh`: fetches and normalizes GitHub repository metadata.
- `scripts/generate-repo-pages.sh`: generates one documentation page per repository and a page index.
- `scripts/generate-repo-inventory.sh`: generates the compact inventory table.
- `scripts/validate-repo-metadata.sh`: validates `docs/repos.json` structure against expected schema shape.
- `scripts/check-doc-links.sh`: validates local markdown links and GitHub URLs.

## CI And Automation

- `.github/workflows/docs-validate.yml`
Validates metadata shape and markdown links on pull requests and pushes to `main`.

- `.github/workflows/docs-sync.yml`
Runs every Monday at `09:00 UTC` and on manual dispatch, then opens a PR with generated diffs.

## Suggested Cadence

1. Run sync before major docs updates.
2. Run sync before cutting releases or milestones.
3. Run sync when repositories are created, renamed, archived, or transferred.
