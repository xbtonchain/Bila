# BILA

**Your agents. Your money. Your rules.**

BILA is financial governance and payment settlement for AI agents on NEAR. An owner funds a restricted treasury, registers an agent, and sets its spending policy: a per-transaction cap, daily, weekly and monthly limits, and an optional list of approved recipients. A NEAR smart contract (`bila-core`) enforces the policy on-chain, independently of the AI model, the MCP server, or any backend.

NEAR HACKATHON tracks: AI Security & Defense (`security`) and Agent Economy (`agents`).

## Guarantee boundary

BILA enforces limits over funds held in the BILA treasury contract and over payments routed through it. It cannot restrict money an agent can reach through any other wallet or account.

## Current status: Milestone 1 (foundation)

Only items marked "exists" are implemented. Everything else is planned and is not claimed.

| Component | State |
| --- | --- |
| Repository, dev container, CI | exists (first CI run pending) |
| `bila-core` contract skeleton (`new`, `get_owner`, `version`, 2 unit tests) | exists, not yet compiled on a real toolchain |
| Agent registry, policies, restricted treasury, atomic reservations | planned (M2) |
| Payment settlement, callbacks, idempotency, failure release | planned (M3) |
| MCP server and policy engine | planned (M4) |
| Dashboard | planned (M5) |

Verification status: none of the commands below has been run on a real Rust toolchain yet. This section is updated after the first green CI run.

## Try it (funds-free: no keys, no wallet)

Requirements: Rust 1.95.0 (pinned in `rust-toolchain.toml`; rustup installs it), the `wasm32-unknown-unknown` target, and [cargo-near](https://github.com/near/cargo-near). In a GitHub Codespace, `bash .devcontainer/post-create.sh` installs all of this.

1. Run the contract unit tests:

   ```bash
   cd contracts/bila-core && cargo test
   ```

   Expected: 2 tests pass.

2. Build the contract to wasm:

   ```bash
   cd contracts/bila-core && cargo near build non-reproducible-wasm --no-abi
   ```

   Expected: a `bila_core.wasm` file under `contracts/bila-core/target/`.

3. Check that the official logo is unmodified:

   ```bash
   bash scripts/check-brand.sh
   ```

   Expected: `OK: official logo is unchanged.`

## Repository layout

```
contracts/bila-core/   NEAR smart contract (Rust)
apps/dashboard/        Dashboard (planned); official logo in public/brand
apps/api/              API (planned)
packages/              mcp-server, policy-engine, near-client, shared (planned)
docs/                  PROGRESS.md (state), DECISIONS.md (design), BRAND.md
scripts/               check-brand.sh
.devcontainer/         Dev container / Codespaces setup
.github/workflows/     CI
```

## Built with

- near-sdk 5.30 (Rust SDK for NEAR contracts) and cargo-near for builds
- GitHub Actions for CI
- AI-assisted development: this project is built with an AI coding assistant (Claude). Behaviour is verified by the automated tests and CI in this repository, not by trust in the assistant.

## License

MIT. See `LICENSE`.
