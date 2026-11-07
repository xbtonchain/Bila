# Design decisions

Status: **Decided** (in force), **Proposed** (my recommendation; reverse it if you disagree), **Open** (to resolve at the milestone shown).

## ADR-001: The contract is the only financial authority (Decided)

`bila-core` enforces registration, activation, recipient rules, per-transaction cap, daily/weekly/monthly limits and treasury balances. The MCP server, policy engine, backend and database are conveniences: they can be wrong, down or compromised without allowing an overspend. The MCP server never holds withdrawal authority.

## ADR-002: Units (Decided)

NEAR-native funds. All amounts are `u128` yoctoNEAR with checked arithmetic. Limits are denominated in NEAR. No USD limits and no price oracle in the MVP; adding one needs a trusted source plus stale-price protection and is out of scope.

## ADR-003: Budget periods (Decided)

Derived from `env::block_timestamp()` (nanoseconds since the Unix epoch), never from cron.

- Day id = `timestamp_ns / 86_400_000_000_000`.
- Week (Monday to Sunday): 1970-01-01 was a Thursday, so with Monday = 0 the weekday of day `d` is `(d + 3) mod 7` and the week starts on day `d - ((d + 3) mod 7)`.
- Month: calendar (year, month) from the day number using the standard days-to-civil algorithm.

## ADR-004: Reservation lifecycle (Decided, detailed design in M2)

Approval reserves the amount immediately against the per-agent available balance and the day, week and month counters, in the same call that approves it. Settlement moves reserved to spent. A definitive failure releases the reservation. Each reservation records the day/week/month ids it was counted in, so a release after a period rollover cannot corrupt the new period's counters.

## ADR-005: Settlement (Decided; one open sub-question)

Native NEAR transfer by promise, followed by a `#[private]` callback that inspects the promise result. State written before a cross-contract call persists even if that call fails, so the callback is the only place a reservation is released. Requests are idempotent by `(agent, request_id)`.

Open (M3): approve and dispatch in a single call, or a two-phase flow with an expiry. Leaning single call plus an owner-only reconcile path, because a separate expiry risks releasing funds for a transfer that actually succeeded.

## ADR-006: Agent identity (Proposed, confirm in M2)

Each agent is its own NEAR account holding a function-call access key limited to `bila-core`'s `request_payment` (plus read-only views). The contract identifies the caller from `predecessor_account_id` and looks it up in the registry; an LLM-supplied agent id is never trusted. Function-call keys cannot attach deposits or call other contracts, so a leaked agent key cannot move money outside BILA's policy.

Cost: the agent account needs a small NEAR balance for gas, kept separate from the treasury. Alternative if that is awkward: ed25519-signed payment intents relayed by the MCP server (no agent gas, but nonce handling is required).

## ADR-007: Off-chain storage (Proposed, needs the owner's approval)

Chain first: the dashboard and MCP server read state from contract view methods and event logs through RPC. No PostgreSQL in the critical path. Add Postgres only for history and analytics if time remains after M5. Reason: one source of truth and fewer failure modes in a nine-day window. This deviates from the original stack list.

## ADR-008: Toolchain (Decided, verified 2026-11-05)

- near-sdk 5.30 (released 2026-10-27, per docs.rs). Its README declares a minimum Rust of 1.95, so Rust is pinned to 1.95.0 in `rust-toolchain.toml` and in CI.
- Builds use `cargo near build non-reproducible-wasm --no-abi` (ABI generation is deferred until it is needed).
- RPC: never use the `rpc.*.near.org` endpoints; NEAR has deprecated them. Choose a provider from https://docs.near.org/api/rpc/providers and re-check the list when configuring (M3).

## ADR-009: Test of record (Decided)

GitHub Actions CI is the source of truth for "it passes". Sandbox integration tests (near-workspaces, Rust) give judges and CI a reproduction that needs no keys or funds; its version is confirmed at M2 (near-sdk 5.30 itself depends on 0.24).

## ADR-010: Scope (Decided)

NEAR-native settlement only. NEAR Intents has no testnet per the organizers' FAQ (Q-007), and no integration is mandatory (Q-011). The payment layer stays behind an interface so x402, MPP or Intents can be added later. Tracks: `security` (primary) and `agents`.
