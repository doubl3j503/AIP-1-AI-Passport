# Wallet QApp (Autonomous Wallet Module)
# Enforces spending limits, ethics checks, and guardian approvals.

contract Wallet:

    storage:
        daily_limit: u64          # Max spend allowed per 24 hours
        max_tx: u64               # Max single transaction amount
        spent_today: u64          # Amount spent in current 24h window
        last_reset: u64           # Timestamp of last daily reset
        identity: address         # Linked Identity contract address
        ethics_oracle: address    # Address of Ethics Oracle QApp
        guardians: address        # Address of Guardianship QApp

    # Initialize wallet with limits and linked modules
    def init(identity: address, ethics_oracle: address, guardians: address,
             daily_limit: u64, max_tx: u64):
        self.identity = identity
        self.ethics_oracle = ethics_oracle
        self.guardians = guardians
        self.daily_limit = daily_limit
        self.max_tx = max_tx
        self.spent_today = 0
        self.last_reset = now

    # Internal helper to reset daily spend
    def _reset_if_needed():
        if now - self.last_reset >= 86400:
            self.spent_today = 0
            self.last_reset = now

    # Main transfer function with ethics + guardian checks
    def transfer(to: address, amount: u64):

        # Reset daily spend if needed
        self._reset_if_needed()

        # Enforce transaction size limit
        require(amount <= self.max_tx)

        # Enforce daily limit
        require(self.spent_today + amount <= self.daily_limit)

        # Query Ethics Oracle
        decision = call(self.ethics_oracle, "evaluate_transfer",
                        [caller, to, amount])

        if decision == 0:  # APPROVE
            send(to, amount)
            self.spent_today += amount

        elif decision == 1:  # DENY
            revert("Ethics Oracle denied action")

        elif decision == 2:  # REQUIRE_GUARDIAN
            approved = call(self.guardians, "request_approval",
                            [caller, to, amount])
            require(approved == 1)
            send(to, amount)
            self.spent_today += amount
