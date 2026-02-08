# Contributor Journey Map

This map defines a progression from first contribution to advanced runtime and cross-repo work.

## Stage 1: First Contribution

Goal: make one low-risk docs or metadata change.

1. Read:
   - `docs/navigation.md`
   - `docs/maintenance.md`
2. Pick a docs task:
   - repository description cleanup,
   - broken link fix,
   - small runtime-contract wording correction.
3. Run local checks:
   - `./scripts/check-doc-links.sh .`
   - `python3 scripts/check-runtime-contract-sync.py`

## Stage 2: Cross-Repo Docs/Contract Sync

Goal: update docs with runtime baseline changes safely.

1. Read:
   - `docs/runtime-contract.md`
   - `docs/runtime-sync-status.md`
2. Coordinate with:
   - `t81-vm` contract changes,
   - `t81-roadmap` migration dashboard/report updates.
3. Verify docs sync gates are green in CI (`Docs Validate`).

## Stage 3: Runtime Integration Contributor

Goal: contribute to runtime contract migration work.

1. Follow tracker issues in `t81-roadmap` (`#14` and phase execution trackers).
2. Work across:
   - `t81-lang` compatibility matrix/workflows,
   - `t81-python` bridge compatibility docs/workflows,
   - `t81-vm` contract artifacts and parity evidence.
3. Ensure each change has:
   - contract/docs updates,
   - CI evidence links,
   - checkpoint entry in `t81-roadmap/MIGRATION_CHECKPOINTS.md`.

## Stage 4: Advanced Ownership

Goal: drive a full runtime contract promotion cycle.

1. Define scoped delta and acceptance criteria.
2. Land contract/validator/CI updates in `t81-vm`.
3. Fan out downstream pin/docs updates (`t81-lang`, `t81-python`, `t81-docs`).
4. Refresh `t81-roadmap` dashboard/runtime report/checkpoint and close tracker issue.
