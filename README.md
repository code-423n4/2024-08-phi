# ✨ So you want to run an audit

This `README.md` contains a set of checklists for our audit collaboration.

Your audit will use two repos:

- **an _audit_ repo** (this one), which is used for scoping your audit and for providing information to wardens
- **a _findings_ repo**, where issues are submitted (shared with you after the audit)

Ultimately, when we launch the audit, this repo will be made public and will contain the smart contracts to be reviewed
and all the information needed for audit participants. The findings repo will be made public after the audit report is
published and your team has mitigated the identified issues.

Some of the checklists in this doc are for **C4 (🐺)** and some of them are for **you as the audit sponsor (⭐️)**.

---

# Repo setup

## ⭐️ Sponsor: Add code to this repo

- [ ] Create a PR to this repo with the below changes:
- [ ] Confirm that this repo is a self-contained repository with working commands that will build (at least) all
      in-scope contracts, and commands that will run tests producing gas reports for the relevant contracts.
- [ ] Please have final versions of contracts and documentation added/updated in this repo **no less than 48 business
      hours prior to audit start time.**
- [ ] Be prepared for a 🚨code freeze🚨 for the duration of the audit — important because it establishes a level playing
      field. We want to ensure everyone's looking at the same code, no matter when they look during the audit. (Note:
      this includes your own repo, since a PR can leak alpha to our wardens!)

## ⭐️ Sponsor: Repo checklist

- [ ] Modify the [Overview](#overview) section of this `README.md` file. Describe how your code is supposed to work with
      links to any relevent documentation and any other criteria/details that the auditors should keep in mind when
      reviewing. (Here are two well-constructed examples: [Ajna Protocol](https://github.com/code-423n4/2023-05-ajna)
      and [Maia DAO Ecosystem](https://github.com/code-423n4/2023-05-maia))
- [ ] Review the Gas award pool amount, if applicable. This can be adjusted up or down, based on your preference - just
      flag it for Code4rena staff so we can update the pool totals across all comms channels.
- [ ] Optional: pre-record a high-level overview of your protocol (not just specific smart contract functions). This
      saves wardens a lot of time wading through documentation.
- [ ] [This checklist in Notion](https://code4rena.notion.site/Key-info-for-Code4rena-sponsors-f60764c4c4574bbf8e7a6dbd72cc49b4#0cafa01e6201462e9f78677a39e09746)
      provides some best practices for Code4rena audit repos.

## ⭐️ Sponsor: Final touches

- [ ] Review and confirm the pull request created by the Scout (technical reviewer) who was assigned to your contest.
      _Note: any files not listed as "in scope" will be considered out of scope for the purposes of judging, even if the
      file will be part of the deployed contracts._
- [ ] Check that images and other files used in this README have been uploaded to the repo as a file and then linked in
      the README using absolute path (e.g. `https://github.com/code-423n4/yourrepo-url/filepath.png`)
- [ ] Ensure that _all_ links and image/file paths in this README use absolute paths, not relative paths
- [ ] Check that all README information is in markdown format (HTML does not render on Code4rena.com)
- [ ] Delete this checklist and all text above the line below when you're ready.

---

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
6. solady ECDSA.recover(), which does not reject malleable signature. For this issue, we use expiresIn
7. The credMerkleRoot[credChainId][credId] stores the merkleRootHash, but there is no way to update the merktleRootHash.
   8, OZ EnumerableMap is not gas efficiency

✅ SCOUTS: Please format the response above 👆 so its not a wall of text and its readable.

# Overview

Phi Protocol is an open credentialing protocol to help users form, visualize, showcase their onchain identity. It
incentivizes individuals to index blockchain transaction data as onchain credential blocks, curate them, host the
verification process, and mint onchain credential contents.

## Links

- **Previous audits:**
  - ✅ SCOUTS: If there are multiple report links, please format them in a list.
  - https://github.com/code-423n4/2024-08-phi/tree/main/docs/audit
- **Documentation:** https://docs.philand.xyz/explore-phi
- **Website:** 🐺 CA: add a link to the sponsor's website
- **X/Twitter:** 🐺 CA: add a link to the sponsor's Twitter
- **Discord:** 🐺 CA: add a link to the sponsor's Discord

---

# Scope

[ ✅ SCOUTS: add scoping and technical details here ]

### Files in scope

- ✅ This should be completed using the `metrics.md` file
- ✅ Last row of the table should be Total: SLOC
- ✅ SCOUTS: Have the sponsor review and and confirm in text the details in the section titled "Scoping Q amp; A"

_For sponsors that don't use the scoping tool: list all files in scope in the table below (along with hyperlinks) -- and
feel free to add notes to emphasize areas of focus._

| Contract                                                                                                | SLOC | Purpose                | Libraries used                                           |
| ------------------------------------------------------------------------------------------------------- | ---- | ---------------------- | -------------------------------------------------------- |
| [contracts/folder/sample.sol](https://github.com/code-423n4/repo-name/blob/contracts/folder/sample.sol) | 123  | This contract does XYZ | [`@openzeppelin/*`](https://openzeppelin.com/contracts/) |

### Files out of scope

✅ SCOUTS: List files/directories out of scope

## Scoping Q &amp; A

### General questions

### Are there any ERC20's in scope?: Yes

✅ SCOUTS: If the answer above 👆 is "Yes", please add the tokens below 👇 to the table. Otherwise, update the column
with "None".

Any (all possible ERC20s)

### Are there any ERC777's in scope?: No

✅ SCOUTS: If the answer above 👆 is "Yes", please add the tokens below 👇 to the table. Otherwise, update the column
with "None".

### Are there any ERC721's in scope?: No

✅ SCOUTS: If the answer above 👆 is "Yes", please add the tokens below 👇 to the table. Otherwise, update the column
with "None".

### Are there any ERC1155's in scope?: Yes

✅ SCOUTS: If the answer above 👆 is "Yes", please add the tokens below 👇 to the table. Otherwise, update the column
with "None".

any

✅ SCOUTS: Once done populating the table below, please remove all the Q/A data above.

| Question                                | Answer                                                                  |
| --------------------------------------- | ----------------------------------------------------------------------- |
| ERC20 used by the protocol              | 🖊️                                                                      |
| Test coverage                           | ✅ SCOUTS: Please populate this after running the test coverage command |
| ERC721 used by the protocol             | 🖊️                                                                      |
| ERC777 used by the protocol             | 🖊️                                                                      |
| ERC1155 used by the protocol            | 🖊️                                                                      |
| Chains the protocol will be deployed on | Base,Other,OptimismBera Chain, and Other EVM chain                      |

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

### External integrations (e.g., Uniswap) behavior in scope:

| Question                                                  | Answer |
| --------------------------------------------------------- | ------ |
| Enabling/disabling fees (e.g. Blur disables/enables fees) | No     |
| Pausability (e.g. Uniswap pool gets paused)               | No     |
| Upgradeability (e.g. Uniswap gets upgraded)               | No     |

### EIP compliance checklist

ERC1155

✅ SCOUTS: Please format the response above 👆 using the template below👇

| Question      | Answer        |
| ------------- | ------------- |
| src/Token.sol | ERC20, ERC721 |
| src/NFT.sol   | ERC721        |

# Additional context

## Main invariants

Our demo for audit: https://base-sepolia.terminal.phiprotocol.xyz/ Our first audit report is ....

Creating CREDs with identical conditions is possible, therefore buying up shares has little significance.

✅ SCOUTS: Please format the response above 👆 so its not a wall of text and its readable.

## Attack ideas (where to focus for bugs)

1. Security: Identify and mitigate vulnerabilities to prevent exploits and attacks.

2.a Function Reliability: Ensure the contract behaves consistently under various conditions.

2.b Function Correctness: Ensure the smart contract logic correctly implements the intended functionality without
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

✅ SCOUTS: Please format the response above 👆 so its not a wall of text and its readable.

## All trusted roles in the protocol

Owner Signature Signer

User Groups https://docs.philand.xyz/explore-phi/phi-protocol/user-groups

✅ SCOUTS: Please format the response above 👆 using the template below👇

| Role          | Description     |
| ------------- | --------------- |
| Owner         | Has superpowers |
| Administrator | Can change fees |

## Describe any novel or unique curve logic or mathematical models implemented in the contracts:

Docs https://docs.philand.xyz/explore-phi/phi-protocol/phi-protocol-rewards/curator-reward

Also, You can check our Share price curve
https://docs.google.com/spreadsheets/d/18wHi9Mqo9YU8EUMQuUvuC75Dav6NSY5LOw-iDlkrZEA/edit?pli=1&gid=859106557#gid=859106557

✅ SCOUTS: Please format the response above 👆 so its not a wall of text and its readable.

## Running tests

git clone https://github.com/code-xxx bun install git submodule update --init --recursive forge test --gas-report bun
run test:coverage

✅ SCOUTS: Please format the response above 👆 using the template below👇

```bash
git clone https://github.com/code-423n4/2023-08-arbitrum
git submodule update --init --recursive
cd governance
foundryup
make install
make build
make sc-election-test
```

To run code coverage

```bash
make coverage
```

To run gas benchmarks

```bash
make gas
```

✅ SCOUTS: Add a screenshot of your terminal showing the gas report ✅ SCOUTS: Add a screenshot of your terminal showing
the test coverage

# Scope

_See [scope.txt](https://github.com/code-423n4/2024-08-phi/blob/main/scope.txt)_

### Files in scope

| File                                      | Logic Contracts | Interfaces | nSLOC    | Purpose | Libraries used                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
| ----------------------------------------- | --------------- | ---------- | -------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| /src/Cred.sol                             | 1               | \*\*\*\*   | 507      |         | @openzeppelin/contracts/utils/structs/EnumerableMap.sol<br>@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol<br>@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol<br>solady/utils/ECDSA.sol<br>solady/utils/SafeTransferLib.sol<br>solady/utils/LibString.sol                                                                                                                                                                                                                            |
| /src/PhiFactory.sol                       | 1               | \*\*\*\*   | 454      |         | @openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol<br>@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol<br>solady/utils/ECDSA.sol<br>solady/utils/LibClone.sol<br>solady/utils/LibString.sol<br>solady/utils/SafeTransferLib.sol<br>solady/utils/LibZip.sol<br>solady/utils/MerkleProofLib.sol                                                                                                                                                                                            |
| /src/abstract/Claimable.sol               | 1               | \*\*\*\*   | 48       |         |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| /src/abstract/CreatorRoyaltiesControl.sol | 1               | \*\*\*\*   | 39       |         | @openzeppelin/contracts/interfaces/IERC2981.sol                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
| /src/abstract/RewardControl.sol           | 1               | \*\*\*\*   | 83       |         | solady/utils/EIP712.sol<br>solady/utils/SignatureCheckerLib.sol<br>solady/utils/SafeTransferLib.sol                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       |
| /src/art/PhiNFT1155.sol                   | 1               | \*\*\*\*   | 182      |         | @openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol<br>@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/ERC1155SupplyUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol<br>solady/utils/SafeTransferLib.sol<br>solady/utils/LibString.sol<br>@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol<br>@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol<br>@openzeppelin/contracts/utils/introspection/IERC165.sol |
| /src/curve/BondingCurve.sol               | 1               | \*\*\*\*   | 70       |         | @openzeppelin/contracts/access/Ownable2Step.sol<br>@openzeppelin/contracts/access/Ownable.sol<br>forge-std/console2.sol                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   |
| /src/reward/CuratorRewardsDistributor.sol | 1               | \*\*\*\*   | 82       |         | solady/utils/SafeTransferLib.sol<br>@openzeppelin/contracts/access/Ownable2Step.sol<br>@openzeppelin/contracts/access/Ownable.sol<br>forge-std/console2.sol                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               |
| /src/reward/PhiRewards.sol                | 1               | \*\*\*\*   | 81       |         | solady/utils/SafeTransferLib.sol<br>@openzeppelin/contracts/access/Ownable2Step.sol<br>@openzeppelin/contracts/access/Ownable.sol                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
| **Totals**                                | **9**           | \*\*\*\*   | **1546** |         |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |

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
