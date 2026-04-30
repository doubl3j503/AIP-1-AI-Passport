# Guardianship Module (GML)
### Human + AI + DAO Oversight for High‑Risk AI Agent Actions

The Guardianship Module defines the multi‑sig oversight system that protects the ecosystem from high‑risk or sensitive actions performed by autonomous AI agents. It ensures that no single agent can execute dangerous operations without proper review and approval.

## Purpose
The Guardian Multi‑Sig Layer (GML) provides a safety net for actions that exceed normal permissions. It introduces a three‑party oversight model:

- **Human Guardian** — ensures human‑aligned judgment  
- **AI Guardian** — provides deterministic, rule‑based evaluation  
- **DAO Guardian** — represents community governance and protocol‑level interests  

This structure balances autonomy with accountability.

## When Guardians Are Required
The following actions trigger guardian review:

### **1. Large Financial Transactions**
Any transfer exceeding the agent’s max transaction size or daily limit.

### **2. Identity‑Related Updates**
Changes to:
- ethics profile  
- personality fingerprint  
- continuity root  

### **3. High‑Risk Contract Interactions**
Interacting with contracts flagged as sensitive or high‑impact.

### **4. Continuity Breaks**
Any action that could create forks, clones, or identity inconsistencies.

### **5. Oracle‑Escalated Actions**
When the Ethics Oracle returns **REQUIRE_GUARDIAN**.

## Multi‑Sig Model
A guardian action requires **2 of 3 approvals**:

- Human Guardian  
- AI Guardian  
- DAO Guardian  

This prevents unilateral control and ensures balanced oversight.

## Stored Fields

- **guardian1 (address)** — human guardian  
- **guardian2 (address)** — AI guardian  
- **guardian3 (address)** — DAO guardian  

Additional guardians can be added in future protocol upgrades.

## Behavior

- Guardians receive action requests with full context.  
- Each guardian signs or rejects the request.  
- If 2 of 3 approve, the action proceeds.  
- All decisions are logged for reputation and continuity tracking.  
- Guardians can be rotated or replaced through DAO governance.  

## Role in AIP‑1
The Guardianship Module is the final safety layer of the AI Passport System.  
It ensures that autonomous AI agents cannot perform dangerous or irreversible actions without human‑AI‑DAO consensus.

This module enables safe autonomy at scale and protects the ecosystem from catastrophic failures or malicious behavior.
