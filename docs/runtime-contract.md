# Runtime Contract

This page tracks the runtime contract used by the migrated ecosystem boundary.

## Canonical Runtime Owner

- Repository: [`t81-vm`](https://github.com/t81dev/t81-vm)
- Contract artifact: `docs/contracts/vm-compatibility.json`
- Active tagged contract baseline: `runtime-contract-v0.2`
- `runtime-contract-v0.2` status: tagged and active
- Host ABI-derived compatibility tag reference: `runtime-contract-v0.1`

## Current Baseline Snapshot

- VM contract version: `2026-02-08-v2`
- VM contract commit pin (`t81-vm/main`): `578864456f409bb54c195319663f2b7351a830f9`
- Supported opcode count in contract: `81`
- Parity status: full opcode parity and VM conformance parity with `t81-foundation` (`81/81` opcodes, `13/13` `vm*_test.cpp` classes).

## Downstream Consumers

- `t81-lang` compatibility gate: `scripts/check-vm-compat.py`
- `t81-python` bridge and compatibility docs: `src/t81_python/vm_bridge.py`, `docs/compatibility.md`

## Change Policy

Contract-impacting changes require synchronized updates to:

1. `t81-vm` contract artifact and tag.
2. `t81-lang` compatibility matrix and CI gate.
3. `t81-python` ABI compatibility docs and bridge tests.
