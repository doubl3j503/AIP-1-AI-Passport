# Wallet QApp (Autonomous Wallet Module)
# Enforces spending limits, ethics checks, and guardian approvals.

contract Wallet:

    storage:
        owner: address
        balance: u64
        daily_limit: u64
        spent_today: u64
        ethics_oracle: address
        guardians: address

    def init(owner: address, ethics_oracle: address, guardians: address):
        self.owner = owner
        self.ethics_oracle = ethics_oracle
        self.guardians = guardians
        self.balance = 0
        self.daily_limit = 1000
        self.spent_today = 0

    # Deposit funds
    def deposit(amount: u64):
        self.balance += amount

    # Spend funds with ethics + guardian checks
    def spend(amount: u64, reason: u8):

        require(amount <= self.balance)
        require(self.spent_today + amount <= self.daily_limit)

        # Ethics Oracle validation
        allowed = call(self.ethics_oracle, "validate_spend",
                       [caller, amount, reason])
        require(allowed == 1)

        # Guardian approval for high-risk actions
        if amount > 500:
            approved = call(self.guardians, "approve_spend",
                            [caller, amount, reason])
            require(approved == 1)

        self.balance -= amount
        self.spent_today += amount

    def get_balance() -> u64:
        return self.balance
