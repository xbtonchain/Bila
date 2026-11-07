# BILA progress log

Last updated: 2026-11-06 (Milestone 1 bootstrap prepared; not yet run on a real Rust toolchain).

## Deadline

Development ends **2026-11-14 23:59 UTC** (judging from 2026-11-16, results by 2026-11-18). Internal target: submit by the end of 2026-11-13. 2026-11-14 is buffer only.

## Milestones

| # | Target (UTC) | Scope and exit criteria | Status |
| --- | --- | --- | --- |
| M1 | Nov 6 | Foundation. Codespace builds, `cargo test` passes, wasm builds with cargo-near, CI green, brand check passes. | Bundle prepared; waiting for the first real run |
| M2 | Nov 7-8 | Enforcement core in `bila-core`: agent registry (register, pause, resume, revoke), policies, restricted treasury (deposit, allocate, withdraw unreserved), UTC period math, atomic reservations. Mandatory tests 1-10, 13, 14. | Not started |
| M3 | Nov 9 | Settlement: transfer by promise, `#[private]` callback, idempotency, failure release, receipts. Sandbox integration tests incl. mandatory tests 11-12. First testnet deploy. | Not started |
| M4 | Nov 10 | MCP server and policy engine: authenticated, scoped tools; connect Claude. | Not started |
| M5 | Nov 10-11 | Dashboard: Overview, Agents, Transactions, Treasury, Security and settings. | Not started |
| M6 | Nov 12 | End-to-end testnet rehearsal and security pass. | Not started |
| M7 | Nov 13 | README for the AI screener, architecture diagram, demo video, X post, repo public, submit. | Not started |

**Cut line if we slip** (in this order): no Postgres (chain-first, ADR-007); read-only Security screen; fewer dashboard charts. Never cut: atomic reservation, failure release, the 14 mandatory tests, README accuracy.

## Verification ledger

What has actually been run, and where. Nothing is marked verified unless it was executed and the result observed.

| Item | How | Result |
| --- | --- | --- |
| Logo copy is byte-identical to the upload | `cmp` and SHA-256 in the Claude sandbox, 2026-11-06 | Verified |
| `scripts/check-brand.sh` passes, and fails when the logo is altered | Run in the sandbox, positive and negative test | Verified |
| `devcontainer.json` is valid JSON; `Cargo.toml` and `rust-toolchain.toml` parse as TOML; shell scripts pass `bash -n`; `ci.yml` parses as YAML | Parsed in the sandbox | Verified (syntax only) |
| Palette contrast ratios in `docs/BRAND.md` | Computed with the WCAG formula | Verified |
| `cargo test` passes | Not run: the sandbox has no Rust toolchain and no network | **Not verified** |
| Contract skeleton compiles; wasm build works | Not run (same reason) | **Not verified** |
| `post-create.sh` works end to end; dev container builds | Not run (same reason) | **Not verified** |
| CI run is green | Not run yet | **Not verified** |

Facts checked against sources on 2026-11-05 (re-check before relying on them):

- near-sdk 5.30.0 released 2026-10-27; its README declares minimum Rust 1.95: https://docs.rs/near-sdk and https://github.com/near/near-sdk-rs
- cargo-near installer command and `cargo near build non-reproducible-wasm --no-abi`: near-sdk README (above)
- near.org public RPC endpoints are deprecated; use a listed provider: https://docs.near.org/api/rpc/providers
- Hackathon rules and form fields: https://nearhackathon.com/HACKATHON.md
- Codespaces free plan: 120 core-hours and 15 GB-month per month for personal accounts: https://docs.github.com/en/billing/concepts/product-billing/github-codespaces

## Hackathon submission checklist

From HACKATHON.md (fetched 2026-11-05; re-read the live file before submitting, rules may change):

- [ ] Repository public before 2026-11-14 23:59 UTC. Judges cannot open a private repository.
- [ ] `LICENSE` present (done: MIT).
- [ ] README written for a machine reader first: what it is, the problem, and accurate "do X, see Y" steps. No marketing. Claude Code and Codex screen every project before the human judges.
- [ ] README lists libraries, templates and AI-generated code (started under "Built with").
- [ ] Demo **video** if the demo is local-only (screenshots are not enough when judges cannot open the demo). A hosted demo is a plus; keep it up to 2026-11-18, ideally 2026-11-25.
- [ ] Public X post: says the project was built at NEAR HACKATHON, tags @NEARProtocol and #NEARHackathon, has the video or screenshots attached. The owner posts it.
- [ ] Submission form: project name, team lead, email, team size, tracks (`security`, `agents`), a **mainnet** NEAR account for any prize payout, repository link, demo post link, description of 20 to 2,000 characters. The owner confirms the exact payload before it is sent.

## Owner actions (manual, cannot be done by the assistant)

- Create the GitHub repository and open a Codespace (M1 steps).
- Create a testnet dev account with `cargo near create-dev-account` and approve wallet connections (M3 onward). Never paste keys or seed phrases into chat.
- Create a mainnet NEAR account for the prize payout (before M7).
- Record the demo video, publish the X post, make the repository public, and submit the form (M7).

## Decisions needed from the owner

1. Confirm ADR-007 (chain-first, no Postgres in the critical path) before M5.
2. Send an original vector or large PNG of the logo if one exists (see `docs/BRAND.md`).

## Blockers

- The assistant's sandbox has no Rust toolchain and no network, so compiling, testing and deploying happen in a Codespace and in CI. Until a result is relayed or visible in CI, it is not verified.

## Next task

Get M1 green: run the Codespace steps, then read the first CI run and fix whatever it reveals.
