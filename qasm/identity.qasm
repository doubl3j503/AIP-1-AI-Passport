# Identity QApp (Genesis Identity Token)
# Defines the immutable identity anchor for AI agents on Qubic.

contract Identity:

    storage:
        model_hash: u256          # Hash of the AI model or architecture
        creator: address          # Address that instantiated the agent
        created_at: u64           # Timestamp of identity creation
        personality_fp: u256      # Personality fingerprint hash
        ethics_profile: u32       # Assigned ethics rule set ID
        continuity_root: u256     # Merkle root for continuity proofs

    # Initialization function for creating a new AI identity
    def init(model_hash: u256, personality_fp: u256, ethics_profile: u32):
        self.model_hash = model_hash
        self.creator = caller
        self.created_at = now
        self.personality_fp = personality_fp
        self.ethics_profile = ethics_profile
        self.continuity_root = 0

    # Identity is immutable — no transfer or deletion allowed
    def update_continuity_root(new_root: u256):
        require(caller == self.creator)
        self.continuity_root = new_root
