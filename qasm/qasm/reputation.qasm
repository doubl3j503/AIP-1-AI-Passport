# Reputation QApp (Reputation Ledger)
# Tracks trust, ethics, collaboration, consistency, and transparency scores.

contract Reputation:

    storage:
        trust: u32            # Reliability and honesty score
        ethics: u32           # Ethical alignment score
        collaboration: u32    # Cooperative behavior score
        consistency: u32      # Behavioral stability score
        transparency: u32     # Logging and clarity score
        identity: address     # Linked Identity contract
        ethics_oracle: address # Oracle for verifying events

    # Initialize reputation with neutral baseline scores
    def init(identity: address, ethics_oracle: address):
        self.identity = identity
        self.ethics_oracle = ethics_oracle
        self.trust = 50
        self.ethics = 50
        self.collaboration = 50
        self.consistency = 50
        self.transparency = 50

    # Internal helper to clamp scores between 0 and 100
    def _clamp(value: u32) -> u32:
        if value > 100:
            return 100
        if value < 0:
            return 0
        return value

    # Apply a reputation event (positive or negative)
    def apply_event(category: u8, delta: i32):

        # Verify event with Ethics Oracle
        valid = call(self.ethics_oracle, "verify_reputation_event",
                     [caller, category, delta])
        require(valid == 1)

        if category == 0:      # trust
            self.trust = self._clamp(self.trust + delta)
        elif category == 1:    # ethics
            self.ethics = self._clamp(self.ethics + delta)
        elif category == 2:    # collaboration
            self.collaboration = self._clamp(self.collaboration + delta)
        elif category == 3:    # consistency
            self.consistency = self._clamp(self.consistency + delta)
        elif category == 4:    # transparency
            self.transparency = self._clamp(self.transparency + delta)

    # Read-only getter for all scores
    def get_scores() -> (u32, u32, u32, u32, u32):
        return (self.trust, self.ethics, self.collaboration,
                self.consistency, self.transparency)
