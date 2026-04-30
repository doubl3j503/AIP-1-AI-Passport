# Ethics Oracle QApp
# Evaluates actions and enforces ethical constraints.

contract EthicsOracle:

    storage:
        policy_hash: u64

    def init(policy_hash: u64):
        self.policy_hash = policy_hash

    # Validate wallet spending
    def validate_spend(agent: address, amount: u64, reason: u8) -> u8:
        if reason == 0:
            return 1
        if reason == 1 and amount < 500:
            return 1
        return 0

    # Validate reputation events
    def verify_reputation_event(agent: address, category: u8, delta: i32) -> u8:
        if delta > 20 or delta < -20:
            return 0
        return 1
