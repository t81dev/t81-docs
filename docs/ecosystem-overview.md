# Ecosystem Overview

This page groups the `t81dev` repositories into working domains so contributors can quickly understand where to add work.

## Core Platform

- [`t81-foundation`](https://github.com/t81dev/t81-foundation): T81 ecosystem core stack and reference implementation.
- [`t81-vm`](https://github.com/t81dev/t81-vm): deterministic HanoiVM runtime, trap semantics, and host ABI.
- [`t81-lang`](https://github.com/t81dev/t81-lang): language frontend and compiler ownership boundary.
- [`t81lib`](https://github.com/t81dev/t81lib): balanced-ternary quantization/arithmetic core.
- [`t81-python`](https://github.com/t81dev/t81-python): Python package layer and integrations.
- [`t81-examples`](https://github.com/t81dev/t81-examples): curated demos and usage examples.
- [`t81-benchmarks`](https://github.com/t81dev/t81-benchmarks): performance and accuracy comparisons.

## Specifications And Research

- [`duotronic-whitepaper`](https://github.com/t81dev/duotronic-whitepaper): formal proposal and semantics.
- [`duotronic-computing`](https://github.com/t81dev/duotronic-computing): interpretive and contextual materials.
- [`duotronic-thesis`](https://github.com/t81dev/duotronic-thesis): thesis repository.
- [`t81-constraints`](https://github.com/t81dev/t81-constraints): assumptions and failure boundaries.
- [`t81-roadmap`](https://github.com/t81dev/t81-roadmap): public vision and milestones.
- [`ternary-delta`](https://github.com/t81dev/ternary-delta): conceptual framing of ternary deltas.

## Model And Inference Work

- [`ternary`](https://github.com/t81dev/ternary): ternary quantization implementation.
- [`llama.cpp`](https://github.com/t81dev/llama.cpp): fork of `llama.cpp`.
- [`ANGELA`](https://github.com/t81dev/ANGELA): Python project (purpose to be documented).

## Hardware And Systems

- [`t81-hardware`](https://github.com/t81dev/t81-hardware): HDL, simulation, FPGA, and emulation direction.
- [`ternary-fabric`](https://github.com/t81dev/ternary-fabric): memory/interconnect co-processor work.
- [`ternary-memory-research`](https://github.com/t81dev/ternary-memory-research): memory-focused research repository.
- [`ternary-pager`](https://github.com/t81dev/ternary-pager): user-space pager experiments.
- [`ternary-tools`](https://github.com/t81dev/ternary-tools): balanced-ternary-aware tooling.
- [`ternary_gcc_plugin`](https://github.com/t81dev/ternary_gcc_plugin): GCC plugin and ABI integration.

## Security And Cryptography

- [`trinity`](https://github.com/t81dev/trinity): ternary-native cipher suite.
- [`trinity-decrypt`](https://github.com/t81dev/trinity-decrypt): decrypt-focused implementation.
- [`trinity-pow`](https://github.com/t81dev/trinity-pow): balanced-ternary PoW algorithm.

## Docs And Coordination

- [`t81-docs`](https://github.com/t81dev/t81-docs): central docs hub.
- Unified navigation skeleton: [`navigation.md`](navigation.md).
- Contributor journey map: [`contributor-journey.md`](contributor-journey.md).
- Runtime boundary reference: [`docs/runtime-contract.md`](runtime-contract.md).

## Migration State Note

- VM parity P0 slice is landed in `t81-vm` (comparison + numeric conversion opcode families).
- Cross-repo contract CI checks are currently green for `t81-vm`, `t81-lang`, `t81-python`, and `t81-docs`.

## Suggested Near-Term Expansion In `t81-docs`

1. Add one canonical architecture page per domain above.
2. Add cross-repo dependency diagrams and API boundary notes.
3. Add onboarding tracks for `research`, `core runtime`, `hardware`, and `crypto`.
4. Add status badges and release links per repository.
5. Add a cross-repo contract page tracking `t81-vm/docs/contracts/vm-compatibility.json`.
