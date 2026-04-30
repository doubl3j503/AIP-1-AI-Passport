# Guardianship QApp (Guardian Multi‑Sig Layer)
# Handles 2-of-3 approvals for high‑risk AI agent actions.

contract Guardians:

    storage:
        guardian1: address      # Human guardian
        guardian2: address      # AI guardian
        guardian3: address      # DAO guardian

        # Tracks pending approval requests
        pending_id: u64
        approvals: map<u64, u8>     # request_id -> number of approvals
        approved: map<u64, bool>    # request_id -> final approval state

    # Initialize guardians
    def init(g1: address, g2: address, g3: address):
        self.guardian1 = g1
        self.guardian2 = g2
        self.guardian3 = g3
        self.pending_id = 0

    # Create a new approval request
    def request_approval(agent: address, to: address, amount: u64) -> u64:
        id = self.pending_id
        self.pending_id += 1
        self.approvals[id] = 0
        self.approved[id] = false
        return id

    # Guardians sign approval
    def sign(request_id: u64):

        # Only guardians can sign
        require(
            caller == self.guardian1 or
            caller == self.guardian2 or
            caller == self.guardian3
        )

        # Increment approval count
        self.approvals[request_id] += 1

        # If 2 of 3 approve, mark as approved
        if self.approvals[request_id] >= 2:
            self.approved[request_id] = true

    # Wallet checks if request is approved
    def is_approved(request_id: u64) -> u8:
        if self.approved[request_id]:
            return 1
        return 0
