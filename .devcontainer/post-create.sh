#!/usr/bin/env bash
# BILA dev-environment bootstrap. Idempotent: safe to run more than once.
# Works inside the BILA devcontainer and inside a stock Codespace.
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")/.."

# 1) rustup, only if missing
if [ -f "$HOME/.cargo/env" ]; then . "$HOME/.cargo/env"; fi
if ! command -v rustup >/dev/null 2>&1; then
  echo "==> Installing rustup"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --profile minimal --default-toolchain none
  . "$HOME/.cargo/env"
fi

# 2) Pinned toolchain (single source of truth: rust-toolchain.toml)
CHANNEL="$(sed -n 's/^channel *= *"\(.*\)"/\1/p' rust-toolchain.toml)"
echo "==> Installing Rust ${CHANNEL} with the wasm32-unknown-unknown target"
rustup toolchain install "${CHANNEL}" --profile minimal \
  --component rustfmt --component clippy \
  --target wasm32-unknown-unknown

# 3) cargo-near: official prebuilt installer (from the near-sdk README)
if ! command -v cargo-near >/dev/null 2>&1; then
  echo "==> Installing cargo-near"
  curl --proto '=https' --tlsv1.2 -LsSf \
    https://github.com/near/cargo-near/releases/latest/download/cargo-near-installer.sh | sh
fi

echo
echo "==> Versions"
rustc --version
cargo --version
if command -v cargo-near >/dev/null 2>&1; then echo "cargo-near: installed"; else echo "cargo-near: not on PATH yet (open a new terminal and retry)"; fi
echo
echo "Next: cd contracts/bila-core && cargo test"
