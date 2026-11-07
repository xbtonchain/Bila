//! BILA core: restricted treasury and spending-policy enforcement for AI agents on NEAR.
//!
//! Milestone 1 is a deliberately tiny skeleton whose only job is to prove the toolchain
//! (unit tests and wasm build) end to end. The agent registry, policies, treasury and atomic
//! reservations arrive in Milestone 2; settlement callbacks in Milestone 3.

use near_sdk::{near, AccountId, PanicOnDefault};

#[near(contract_state)]
#[derive(PanicOnDefault)]
pub struct BilaCore {
    /// Account allowed to perform owner-only operations (enforced from Milestone 2).
    owner: AccountId,
}

#[near]
impl BilaCore {
    #[init]
    pub fn new(owner: AccountId) -> Self {
        Self { owner }
    }

    /// Account that administers this contract instance.
    pub fn get_owner(&self) -> AccountId {
        self.owner.clone()
    }

    /// Semantic version of the deployed contract code.
    pub fn version(&self) -> String {
        env!("CARGO_PKG_VERSION").to_string()
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use near_sdk::test_utils::VMContextBuilder;
    use near_sdk::testing_env;

    fn account(id: &str) -> AccountId {
        id.parse().unwrap()
    }

    #[test]
    fn init_records_owner() {
        let owner = account("owner.testnet");
        let mut builder = VMContextBuilder::new();
        builder.predecessor_account_id(owner.clone());
        testing_env!(builder.build());

        let contract = BilaCore::new(owner.clone());
        assert_eq!(contract.get_owner(), owner);
    }

    #[test]
    fn version_matches_cargo_manifest() {
        let contract = BilaCore::new(account("owner.testnet"));
        assert_eq!(contract.version(), env!("CARGO_PKG_VERSION"));
    }
}
