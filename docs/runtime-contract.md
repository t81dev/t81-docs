# Runtime Contract

This page tracks the runtime contract used by the migrated ecosystem boundary.

## Canonical Runtime Owner

- Repository: [`t81-vm`](https://github.com/t81dev/t81-vm)
- Contract artifact: `docs/contracts/vm-compatibility.json`
- Contract tag baseline: `runtime-contract-v0.1`

## Current Baseline Snapshot

- VM contract version date: `2026-02-08`
- Supported opcode count in contract: `39`
- P0 parity families now represented in `t81-vm` contract:
  - comparison ops (`Less`, `LessEqual`, `Greater`, `GreaterEqual`, `Equal`, `NotEqual`)
  - numeric conversion ops (`I2F`, `F2I`, `I2Frac`, `Frac2I`)

## Downstream Consumers

- `t81-lang` compatibility gate: `scripts/check-vm-compat.py`
- `t81-python` bridge and compatibility docs: `src/t81_python/vm_bridge.py`, `docs/compatibility.md`

## Change Policy

Contract-impacting changes require synchronized updates to:

1. `t81-vm` contract artifact and tag.
2. `t81-lang` compatibility matrix and CI gate.
3. `t81-python` ABI compatibility docs and bridge tests.
