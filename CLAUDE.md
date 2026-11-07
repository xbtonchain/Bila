# BILA: instructions for AI coding sessions

BILA is financial governance and settlement for AI agents on NEAR. Tagline: Your agents. Your money. Your rules.
Hackathon: NEAR HACKATHON. Development ends 2026-11-14 23:59 UTC. Tracks: `security`, `agents`.
Read first: `docs/PROGRESS.md` (state and next task), `docs/DECISIONS.md` (design), `README.md` (public face).

## Non-negotiables

1. The `bila-core` contract is the only financial authority. The MCP server, policy engine, backend and any database may be wrong or compromised without breaking the limits.
2. Integer yoctoNEAR (`u128`) only. No floats. Checked arithmetic. No USD or price oracle in the MVP.
3. Reserve at approval (against every limit, atomically), settle in a callback, release on definitive failure. Idempotent by request id.
4. UTC periods derived from `block_timestamp`: calendar day, Monday to Sunday week, calendar month. No cron.
5. Agents can never change their own limits, withdraw funds, resume themselves, or act while paused or revoked. There is no model-callable authorize or settle tool.
6. Guarantee boundary: only funds held by BILA. Never claim more.
7. No secrets in the repo, logs, frontend or chat. Testnet only unless the owner explicitly says otherwise.

## Working rules

- Never claim something was compiled, tested, deployed or posted unless you ran it and saw the result. Report real output.
- Do not force-push, make the repo public, post to X, submit the hackathon form, sign transactions, or deploy to mainnet without the owner's explicit confirmation in the current session.
- Small, tested commits. At the end of every session update `docs/PROGRESS.md` (verification ledger, blockers, next task).
- Verify SDK and package names and versions against official docs before using them. Rust is pinned in `rust-toolchain.toml`; near-sdk is 5.30.
- The README is read by an AI screener first: keep "do X, see Y" steps accurate, no marketing, nothing unimplemented described as done.
- Brand: `apps/dashboard/public/brand/bila-logo-official.jpeg` is official. Never redraw, recolour or crop it. `bash scripts/check-brand.sh` must pass.

## Commands

- Contract tests: `cd contracts/bila-core && cargo test`
- Wasm build: `cd contracts/bila-core && cargo near build non-reproducible-wasm --no-abi`
- Brand check: `bash scripts/check-brand.sh`
