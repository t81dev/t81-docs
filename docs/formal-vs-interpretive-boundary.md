# Formal vs Interpretive Source-of-Truth Boundary

This page defines where contributors should make authoritative changes vs explanatory changes.

## Canonical Formal Sources

Use these repositories as normative authority:

- `t81-foundation/spec/`: normative language, VM, ISA, and semantics definitions.
- `duotronic-whitepaper`: formal proposal-level semantics and architecture intent.
- `t81-vm/docs/contracts/vm-compatibility.json`: executable runtime compatibility contract for downstream consumers.

If text in interpretive documents conflicts with any source above, treat the formal source as correct and open a correction issue in the interpretive repo.

## Interpretive Sources

These repositories are explanatory, contextual, or onboarding-focused:

- `t81-docs`: navigation, ecosystem onboarding, compatibility guidance summaries.
- `duotronic-computing`: contextual framing and explanatory material.
- `t81-roadmap`: strategy, sequencing, and cross-repo execution tracking.

Interpretive docs must link to the relevant formal source when making contract or semantics claims.

## Change Routing Rules

1. Semantics changes:
   open or update RFC/spec work in `t81-foundation` (and related formal repo if needed).
2. Runtime ABI/contract changes:
   land in `t81-vm` contract artifacts first, then sync downstream docs (`t81-lang`, `t81-python`, `t81-docs`, `t81-roadmap`).
3. Terminology updates:
   update `docs/terminology-map.md` in `t81-docs` and linked glossary references in formal sources.
4. Explanatory rewrites:
   stay in interpretive repos unless formal meaning is changed.

## Escalation

If a proposed docs change may alter formal meaning, pause and escalate to an RFC/spec issue before merging.
