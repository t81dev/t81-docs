# Runtime Contract

This page tracks the runtime contract used by the migrated ecosystem boundary.

## Canonical Runtime Owner

- Repository: [`t81-vm`](https://github.com/t81dev/t81-vm)
- Contract artifact: `docs/contracts/vm-compatibility.json`
- Contract tag baseline: `runtime-contract-v0.1`

## Downstream Consumers

- `t81-lang` compatibility gate: `scripts/check-vm-compat.py`
- `t81-python` bridge and compatibility docs: `src/t81_python/vm_bridge.py`, `docs/compatibility.md`

## Change Policy

Contract-impacting changes require synchronized updates to:

1. `t81-vm` contract artifact and tag.
2. `t81-lang` compatibility matrix and CI gate.
3. `t81-python` ABI compatibility docs and bridge tests.
