# Canonical Terminology Map

Snapshot date: 2026-02-08.

This map aligns frequently used ecosystem terms with their canonical source and downstream usage notes.

| Term | Canonical Source | Meaning (short) | Notes |
| --- | --- | --- | --- |
| `T81` | `t81-foundation/spec/` | Balanced-ternary native computing stack and ecosystem identity. | Use as umbrella name for stack + governance + repos. |
| `T81VM` / `HanoiVM` | `t81-foundation/spec/t81vm-spec.md`, `t81-vm` | Deterministic VM runtime and execution semantics. | Runtime contract artifact lives in `t81-vm/docs/contracts/vm-compatibility.json`. |
| `TISC` | `t81-foundation/spec/tisc-spec.md` | Ternary instruction set and opcode semantics. | Opcode-level changes require parity/compatibility updates downstream. |
| `Axion` | `t81-foundation/spec/axion-kernel.md` | Policy/safety semantics layer integrated with T81 execution model. | Do not redefine in interpretive docs without spec references. |
| `Runtime Contract` | `t81-vm/docs/contracts/vm-compatibility.json` | Machine-readable compatibility record for VM-facing repos. | Pins and compatibility notes must stay synchronized in `t81-lang` and `t81-python`. |
| `Formal (Normative)` | `t81-foundation/spec/`, `duotronic-whitepaper` | Documents that define required semantics/behavior. | Changes typically require RFC/spec process. |
| `Interpretive (Non-Normative)` | `t81-docs`, `duotronic-computing`, `t81-roadmap` | Explanatory or coordination documents. | Must defer to formal sources for semantics disputes. |

## Usage Rules

1. When introducing a new ecosystem term, add it here with source references.
2. When semantics are in dispute, prefer the canonical source in this table.
3. If a term crosses formal and interpretive layers, include both references and a clear ownership note.
