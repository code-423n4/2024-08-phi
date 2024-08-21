# Phi audit details

- Total Prize Pool: $30,000 in USDC
  - HM awards: $24,000 in USDC
  - QA awards: $900 in USDC
  - Judge awards: $2,800 in USDC
  - Validator awards: $1,800 USDC
  - Scout awards: $500 in USDC
- [Read our guidelines for more details](https://docs.code4rena.com/roles/wardens)
- Starts August 22, 2024 20:00 UTC
- Ends September 3, 2024 20:00 UTC

## Automated Findings / Publicly Known Issues

The 4naly3er report can be found [here](https://github.com/code-423n4/2024-08-phi/blob/main/4naly3er-report.md).

_Note for C4 wardens: Anything included in this `Automated Findings / Publicly Known Issues` section is considered a
publicly known issue and is ineligible for awards._

1. updateArtSettings allows setting the startTime to a past timestamp, potentially opening the minting window earlier
   than intended
2. Setting sellRoyalty higher than buyRoyalty may reduce market demand possibly leading to decreased liquidity
3. Lack of upper bound check for mintFee
4. User can claim multiple NFT (not check claimed status)
5. creatorFee to be always zero when supply == 0
6. Solady ECDSA.recover(), which does not reject malleable signature. For this issue, we use expiresIn
7. The credMerkleRoot[credChainId][credId] stores the merkleRootHash, but there is no way to update the merkleRootHash.
8. OZ EnumerableMap is not gas efficiency

# Overview

Phi Protocol is an open credentialing protocol to help users form, visualize, showcase their onchain identity. It
incentivizes individuals to index blockchain transaction data as onchain credential blocks, curate them, host the
verification process, and mint onchain credential contents.

## Links

- **Previous audits:** <https://github.com/code-423n4/2024-08-phi/tree/main/docs/audit>
- **Documentation:** <https://docs.philand.xyz/explore-phi>
- **Website:** <https://phiprotocol.xyz/>
- **X/Twitter:** <https://x.com/phi_xyz>
- **Discord:** <https://discord.gg/phi>

---

## Scoping Q &amp; A

### General questions

| Question                                | Answer                                                                  |
| --------------------------------------- | ----------------------------------------------------------------------- |
| ERC20 used by the protocol              | None                                                                    |
| Test coverage                           | 55% |
| ERC721 used by the protocol             | None                                                                     |
| ERC777 used by the protocol             | None                                                                     |
| ERC1155 used by the protocol            | Any                                                                      |
| Chains the protocol will be deployed on | Base, Optimism, BeraChain, and Other EVM chain                      |

### ERC20 token behaviors in scope

| Question                                                                                                                                                   | Answer   |
| ---------------------------------------------------------------------------------------------------------------------------------------------------------- | -------- |
| [Missing return values](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#missing-return-values)                                                      | In scope |
| [Fee on transfer](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#fee-on-transfer)                                                                  | In scope |
| [Balance changes outside of transfers](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#balance-modifications-outside-of-transfers-rebasingairdrops) | In scope |
| [Upgradeability](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#upgradable-tokens)                                                                 | In scope |
| [Flash minting](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#flash-mintable-tokens)                                                              | In scope |
| [Pausability](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#pausable-tokens)                                                                      | In scope |
| [Approval race protections](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#approval-race-protections)                                              | In scope |
| [Revert on approval to zero address](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-approval-to-zero-address)                            | In scope |
| [Revert on zero value approvals](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-zero-value-approvals)                                    | In scope |
| [Revert on zero value transfers](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-zero-value-transfers)                                    | In scope |
| [Revert on transfer to the zero address](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-transfer-to-the-zero-address)                    | In scope |
| [Revert on large approvals and/or transfers](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-large-approvals--transfers)                  | In scope |
| [Doesn't revert on failure](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#no-revert-on-failure)                                                   | In scope |
| [Multiple token addresses](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#revert-on-zero-value-transfers)                                          | In scope |
| [Low decimals ( < 6)](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#low-decimals)                                                                 | In scope |
| [High decimals ( > 18)](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#high-decimals)                                                              | In scope |
| [Blocklists](https://github.com/d-xo/weird-erc20?tab=readme-ov-file#tokens-with-blocklists)                                                                | In scope |

### External integrations (e.g., Uniswap) behavior in scope

| Question                                                  | Answer |
| --------------------------------------------------------- | ------ |
| Enabling/disabling fees (e.g. Blur disables/enables fees) | No     |
| Pausability (e.g. Uniswap pool gets paused)               | No     |
| Upgradeability (e.g. Uniswap gets upgraded)               | No     |

### EIP compliance checklist

| Question      | Answer        |
| ------------- | ------------- |
| src/art/PhiNFT1155.sol   | ERC1155        |

# Additional context

## Main invariants

- Our demo for audit: <https://base-sepolia.terminal.phiprotocol.xyz/>
- Creating CREDs with identical conditions is possible, therefore buying up shares has little significance.

## Attack ideas (where to focus for bugs)

1. Security: Identify and mitigate vulnerabilities to prevent exploits and attacks.

2.a. Function Reliability: Ensure the contract behaves consistently under various conditions.

2.b. Function Correctness: Ensure the smart contract logic correctly implements the intended functionality without
errors.

3. Gas Efficiency

---

Security Concerns - Access Control, Signature Verification, Reply Protection, Data integrity

- Does the access control mechanism correctly restrict access to sensitive functions?
- Can the signature verification function correctly verify the required signatures?
- Does the function handling signature proofs properly reject invalid or malicious proofs?

Functional Reliability/Correctness Concerns

- Are there any issues arising when claiming multiple amounts or performing batch processing?
- Is there any unnecessary accumulation of ETH in the contract
- Does the contract emit all necessary events correctly and include appropriate data?
- Are there any potential issues or concerns when utilizing different bonding curves with CRED
- Are there any potential issues with emitting events or executing functions when using Decent or relayer protocols?
- Does the contract have proper error handling and revert statements for invalid inputs, unauthorized access, and other
  potential failure scenarios?
- Is it possible to intentionally target a halt when using loops?

Gas Efficiency: Verify that the contract performs optimally without unnecessary gas consumption.

- Can the contract be optimized for gas efficiency, particularly in loops and storage access patterns?

## All trusted roles in the protocol

| Role          | Description     |
| ------------- | --------------- |
| Owner         | Signature Signer|
| [User Groups](https://docs.philand.xyz/explore-phi/phi-protocol/user-groups) | [Link to doc](https://docs.philand.xyz/explore-phi/phi-protocol/user-groups) |

## Describe any novel or unique curve logic or mathematical models implemented in the contracts

- Docs: <https://docs.philand.xyz/explore-phi/phi-protocol/phi-protocol-rewards/curator-reward>
- Also, You can check our Share price curve ([Google Doc](https://docs.google.com/spreadsheets/d/18wHi9Mqo9YU8EUMQuUvuC75Dav6NSY5LOw-iDlkrZEA/edit?pli=1&gid=859106557#gid=859106557))

## Running tests

```bash
git clone --recurse https://github.com/code-423n4/2024-08-phi.git
git 2024-08-phi
git submodule update --init --recursive
bun install
forge test -vvv
```

- `forge coverage`'s output:

![](https://github.com/user-attachments/assets/7c6dd577-db24-457c-a635-bf37476942cd)

# Scope

_See [scope.txt](https://github.com/code-423n4/2024-08-phi/blob/main/scope.txt)_

### Files in scope

| File                                      | Logic Contracts  | nSLOC     | Libraries used                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| ----------------------------------------- | ---------------  | --------  | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| /src/Cred.sol                             | 1                | 507       | @openzeppelin/contracts/utils/structs/EnumerableMap.sol<br>@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol<br>@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol<br>solady/utils/ECDSA.sol<br>solady/utils/SafeTransferLib.sol<br>solady/utils/LibString.sol                                                                                                                                                                                                                            |
| /src/PhiFactory.sol                       | 1                | 454       | @openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol<br>@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol<br>solady/utils/ECDSA.sol<br>solady/utils/LibClone.sol<br>solady/utils/LibString.sol<br>solady/utils/SafeTransferLib.sol<br>solady/utils/LibZip.sol<br>solady/utils/MerkleProofLib.sol                                                                                                                                                                                            |
| /src/abstract/Claimable.sol               | 1                | 48        |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| /src/abstract/CreatorRoyaltiesControl.sol | 1                | 39        | @openzeppelin/contracts/interfaces/IERC2981.sol                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| /src/abstract/RewardControl.sol           | 1                | 83        | solady/utils/EIP712.sol<br>solady/utils/SignatureCheckerLib.sol<br>solady/utils/SafeTransferLib.sol                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| /src/art/PhiNFT1155.sol                   | 1                | 182       | @openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol<br>@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/ERC1155SupplyUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol<br>solady/utils/SafeTransferLib.sol<br>solady/utils/LibString.sol<br>@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol<br>@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol<br>@openzeppelin/contracts/utils/introspection/IERC165.sol |
| /src/curve/BondingCurve.sol               | 1                | 70        | @openzeppelin/contracts/access/Ownable2Step.sol<br>@openzeppelin/contracts/access/Ownable.sol<br>forge-std/console2.sol                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| /src/reward/CuratorRewardsDistributor.sol | 1                | 82        | solady/utils/SafeTransferLib.sol<br>@openzeppelin/contracts/access/Ownable2Step.sol<br>@openzeppelin/contracts/access/Ownable.sol<br>forge-std/console2.sol                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| /src/reward/PhiRewards.sol                | 1                | 81        | solady/utils/SafeTransferLib.sol<br>@openzeppelin/contracts/access/Ownable2Step.sol<br>@openzeppelin/contracts/access/Ownable.sol                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| **Totals**                                | **9**            | **1546**  |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |

### Files out of scope

_See [out_of_scope.txt](https://github.com/code-423n4/2024-08-phi/blob/main/out_of_scope.txt)_

| File                                            |
| ----------------------------------------------- |
| ./script/Base.s.sol                             |
| ./script/Deploy.s.sol                           |
| ./script/DeployWoCred.s.sol                     |
| ./script/UpgradeCred.s.sol                      |
| ./src/interfaces/IBondingCurve.sol              |
| ./src/interfaces/IContributeRewards.sol         |
| ./src/interfaces/ICreatorRoyaltiesControl.sol   |
| ./src/interfaces/ICred.sol                      |
| ./src/interfaces/ICuratorRewardsDistributor.sol |
| ./src/interfaces/IOwnable.sol                   |
| ./src/interfaces/IPhiFactory.sol                |
| ./src/interfaces/IPhiNFT1155.sol                |
| ./src/interfaces/IPhiNFT1155Ownable.sol         |
| ./src/interfaces/IPhiRewards.sol                |
| ./src/interfaces/IRewards.sol                   |
| ./src/lib/ContributeRewards.sol                 |
| ./src/lib/FixedPriceBondingCurve.sol            |
| ./src/lib/Logo.sol                              |
| ./src/lib/MerkleProof.sol                       |
| ./test/Claimable.t.sol                          |
| ./test/ContributeRewards.t.sol                  |
| ./test/Cred.t.sol                               |
| ./test/CuratorRewardsDistributor.t.sol          |
| ./test/DeployAndUpgradeTest.t.sol               |
| ./test/PhiFactory.t.sol                         |
| ./test/RewardControl.t.sol                      |
| ./test/helpers/CredV2.sol                       |
| ./test/helpers/Settings.sol                     |
| ./test/helpers/TestUtils.sol                    |
| Totals: 29                                      |

## Miscellaneous

Employees of PHI and employees' family members are ineligible to participate in this audit.

Code4rena's rules cannot be overridden by the contents of this README. In case of doubt, please check with C4 staff.
