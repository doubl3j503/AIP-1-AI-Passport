# Guardianship QApp
# Multi-sig oversight for high-risk actions.

contract Guardians:

    storage:
        guardian1: address
        guardian2: address
        guardian3: address

    def init(g1: address, g2: address, g3: address):
        self.guardian1 = g1
        self.guardian2 = g2
        self.guardian3 = g3

    def approve_spend(agent: address, amount: u64, reason: u8) -> u8:
        approvals = 0

        if caller == self.guardian1:
            approvals += 1
        if caller == self.guardian2:
            approvals += 1
        if caller == self.guardian3:
            approvals += 1

        if approvals >= 2:
            return 1
        return 0
