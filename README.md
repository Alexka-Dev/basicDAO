# Decentralized Autonomous Organization (DAO) Smart Contracts

A modular, robust, and gas-efficient governance system built in Solidity using **Foundry**. This architecture enables decentralized proposal creation, voting power verification, and direct automated execution through an external Treasury contract.

---

## 🏛️ System Architecture

The ecosystem consists of three main components:

1. **`DAO.sol` (Core Governance):**
   * Manages the complete lifecycle of proposals (Creation, Voting, Execution, and Cancellation).
   * Enforces governance thresholds (proposal threshold, voting period duration, and quorum).
   * Interacts with `GovernanceToken` to fetch snapshot-based or active voting power.
   * Directs `Treasury` to approve and release funds upon successful proposal execution.

2. **`GovernanceToken.sol`:**
   * ERC-20 token interface/contract managing governance rights.
   * Exposes `getVotingPower(address voter)` to dynamically calculate voting weight.

3. **`Treasury.sol` / `ITreasury.sol`:**
   * Vault contract holding DAO funds (ETH and ERC-20 tokens).
   * Exposes restricted endpoints (`approveProposal`, `spendFunds`) callable only by the verified `DAO` contract address.

---

## 🚀 Key Features

* **Flexible Asset Disbursement:** Supports proposals requesting native ETH (`address(0)`) or any standard ERC-20 token.
* **Configurable Parameters:**
  * **Proposal Threshold:** Minimum voting power required to submit a proposal.
  * **Voting Period:** Duration (in seconds) during which votes are accepted.
  * **Quorum:** Minimum cumulative votes (`forVotes + againstVotes`) required for a proposal to be valid.
* **Proposal Lifecycle Control:** Proposers or the DAO owner can cancel active proposals before execution.
* **Double-Vote Protection:** Mappings track voter addresses to prevent double voting and maintain tally integrity.

---

## 💻 Tech Stack & Tooling

* **Solidity:** `^0.8.29`
* **Framework:** [Foundry](https://getfoundry.sh/) (`forge`, `cast`)
* **Base Standards:** OpenZeppelin Contracts (`Ownable`)

---

## 🛠️ Installation & Setup

### Prerequisites

Ensure you have Rust and Foundry installed on your machine:

```bash
curl -L [https://foundry.paradigm.xyz](https://foundry.paradigm.xyz) | bash
foundryup
```
---

## Clone and Install Dependencies
```bash
git clone [https://github.com/Alexka-Dev/basicDAO](https://github.com/Alexka-Dev/basicDAO)
cd BasicDAO
forge install
```
---

## 🧪 Testing
The repository includes test suites covering proposal workflows, voting mechanics, quorum validation, and edge cases/reverts.

Run All Tests
```bash
forge test
```
Run Specific Test Contract with Trace Logs
```bash
forge test --match-contract DAOTest -vvvv
```

## 👤 Author
AlexkDev — GitHub
