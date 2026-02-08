# Migration Guide: Binary-First to T81 Ecosystem

This guide is the practical path for teams moving from binary-first runtime/tooling
workflows into the T81 ecosystem.

## 1. Baseline Alignment

1. Identify the active runtime baseline:
   - `t81-vm` contract tag/version in `docs/runtime-contract.md`.
2. Pin to the current contract marker:
   - `contracts/runtime-contract.json` in each participating repo.
3. Confirm migration status:
   - `t81-roadmap/MIGRATION_STATUS.md`
   - `t81-roadmap/ECOSYSTEM_RELEASE_MANIFEST.json`

## 2. Artifact and Interface Mapping

Map your existing binary-first assets to T81 surfaces:

- runtime program format -> `TextV1` / `TiscJsonV1`
- host integration boundary -> `t81-vm` C ABI (`include/t81/vm/c_api.h`)
- compatibility checks -> `t81-lang` / `t81-python` contract gates

## 3. Verification Workflow

Use this minimum verification sequence:

1. Runtime contract validation in `t81-vm`.
2. Language compatibility check in `t81-lang`.
3. Python bridge contract check in `t81-python`.
4. Deterministic end-to-end fixture in `t81-examples`.

Promotion rule:

- do not claim migration completion unless all checks are green on the same baseline pin.

## 4. Evidence and Publication

For every migration slice, capture:

- commit SHAs
- workflow run URLs
- manifest contract version and VM pin
- known residual risks

Record evidence in:

- `t81-roadmap/MIGRATION_CHECKPOINTS.md`
- `t81-roadmap/releases/*.md` (for release cuts/promotions)

## 5. Common Failure Modes

1. Contract drift:
   local `contracts/runtime-contract.json` does not match `t81-vm` contract version.
2. Pin drift:
   pinned workflow lane points to old VM commit.
3. Partial evidence:
   checks pass locally but no CI evidence links are captured.

Mitigation:

- treat `MIGRATION_STATUS.md` as canonical health board and triage yellow/red immediately.
