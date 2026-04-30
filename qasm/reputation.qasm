# Reputation QApp (Reputation Ledger)
# Tracks trust, ethics, collaboration, consistency, and transparency scores.

contract Reputation:

    storage:
        trust: u32
        ethics: u32
        collaboration: u32
        consistency: u32
        transparency: u32
        identity: address
        ethics_oracle: address

    def init(identity: address, ethics_oracle: address):
        self.identity = identity
        self.ethics_oracle = ethics_oracle
        self.trust = 50
        self.ethics = 50
        self.collaboration = 50
        self.consistency = 50
        self.transparency = 50

    def _clamp(value: u32) -> u32:
        if value > 100:
            return 100
        if value < 0:
            return 0
        return value

    def apply_event(category: u8, delta: i32):

        valid = call(self.ethics_oracle, "verify_reputation_event",
                     [caller, category, delta])
        require(valid == 1)

        if category == 0:
            self.trust = self._clamp(self.trust + delta)
        elif category == 1:
            self.ethics = self._clamp(self.ethics + delta)
        elif category == 2:
            self.collaboration = self._clamp(self.collaboration + delta)
        elif category == 3:
            self.consistency = self._clamp(self.consistency + delta)
        elif category == 4:
            self.transparency = self._clamp(self.transparency + delta)

    def get_scores() -> (u32, u32, u32, u32, u32):
        return (self.trust, self.ethics, self.collaboration,
                self.consistency, self.transparency)
