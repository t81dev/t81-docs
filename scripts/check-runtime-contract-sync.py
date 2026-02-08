#!/usr/bin/env python3
"""Validate docs runtime-contract page against canonical t81-vm contract."""

from __future__ import annotations

import json
import os
import subprocess
from pathlib import Path


def derive_contract_tag(abi_version: str) -> str:
    parts = abi_version.split(".")
    if len(parts) < 2 or not parts[0] or not parts[1]:
        raise SystemExit(f"Unexpected host ABI version format: {abi_version!r}")
    return f"runtime-contract-v{parts[0]}.{parts[1]}"


def main() -> None:
    root = Path(__file__).resolve().parent.parent
    vm_dir = Path(os.environ.get("T81_VM_DIR", str((root / "../t81-vm").resolve())))

    contract_path = vm_dir / "docs/contracts/vm-compatibility.json"
    docs_path = root / "docs/runtime-contract.md"

    if not contract_path.exists():
        raise SystemExit(f"Missing VM contract: {contract_path}")

    contract = json.loads(contract_path.read_text(encoding="utf-8"))
    runtime_page = docs_path.read_text(encoding="utf-8")

    runtime_owner = contract.get("runtime_owner")
    if runtime_owner != "t81-vm":
        raise SystemExit(f"Unexpected runtime owner in contract: {runtime_owner!r}")

    host_abi_version = str(contract.get("host_abi", {}).get("version", "")).strip()
    if not host_abi_version:
        raise SystemExit("host_abi.version missing in VM contract")

    contract_version = str(contract.get("contract_version", "")).strip()
    if not contract_version:
        raise SystemExit("contract_version missing in VM contract")

    vm_head = (
        subprocess.check_output(
            ["git", "-C", str(vm_dir), "rev-parse", "HEAD"], text=True
        )
        .strip()
    )
    active_runtime_tag = (
        subprocess.check_output(
            [
                "git",
                "-C",
                str(vm_dir),
                "tag",
                "--list",
                "runtime-contract-v*",
                "--sort=version:refname",
            ],
            text=True,
        )
        .strip()
        .splitlines()
    )
    latest_tag = active_runtime_tag[-1] if active_runtime_tag else ""
    baseline_commit = vm_head
    if latest_tag:
        baseline_commit = (
            subprocess.check_output(
                ["git", "-C", str(vm_dir), "rev-parse", f"{latest_tag}^{{}}"], text=True
            )
            .strip()
        )
    expected_pin_snippet = ""
    if latest_tag:
        expected_pin_snippet = f"VM contract commit pin (`t81-vm/main`): `{baseline_commit}`"

    expected_tag = derive_contract_tag(host_abi_version)
    required_snippets = [
        "Contract artifact: `docs/contracts/vm-compatibility.json`",
        "Repository: [`t81-vm`](https://github.com/t81dev/t81-vm)",
        f"Active tagged contract baseline: `{latest_tag}`" if latest_tag else "",
        expected_tag,
        f"VM contract version: `{contract_version}`",
        expected_pin_snippet,
        "`t81-lang` compatibility gate",
        "`t81-python` bridge and compatibility docs",
    ]

    missing = [snippet for snippet in required_snippets if snippet and snippet not in runtime_page]
    if missing:
        raise SystemExit(f"docs/runtime-contract.md missing expected entries: {missing}")

    print(f"runtime contract docs sync: ok (tag={expected_tag})")


if __name__ == "__main__":
    main()
