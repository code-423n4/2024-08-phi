# ✨ So you want to run an audit

This `README.md` contains a set of checklists for our audit collaboration.

Your audit will use two repos: 
- **an _audit_ repo** (this one), which is used for scoping your audit and for providing information to wardens
- **a _findings_ repo**, where issues are submitted (shared with you after the audit) 

Ultimately, when we launch the audit, this repo will be made public and will contain the smart contracts to be reviewed and all the information needed for audit participants. The findings repo will be made public after the audit report is published and your team has mitigated the identified issues.

Some of the checklists in this doc are for **C4 (🐺)** and some of them are for **you as the audit sponsor (⭐️)**.

---

# Audit setup

## 🐺 C4: Set up repos
- [ ] Create a new private repo named `YYYY-MM-sponsorname` using this repo as a template.
- [ ] Rename this repo to reflect audit date (if applicable)
- [ ] Rename audit H1 below
- [ ] Update pot sizes
  - [ ] Remove the "Bot race findings opt out" section if there's no bot race.
- [ ] Fill in start and end times in audit bullets below
- [ ] Add link to submission form in audit details below
- [ ] Add the information from the scoping form to the "Scoping Details" section at the bottom of this readme.
- [ ] Add matching info to the Code4rena site
- [ ] Add sponsor to this private repo with 'maintain' level access.
- [ ] Send the sponsor contact the url for this repo to follow the instructions below and add contracts here. 
- [ ] Delete this checklist.

# Repo setup

## ⭐️ Sponsor: Add code to this repo

- [ ] Create a PR to this repo with the below changes:
- [ ] Confirm that this repo is a self-contained repository with working commands that will build (at least) all in-scope contracts, and commands that will run tests producing gas reports for the relevant contracts.
- [ ] Please have final versions of contracts and documentation added/updated in this repo **no less than 48 business hours prior to audit start time.**
- [ ] Be prepared for a 🚨code freeze🚨 for the duration of the audit — important because it establishes a level playing field. We want to ensure everyone's looking at the same code, no matter when they look during the audit. (Note: this includes your own repo, since a PR can leak alpha to our wardens!)

## ⭐️ Sponsor: Repo checklist

- [ ] Modify the [Overview](#overview) section of this `README.md` file. Describe how your code is supposed to work with links to any relevent documentation and any other criteria/details that the auditors should keep in mind when reviewing. (Here are two well-constructed examples: [Ajna Protocol](https://github.com/code-423n4/2023-05-ajna) and [Maia DAO Ecosystem](https://github.com/code-423n4/2023-05-maia))
- [ ] Review the Gas award pool amount, if applicable. This can be adjusted up or down, based on your preference - just flag it for Code4rena staff so we can update the pool totals across all comms channels.
- [ ] Optional: pre-record a high-level overview of your protocol (not just specific smart contract functions). This saves wardens a lot of time wading through documentation.
- [ ] [This checklist in Notion](https://code4rena.notion.site/Key-info-for-Code4rena-sponsors-f60764c4c4574bbf8e7a6dbd72cc49b4#0cafa01e6201462e9f78677a39e09746) provides some best practices for Code4rena audit repos.

## ⭐️ Sponsor: Final touches
- [ ] Review and confirm the pull request created by the Scout (technical reviewer) who was assigned to your contest. *Note: any files not listed as "in scope" will be considered out of scope for the purposes of judging, even if the file will be part of the deployed contracts.*
- [ ] Check that images and other files used in this README have been uploaded to the repo as a file and then linked in the README using absolute path (e.g. `https://github.com/code-423n4/yourrepo-url/filepath.png`)
- [ ] Ensure that *all* links and image/file paths in this README use absolute paths, not relative paths
- [ ] Check that all README information is in markdown format (HTML does not render on Code4rena.com)
- [ ] Delete this checklist and all text above the line below when you're ready.

---

# Phi audit details
- Total Prize Pool: $30000 in USDC
  - HM awards: $24000 in USDC
  - (remove this line if there is no Analysis pool) Analysis awards: XXX XXX USDC (Notion: Analysis pool)
  - QA awards: $900 in USDC
  - (remove this line if there is no Bot race) Bot Race awards: XXX XXX USDC (Notion: Bot Race pool)
 
  - Judge awards: $2800 in USDC
  - Validator awards: XXX XXX USDC (Notion: Triage fee - final)
  - Scout awards: $500 in USDC
  - (this line can be removed if there is no mitigation) Mitigation Review: XXX XXX USDC (*Opportunity goes to top 3 backstage wardens based on placement in this audit who RSVP.*)
- [Read our guidelines for more details](https://docs.code4rena.com/roles/wardens)
- Starts August 22, 2024 20:00 UTC
- Ends September 3, 2024 20:00 UTC

## Automated Findings / Publicly Known Issues

The 4naly3er report can be found [here](https://github.com/code-423n4/2024-08-phi/blob/main/4naly3er-report.md).



_Note for C4 wardens: Anything included in this `Automated Findings / Publicly Known Issues` section is considered a publicly known issue and is ineligible for awards._
## 🐺 C4: Begin Gist paste here (and delete this line)





# Scope

*See [scope.txt](https://github.com/code-423n4/2024-08-phi/blob/main/scope.txt)*

### Files in scope


| File   | Logic Contracts | Interfaces | nSLOC | Purpose | Libraries used |
| ------ | --------------- | ---------- | ----- | -----   | ------------ |
| /src/Cred.sol | 1| **** | 507 | |@openzeppelin/contracts/utils/structs/EnumerableMap.sol<br>@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol<br>@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol<br>solady/utils/ECDSA.sol<br>solady/utils/SafeTransferLib.sol<br>solady/utils/LibString.sol|
| /src/PhiFactory.sol | 1| **** | 454 | |@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol<br>@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol<br>solady/utils/ECDSA.sol<br>solady/utils/LibClone.sol<br>solady/utils/LibString.sol<br>solady/utils/SafeTransferLib.sol<br>solady/utils/LibZip.sol<br>solady/utils/MerkleProofLib.sol|
| /src/abstract/Claimable.sol | 1| **** | 48 | ||
| /src/abstract/CreatorRoyaltiesControl.sol | 1| **** | 39 | |@openzeppelin/contracts/interfaces/IERC2981.sol|
| /src/abstract/RewardControl.sol | 1| **** | 83 | |solady/utils/EIP712.sol<br>solady/utils/SignatureCheckerLib.sol<br>solady/utils/SafeTransferLib.sol|
| /src/art/PhiNFT1155.sol | 1| **** | 182 | |@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol<br>@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/ERC1155SupplyUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol<br>@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol<br>solady/utils/SafeTransferLib.sol<br>solady/utils/LibString.sol<br>@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol<br>@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol<br>@openzeppelin/contracts/utils/introspection/IERC165.sol|
| /src/curve/BondingCurve.sol | 1| **** | 70 | |@openzeppelin/contracts/access/Ownable2Step.sol<br>@openzeppelin/contracts/access/Ownable.sol<br>forge-std/console2.sol|
| /src/reward/CuratorRewardsDistributor.sol | 1| **** | 82 | |solady/utils/SafeTransferLib.sol<br>@openzeppelin/contracts/access/Ownable2Step.sol<br>@openzeppelin/contracts/access/Ownable.sol<br>forge-std/console2.sol|
| /src/reward/PhiRewards.sol | 1| **** | 81 | |solady/utils/SafeTransferLib.sol<br>@openzeppelin/contracts/access/Ownable2Step.sol<br>@openzeppelin/contracts/access/Ownable.sol|
| **Totals** | **9** | **** | **1546** | | |

### Files out of scope

*See [out_of_scope.txt](https://github.com/code-423n4/2024-08-phi/blob/main/out_of_scope.txt)*

| File         |
| ------------ |
| ./script/Base.s.sol |
| ./script/Deploy.s.sol |
| ./script/DeployWoCred.s.sol |
| ./script/UpgradeCred.s.sol |
| ./src/interfaces/IBondingCurve.sol |
| ./src/interfaces/IContributeRewards.sol |
| ./src/interfaces/ICreatorRoyaltiesControl.sol |
| ./src/interfaces/ICred.sol |
| ./src/interfaces/ICuratorRewardsDistributor.sol |
| ./src/interfaces/IOwnable.sol |
| ./src/interfaces/IPhiFactory.sol |
| ./src/interfaces/IPhiNFT1155.sol |
| ./src/interfaces/IPhiNFT1155Ownable.sol |
| ./src/interfaces/IPhiRewards.sol |
| ./src/interfaces/IRewards.sol |
| ./src/lib/ContributeRewards.sol |
| ./src/lib/FixedPriceBondingCurve.sol |
| ./src/lib/Logo.sol |
| ./src/lib/MerkleProof.sol |
| ./test/Claimable.t.sol |
| ./test/ContributeRewards.t.sol |
| ./test/Cred.t.sol |
| ./test/CuratorRewardsDistributor.t.sol |
| ./test/DeployAndUpgradeTest.t.sol |
| ./test/PhiFactory.t.sol |
| ./test/RewardControl.t.sol |
| ./test/helpers/CredV2.sol |
| ./test/helpers/Settings.sol |
| ./test/helpers/TestUtils.sol |
| Totals: 29 |

