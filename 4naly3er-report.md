# Report

- [Report](#report)
  - [Gas Optimizations](#gas-optimizations)
    - [\[GAS-1\] Don't use `_msgSender()` if not supporting EIP-2771](#gas-1-dont-use-_msgsender-if-not-supporting-eip-2771)
    - [\[GAS-2\] `a = a + b` is more gas effective than `a += b` for state variables (excluding arrays and mappings)](#gas-2-a--a--b-is-more-gas-effective-than-a--b-for-state-variables-excluding-arrays-and-mappings)
    - [\[GAS-3\] Use assembly to check for `address(0)`](#gas-3-use-assembly-to-check-for-address0)
    - [\[GAS-4\] Using bools for storage incurs overhead](#gas-4-using-bools-for-storage-incurs-overhead)
    - [\[GAS-5\] Cache array length outside of loop](#gas-5-cache-array-length-outside-of-loop)
    - [\[GAS-6\] State variables should be cached in stack variables rather than re-reading them from storage](#gas-6-state-variables-should-be-cached-in-stack-variables-rather-than-re-reading-them-from-storage)
    - [\[GAS-7\] Use calldata instead of memory for function arguments that do not get mutated](#gas-7-use-calldata-instead-of-memory-for-function-arguments-that-do-not-get-mutated)
    - [\[GAS-8\] For Operations that will not overflow, you could use unchecked](#gas-8-for-operations-that-will-not-overflow-you-could-use-unchecked)
    - [\[GAS-9\] Avoid contract existence checks by using low level calls](#gas-9-avoid-contract-existence-checks-by-using-low-level-calls)
    - [\[GAS-10\] Stack variable used as a cheaper cache for a state variable is only used once](#gas-10-stack-variable-used-as-a-cheaper-cache-for-a-state-variable-is-only-used-once)
    - [\[GAS-11\] State variables only set in the constructor should be declared `immutable`](#gas-11-state-variables-only-set-in-the-constructor-should-be-declared-immutable)
    - [\[GAS-12\] Functions guaranteed to revert when called by normal users can be marked `payable`](#gas-12-functions-guaranteed-to-revert-when-called-by-normal-users-can-be-marked-payable)
    - [\[GAS-13\] `++i` costs less gas compared to `i++` or `i += 1` (same for `--i` vs `i--` or `i -= 1`)](#gas-13-i-costs-less-gas-compared-to-i-or-i--1-same-for---i-vs-i---or-i---1)
    - [\[GAS-14\] Using `private` rather than `public` for constants, saves gas](#gas-14-using-private-rather-than-public-for-constants-saves-gas)
    - [\[GAS-15\] Use of `this` instead of marking as `public` an `external` function](#gas-15-use-of-this-instead-of-marking-as-public-an-external-function)
    - [\[GAS-16\] `uint256` to `bool` `mapping`: Utilizing Bitmaps to dramatically save on Gas](#gas-16-uint256-to-bool-mapping-utilizing-bitmaps-to-dramatically-save-on-gas)
    - [\[GAS-17\] Increments/decrements can be unchecked in for-loops](#gas-17-incrementsdecrements-can-be-unchecked-in-for-loops)
    - [\[GAS-18\] Use != 0 instead of \> 0 for unsigned integer comparison](#gas-18-use--0-instead-of--0-for-unsigned-integer-comparison)
  - [Non Critical Issues](#non-critical-issues)
    - [\[NC-1\] Replace `abi.encodeWithSignature` and `abi.encodeWithSelector` with `abi.encodeCall` which keeps the code typo/type safe](#nc-1-replace-abiencodewithsignature-and-abiencodewithselector-with-abiencodecall-which-keeps-the-code-typotype-safe)
    - [\[NC-2\] Missing checks for `address(0)` when assigning values to address state variables](#nc-2-missing-checks-for-address0-when-assigning-values-to-address-state-variables)
    - [\[NC-3\] Use `string.concat()` or `bytes.concat()` instead of `abi.encodePacked`](#nc-3-use-stringconcat-or-bytesconcat-instead-of-abiencodepacked)
    - [\[NC-4\] `constant`s should be defined rather than using magic numbers](#nc-4-constants-should-be-defined-rather-than-using-magic-numbers)
    - [\[NC-5\] Control structures do not follow the Solidity Style Guide](#nc-5-control-structures-do-not-follow-the-solidity-style-guide)
    - [\[NC-6\] Delete rogue `console.log` imports](#nc-6-delete-rogue-consolelog-imports)
    - [\[NC-7\] Consider disabling `renounceOwnership()`](#nc-7-consider-disabling-renounceownership)
    - [\[NC-8\] Events that mark critical parameter changes should contain both the old and the new value](#nc-8-events-that-mark-critical-parameter-changes-should-contain-both-the-old-and-the-new-value)
    - [\[NC-9\] Function ordering does not follow the Solidity style guide](#nc-9-function-ordering-does-not-follow-the-solidity-style-guide)
    - [\[NC-10\] Functions should not be longer than 50 lines](#nc-10-functions-should-not-be-longer-than-50-lines)
    - [\[NC-11\] Change int to int256](#nc-11-change-int-to-int256)
    - [\[NC-12\] Lack of checks in setters](#nc-12-lack-of-checks-in-setters)
    - [\[NC-13\] Missing Event for critical parameters change](#nc-13-missing-event-for-critical-parameters-change)
    - [\[NC-14\] NatSpec is completely non-existent on functions that should have them](#nc-14-natspec-is-completely-non-existent-on-functions-that-should-have-them)
    - [\[NC-15\] Incomplete NatSpec: `@param` is missing on actually documented functions](#nc-15-incomplete-natspec-param-is-missing-on-actually-documented-functions)
    - [\[NC-16\] Incomplete NatSpec: `@return` is missing on actually documented functions](#nc-16-incomplete-natspec-return-is-missing-on-actually-documented-functions)
    - [\[NC-17\] Use a `modifier` instead of a `require/if` statement for a special `msg.sender` actor](#nc-17-use-a-modifier-instead-of-a-requireif-statement-for-a-special-msgsender-actor)
    - [\[NC-18\] Consider using named mappings](#nc-18-consider-using-named-mappings)
    - [\[NC-19\] Owner can renounce while system is paused](#nc-19-owner-can-renounce-while-system-is-paused)
    - [\[NC-20\] Adding a `return` statement when the function defines a named return variable, is redundant](#nc-20-adding-a-return-statement-when-the-function-defines-a-named-return-variable-is-redundant)
    - [\[NC-21\] Take advantage of Custom Error's return value property](#nc-21-take-advantage-of-custom-errors-return-value-property)
    - [\[NC-22\] Avoid the use of sensitive terms](#nc-22-avoid-the-use-of-sensitive-terms)
    - [\[NC-23\] Strings should use double quotes rather than single quotes](#nc-23-strings-should-use-double-quotes-rather-than-single-quotes)
    - [\[NC-24\] Contract does not follow the Solidity style guide's suggested layout ordering](#nc-24-contract-does-not-follow-the-solidity-style-guides-suggested-layout-ordering)
    - [\[NC-25\] Use Underscores for Number Literals (add an underscore every 3 digits)](#nc-25-use-underscores-for-number-literals-add-an-underscore-every-3-digits)
    - [\[NC-26\] Internal and private variables and functions names should begin with an underscore](#nc-26-internal-and-private-variables-and-functions-names-should-begin-with-an-underscore)
    - [\[NC-27\] `override` function arguments that are unused should have the variable name removed or commented out to avoid compiler warnings](#nc-27-override-function-arguments-that-are-unused-should-have-the-variable-name-removed-or-commented-out-to-avoid-compiler-warnings)
    - [\[NC-28\] `public` functions not called by the contract should be declared `external` instead](#nc-28-public-functions-not-called-by-the-contract-should-be-declared-external-instead)
    - [\[NC-29\] Variables need not be initialized to zero](#nc-29-variables-need-not-be-initialized-to-zero)
  - [Low Issues](#low-issues)
    - [\[L-1\] Use of `tx.origin` is unsafe in almost every context](#l-1-use-of-txorigin-is-unsafe-in-almost-every-context)
    - [\[L-2\] Missing checks for `address(0)` when assigning values to address state variables](#l-2-missing-checks-for-address0-when-assigning-values-to-address-state-variables)
    - [\[L-3\] `abi.encodePacked()` should not be used with dynamic types when passing the result to a hash function such as `keccak256()`](#l-3-abiencodepacked-should-not-be-used-with-dynamic-types-when-passing-the-result-to-a-hash-function-such-as-keccak256)
    - [\[L-4\] Use of `tx.origin` is unsafe in almost every context](#l-4-use-of-txorigin-is-unsafe-in-almost-every-context)
    - [\[L-5\] Division by zero not prevented](#l-5-division-by-zero-not-prevented)
    - [\[L-6\] Empty Function Body - Consider commenting why](#l-6-empty-function-body---consider-commenting-why)
    - [\[L-7\] Empty `receive()/payable fallback()` function does not authenticate requests](#l-7-empty-receivepayable-fallback-function-does-not-authenticate-requests)
    - [\[L-8\] External calls in an un-bounded `for-`loop may result in a DOS](#l-8-external-calls-in-an-un-bounded-for-loop-may-result-in-a-dos)
    - [\[L-9\] External call recipient may consume all transaction gas](#l-9-external-call-recipient-may-consume-all-transaction-gas)
    - [\[L-10\] Initializers could be front-run](#l-10-initializers-could-be-front-run)
    - [\[L-11\] Signature use at deadlines should be allowed](#l-11-signature-use-at-deadlines-should-be-allowed)
    - [\[L-12\] Prevent accidentally burning tokens](#l-12-prevent-accidentally-burning-tokens)
    - [\[L-13\] Owner can renounce while system is paused](#l-13-owner-can-renounce-while-system-is-paused)
    - [\[L-14\] Possible rounding issue](#l-14-possible-rounding-issue)
    - [\[L-15\] Loss of precision](#l-15-loss-of-precision)
    - [\[L-16\] Solidity version 0.8.20+ may not work on other chains due to `PUSH0`](#l-16-solidity-version-0820-may-not-work-on-other-chains-due-to-push0)
    - [\[L-17\] Use `Ownable2Step.transferOwnership` instead of `Ownable.transferOwnership`](#l-17-use-ownable2steptransferownership-instead-of-ownabletransferownership)
    - [\[L-18\] Upgradeable contract is missing a `__gap[50]` storage variable to allow for new storage variables in later versions](#l-18-upgradeable-contract-is-missing-a-__gap50-storage-variable-to-allow-for-new-storage-variables-in-later-versions)
    - [\[L-19\] Upgradeable contract not initialized](#l-19-upgradeable-contract-not-initialized)
  - [Medium Issues](#medium-issues)
    - [\[M-1\] Centralization Risk for trusted owners](#m-1-centralization-risk-for-trusted-owners)
      - [Impact](#impact)
    - [\[M-2\] Fees can be set to be greater than 100%](#m-2-fees-can-be-set-to-be-greater-than-100)
    - [\[M-3\] Direct `supportsInterface()` calls may cause caller to revert](#m-3-direct-supportsinterface-calls-may-cause-caller-to-revert)

## Gas Optimizations

| |Issue|Instances|
|-|:-|:-:|
| [GAS-1](#GAS-1) | Don't use `_msgSender()` if not supporting EIP-2771 | 24 |
| [GAS-2](#GAS-2) | `a = a + b` is more gas effective than `a += b` for state variables (excluding arrays and mappings) | 20 |
| [GAS-3](#GAS-3) | Use assembly to check for `address(0)` | 28 |
| [GAS-4](#GAS-4) | Using bools for storage incurs overhead | 6 |
| [GAS-5](#GAS-5) | Cache array length outside of loop | 11 |
| [GAS-6](#GAS-6) | State variables should be cached in stack variables rather than re-reading them from storage | 4 |
| [GAS-7](#GAS-7) | Use calldata instead of memory for function arguments that do not get mutated | 9 |
| [GAS-8](#GAS-8) | For Operations that will not overflow, you could use unchecked | 176 |
| [GAS-9](#GAS-9) | Avoid contract existence checks by using low level calls | 2 |
| [GAS-10](#GAS-10) | Stack variable used as a cheaper cache for a state variable is only used once | 1 |
| [GAS-11](#GAS-11) | State variables only set in the constructor should be declared `immutable` | 1 |
| [GAS-12](#GAS-12) | Functions guaranteed to revert when called by normal users can be marked `payable` | 32 |
| [GAS-13](#GAS-13) | `++i` costs less gas compared to `i++` or `i += 1` (same for `--i` vs `i--` or `i -= 1`) | 13 |
| [GAS-14](#GAS-14) | Using `private` rather than `public` for constants, saves gas | 2 |
| [GAS-15](#GAS-15) | Use of `this` instead of marking as `public` an `external` function | 3 |
| [GAS-16](#GAS-16) | `uint256` to `bool` `mapping`: Utilizing Bitmaps to dramatically save on Gas | 1 |
| [GAS-17](#GAS-17) | Increments/decrements can be unchecked in for-loops | 17 |
| [GAS-18](#GAS-18) | Use != 0 instead of > 0 for unsigned integer comparison | 9 |

### <a name="GAS-1"></a>[GAS-1] Don't use `_msgSender()` if not supporting EIP-2771

Use `msg.sender` if the code does not implement [EIP-2771 trusted forwarder](https://eips.ethereum.org/EIPS/eip-2771) support

*Instances (24)*:

```solidity
File: src/Cred.sol

142:         emit ProtocolFeeDestinationChanged(_msgSender(), protocolFeeDestination_);

149:         emit ProtocolFeePercentChanged(_msgSender(), protocolFeePercent_);

165:         emit AddedToWhitelist(_msgSender(), address_);

172:         emit RemovedFromWhitelist(_msgSender(), address_);

179:         _handleTrade(credId_, amount_, true, _msgSender(), maxPrice_);

183:         _handleTrade(credId_, amount_, false, _msgSender(), minPrice_);

209:             _msgSender().safeTransferETH(refund);

225:         _msgSender().safeTransferETH(totalPayout);

256:         if (sender != _msgSender()) revert Unauthorized();

278:             emit MerkleTreeSetUp(_msgSender(), credId, merkleRoot_);

297:         if (sender != _msgSender()) revert Unauthorized();

299:         if (creds[credId].creator != _msgSender()) revert Unauthorized();

309:         emit CredUpdated(_msgSender(), credId, credURL, buyShareRoyalty_, sellShareRoyalty_);

642:                 _msgSender().safeTransferETH(excessPayment);

807:         _executeBatchTrade(credIds_, amounts_, _msgSender(), prices, protocolFees, creatorFees, false);

871:                 (, uint256 num) = shareBalance[credId].tryGet(_msgSender());

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

112:         if (arts[artId_].artist != _msgSender()) revert NotArtCreator();

706:         if (tx.origin != _msgSender() && msg.sender != art.artAddress && msg.sender != address(this)) {

740:             _msgSender().safeTransferETH(etherValue_ - mintFee);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

152:             _msgSender().safeTransferETH(msg.value - artFee);

318:         address sender = _msgSender();

345:         address sender = _msgSender();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

120:         _msgSender().safeTransferETH(royaltyfee + distributeAmount - actualDistributeAmount);

128:             credId, _msgSender(), royaltyfee + distributeAmount - actualDistributeAmount, distributeAmount, totalBalance

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

### <a name="GAS-2"></a>[GAS-2] `a = a + b` is more gas effective than `a += b` for state variables (excluding arrays and mappings)

This saves **16 gas per instance.**

*Instances (20)*:

```solidity
File: src/Cred.sol

353:             total += IBondingCurve(creds[credIds_[i]].bondingCurve).getBuyPriceAfterFee(

374:             total += IBondingCurve(creds[credIds_[i]].bondingCurve).getSellPriceAfterFee(

574:         credIdCounter += 1;

639:             cred.currentSupply += amount_;

758:                 creds[credId].currentSupply += amount;

878:                 totalAmount += prices[i] + protocolFees[i] + creatorFees[i];

880:                 totalAmount += prices[i] - protocolFees[i] - creatorFees[i];

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

720:         art.numberMinted += quantity_;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/RewardControl.sol

43:             balanceOf[to] += msg.value;

71:             expectedTotalValue += amounts[i];

86:             balanceOf[recipient] += amount;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/RewardControl.sol)

```solidity
File: src/art/PhiNFT1155.sol

149:             tokenIdCounter += 1;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

73:         balanceOf[credId] += amount;

88:             totalNum += credContract.getShareNumber(credId, distributeAddresses[i]);

114:                 actualDistributeAmount += userRewards;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

```solidity
File: src/reward/PhiRewards.sol

98:             artistTotalReward_ += referralTotalReward_;

101:             balanceOf[referral_] += referralTotalReward_;

104:         balanceOf[verifier_] += verifierTotalReward_;

105:         balanceOf[receiver_] += artistTotalReward_;

113:             balanceOf[receiver_] += curateTotalReward_;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/PhiRewards.sol)

### <a name="GAS-3"></a>[GAS-3] Use assembly to check for `address(0)`

*Saves 6 gas per instance*

*Instances (28)*:

```solidity
File: src/Cred.sol

83:         if (protocolFeeDestination_ == address(0)) {

120:         if (address_ == address(0)) revert InvalidAddressZero();

187:         if (curator_ == address(0)) revert InvalidAddressZero();

263:         if (verificationType.eq("MERKLE") && merkleRoot_ == bytes32(0)) {

388:         return creds[credId_].creator != address(0);

557:         if (creator_ == address(0)) {

747:         if (curator == address(0)) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

107:         if (address_ == address(0)) revert InvalidAddressZero();

229:         if (receiver_ == address(0)) {

366:         if (minter_ == address(0) || !art.verificationType.eq("MERKLE") || credMerkleRootHash == bytes32(0)) {

476:         if (thisArt.artAddress == address(0)) revert ArtNotCreated();

561:         if (credNFTContracts[credChainId][credId] == address(0)) {

584:         if (arts[createData_.artId].artAddress != address(0)) revert ArtAlreadyCreated();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/CreatorRoyaltiesControl.sol

18:         if (_royaltyRecipient == address(0)) revert InvalidRoyaltyRecipient();

30:         if (config.royaltyRecipient != address(0)) {

59:         if (configuration.royaltyRecipient == address(0) && configuration.royaltyBPS > 0) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/CreatorRoyaltiesControl.sol)

```solidity
File: src/abstract/RewardControl.sol

40:         if (to == address(0)) revert InvalidAddressZero();

82:             if (recipient == address(0)) {

123:         if (to == address(0)) revert InvalidAddressZero();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/RewardControl.sol)

```solidity
File: src/art/PhiNFT1155.sol

317:         if (from_ != address(0) && soulBounded(id_)) revert TokenNotTransferable();

343:             if (from_ != address(0) && soulBounded(ids_[i])) revert TokenNotTransferable();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

38:         if (phiRewardsContract_ == address(0) || credContract_ == address(0)) {

50:         if (phiRewardsContract_ == address(0)) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

```solidity
File: src/reward/PhiRewards.sol

93:         if (receiver_ == address(0) || minter_ == address(0) || verifier_ == address(0)) {

93:         if (receiver_ == address(0) || minter_ == address(0) || verifier_ == address(0)) {

97:         if (referral_ == minter_ || referral_ == address(0)) {

100:         } else if (referral_ != address(0)) {

108:         if (chainSync_ && address(curatorRewardsDistributor) != address(0)) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/PhiRewards.sol)

### <a name="GAS-4"></a>[GAS-4] Using bools for storage incurs overhead

Use uint256(1) and uint256(2) for true/false to avoid a Gwarmaccess (100 gas), and to avoid Gsset (20000 gas) when changing from ‘false’ to ‘true’, after having been ‘true’ in the past. See [source](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/58f635312aa21f947cae5f8578638a85aa2519f5/contracts/security/ReentrancyGuard.sol#L23-L27).

*Instances (6)*:

```solidity
File: src/Cred.sol

49:     mapping(address priceCurve => bool enable) public curatePriceWhitelist;

51:     mapping(address curator => mapping(uint256 credId => bool exist)) private _credIdExistsPerAddress;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

46:     mapping(uint256 artId => mapping(address minter => bool)) private artMinted;

50:     mapping(uint256 credChainId => mapping(uint256 credId => mapping(address => bool))) private credMinted;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/CreatorRoyaltiesControl.sol

13:     bool private initilaized;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/CreatorRoyaltiesControl.sol)

```solidity
File: src/art/PhiNFT1155.sol

56:     mapping(address minter => bool minted) public minted;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

### <a name="GAS-5"></a>[GAS-5] Cache array length outside of loop

If not cached, the solidity compiler will always read the length of the array during each iteration. That is, if it is a storage array, this is an extra sload operation (100 additional extra gas for each iteration except for the first) and if it is a memory array, this is an extra mload operation (3 additional gas for each iteration except for the first).

*Instances (11)*:

```solidity
File: src/Cred.sol

352:         for (uint256 i = 0; i < credIds_.length; ++i) {

373:         for (uint256 i = 0; i < credIds_.length; ++i) {

452:         for (uint256 i = 0; i < curatorData.length; i++) {

751:         for (uint256 i = 0; i < credIds_.length; ++i) {

772:         for (uint256 i = 0; i < credIds_.length; ++i) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

313:         for (uint256 i = 0; i < encodeDatas_.length; i++) {

318:         for (uint256 i = 0; i < encodeDatas_.length; i++) {

526:         for (uint256 i = 0; i < artId_.length; i++) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

342:         for (uint256 i; i < ids_.length; i++) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

87:         for (uint256 i = 0; i < distributeAddresses.length; i++) {

106:         for (uint256 i = 0; i < distributeAddresses.length; i++) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

### <a name="GAS-6"></a>[GAS-6] State variables should be cached in stack variables rather than re-reading them from storage

The instances below point to the second+ access of a state variable within a function. Caching of a state variable replaces each Gwarmaccess (100 gas) with a much cheaper stack read. Other less obvious fixes/optimizations include having local memory caches of state variable structs, or having local caches of state variable contracts/addresses.

*Saves 100 gas per instance*

*Instances (4)*:

```solidity
File: src/Cred.sol

572:         emit CredCreated(creator_, credIdCounter, credURL_, credType_, verificationType_);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

210:         address artAddress = createERC1155Internal(artIdCounter, erc1155Data);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

145:         emit ArtCreated(artId_, tokenIdCounter);

146:         uint256 createdTokenId = tokenIdCounter;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

### <a name="GAS-7"></a>[GAS-7] Use calldata instead of memory for function arguments that do not get mutated

When a function with a `memory` array is called externally, the `abi.decode()` step has to use a for-loop to copy each index of the `calldata` to the `memory` index. Each iteration of this for-loop costs at least 60 gas (i.e. `60 * <mem_array>.length`). Using `calldata` directly bypasses this loop.

If the array is passed to an `internal` function which passes the array to another internal function where the array is modified and therefore `memory` is used in the `external` call, it's still more gas-efficient to use `calldata` when the `external` function uses modifiers, since the modifiers may prevent the internal functions from being called. Structs have the same overhead as an array of length one.

 *Saves 60 gas per instance*

*Instances (9)*:

```solidity
File: src/PhiFactory.sol

199:         CreateConfig memory createConfig_

217:         string memory url_,

224:         IPhiNFT1155Ownable.RoyaltyConfiguration memory configuration

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

99:         string memory verificationType_,

197:         RoyaltyConfiguration memory configuration

312:         bytes memory data_

335:         uint256[] memory ids_,

336:         uint256[] memory values_,

337:         bytes memory data_

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

### <a name="GAS-8"></a>[GAS-8] For Operations that will not overflow, you could use unchecked

*Instances (176)*:

```solidity
File: src/Cred.sol

4: import { EnumerableMap } from "@openzeppelin/contracts/utils/structs/EnumerableMap.sol";

5: import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

6: import { PausableUpgradeable } from "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";

7: import { Ownable2StepUpgradeable } from "@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol";

8: import { UUPSUpgradeable } from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

9: import { ECDSA } from "solady/utils/ECDSA.sol";

11: import { SafeTransferLib } from "solady/utils/SafeTransferLib.sol";

12: import { LibString } from "solady/utils/LibString.sol";

14: import { ICred } from "./interfaces/ICred.sol";

15: import { IBondingCurve } from "./interfaces/IBondingCurve.sol";

16: import { IPhiRewards } from "./interfaces/IPhiRewards.sol";

207:         uint256 refund = msg.value - totalCost;

324:         return IBondingCurve(creds[credId_].bondingCurve).getPrice(creds[credId_].currentSupply - amount_, amount_);

352:         for (uint256 i = 0; i < credIds_.length; ++i) {

353:             total += IBondingCurve(creds[credIds_[i]].bondingCurve).getBuyPriceAfterFee(

373:         for (uint256 i = 0; i < credIds_.length; ++i) {

374:             total += IBondingCurve(creds[credIds_[i]].bondingCurve).getSellPriceAfterFee(

452:         for (uint256 i = 0; i < curatorData.length; i++) {

505:         credIds = new uint256[](stopIndex - start_);

506:         amounts = new uint256[](stopIndex - start_);

509:         for (uint256 i = start_; i < stopIndex; i++) {

515:                 index++;

574:         credIdCounter += 1;

576:         return credIdCounter - 1;

615:             if (priceLimit != 0 && price + protocolFee + creatorFee > priceLimit) revert PriceExceedsLimit();

616:             if (supply + amount_ > MAX_SUPPLY) {

620:             if (msg.value < price + protocolFee + creatorFee) {

624:             if (priceLimit != 0 && price - protocolFee - creatorFee < priceLimit) revert PriceBelowLimit();

625:             if (block.timestamp <= lastTradeTimestamp[credId_][curator_] + SHARE_LOCK_PERIOD) {

627:                     block.timestamp, lastTradeTimestamp[credId_][curator_] + SHARE_LOCK_PERIOD

639:             cred.currentSupply += amount_;

640:             uint256 excessPayment = msg.value - price - protocolFee - creatorFee;

646:             cred.currentSupply -= amount_;

647:             curator_.safeTransferETH(price - protocolFee - creatorFee);

674:             shareBalance[credId_].set(sender_, currentNum + amount_);

676:             if ((currentNum - amount_) == 0) {

680:             shareBalance[credId_].set(sender_, currentNum - amount_);

691:         _credIdsPerAddressArrLength[sender_]++;

709:         uint256 lastIndex = _credIdsPerAddress[sender_].length - 1;

727:             _credIdsPerAddressArrLength[sender_]--;

751:         for (uint256 i = 0; i < credIds_.length; ++i) {

758:                 creds[credId].currentSupply += amount;

761:                 if (block.timestamp <= lastTradeTimestamp[credId][curator] + SHARE_LOCK_PERIOD) {

763:                         block.timestamp, lastTradeTimestamp[credId][curator] + SHARE_LOCK_PERIOD

766:                 creds[credId].currentSupply -= amount;

772:         for (uint256 i = 0; i < credIds_.length; ++i) {

838:         for (uint256 i = 0; i < length; ++i) {

848:             for (uint256 j = 0; j < i; ++j) {

861:                 if (priceLimits_[i] != 0 && prices[i] + protocolFees[i] + creatorFees[i] > priceLimits_[i]) {

864:                 if (cred.currentSupply + amount > MAX_SUPPLY) {

868:                 if (priceLimits_[i] != 0 && prices[i] - protocolFees[i] - creatorFees[i] < priceLimits_[i]) {

878:                 totalAmount += prices[i] + protocolFees[i] + creatorFees[i];

880:                 totalAmount += prices[i] - protocolFees[i] - creatorFees[i];

917:         CuratorData[] memory result = new CuratorData[](stopIndex - start_);

920:         for (uint256 i = start_; i < stopIndex; ++i) {

925:                 index++;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

4: import { IPhiFactory } from "./interfaces/IPhiFactory.sol";

5: import { IPhiRewards } from "./interfaces/IPhiRewards.sol";

6: import { IPhiNFT1155Ownable } from "./interfaces/IPhiNFT1155Ownable.sol";

8: import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

9: import { PausableUpgradeable } from "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";

10: import { Ownable2StepUpgradeable } from "@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol";

11: import { UUPSUpgradeable } from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

13: import { ECDSA } from "solady/utils/ECDSA.sol";

15: import { LibClone } from "solady/utils/LibClone.sol";

16: import { LibString } from "solady/utils/LibString.sol";

17: import { SafeTransferLib } from "solady/utils/SafeTransferLib.sol";

18: import { LibZip } from "solady/utils/LibZip.sol";

19: import { MerkleProofLib } from "solady/utils/MerkleProofLib.sol";

78:                 "https://gateway.irys.xyz/H2OgtiAtsJRB8svr4d-kV2BtAE4BTI_q0wtAn5aKjcU",

81:                 "https://www.arweave.net/47AloaAgG7UFYuZjieYi4b2QOD1TG2pFYAbsshULtEY?ext=png",

83:                 '"external_link":"https://phiprotocol.xyz/",',

91:         return string.concat("data:application/json;utf8,", json);

211:         artIdCounter++;

313:         for (uint256 i = 0; i < encodeDatas_.length; i++) {

314:             totalEthValue = totalEthValue + ethValue_[i];

318:         for (uint256 i = 0; i < encodeDatas_.length; i++) {

511:             + quantity_ * mintProtocolFee;

526:         for (uint256 i = 0; i < artId_.length; i++) {

528:             totalMintFee = totalMintFee + getArtMintFee(artId, quantitys_[i]);

713:         if (art.numberMinted + quantity_ > art.maxSupply) revert OverMaxAllowedToMint();

720:         art.numberMinted += quantity_;

739:         if ((etherValue_ - mintFee) > 0) {

740:             _msgSender().safeTransferETH(etherValue_ - mintFee);

742:         protocolFeeDestination.safeTransferETH(mintProtocolFee * quantity_);

744:         (bool success_,) = art.artAddress.call{ value: mintFee - mintProtocolFee * quantity_ }(

771:                 "This NFT represents a unique on-chain cred created by ",

778:                 "Join the Phi community to collect and showcase your on-chain achievements."

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/Claimable.sol

4: import { IPhiFactory } from "../interfaces/IPhiFactory.sol";

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/Claimable.sol)

```solidity
File: src/abstract/CreatorRoyaltiesControl.sol

4: import { ICreatorRoyaltiesControl } from "../interfaces/ICreatorRoyaltiesControl.sol";

5: import { IERC2981 } from "@openzeppelin/contracts/interfaces/IERC2981.sol";

51:         royaltyAmount = (config.royaltyBPS * salePrice) / ROYALTY_BPS_TO_PERCENT;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/CreatorRoyaltiesControl.sol)

```solidity
File: src/abstract/RewardControl.sol

4: import { EIP712 } from "solady/utils/EIP712.sol";

5: import { IRewards } from "../interfaces/IRewards.sol";

6: import { SignatureCheckerLib } from "solady/utils/SignatureCheckerLib.sol";

7: import { SafeTransferLib } from "solady/utils/SafeTransferLib.sol";

43:             balanceOf[to] += msg.value;

70:         for (uint256 i = 0; i < numRecipients; i++) {

71:             expectedTotalValue += amounts[i];

78:         for (uint256 i = 0; i < numRecipients; i++) {

86:             balanceOf[recipient] += amount;

105:             ++nonces[from];

133:             balanceOf[from] = balance - amount;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/RewardControl.sol)

```solidity
File: src/art/PhiNFT1155.sol

4: import { IPhiNFT1155 } from "../interfaces/IPhiNFT1155.sol";

5: import { IPhiFactory } from "../interfaces/IPhiFactory.sol";

6: import { IPhiRewards } from "../interfaces/IPhiRewards.sol";

7: import { Claimable } from "../abstract/Claimable.sol";

8: import { ERC1155Upgradeable } from "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";

10:     "@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/ERC1155SupplyUpgradeable.sol";

11: import { PausableUpgradeable } from "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";

12: import { ReentrancyGuardUpgradeable } from "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";

13: import { Ownable2StepUpgradeable } from "@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol";

14: import { SafeTransferLib } from "solady/utils/SafeTransferLib.sol";

15: import { LibString } from "solady/utils/LibString.sol";

16: import { CreatorRoyaltiesControl } from "../abstract/CreatorRoyaltiesControl.sol";

17: import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

18: import { UUPSUpgradeable } from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

19: import { IERC165 } from "@openzeppelin/contracts/utils/introspection/IERC165.sol";

117:             abi.encodePacked("Phi Cred-", uint256(credId_).toString(), " on Chain-", uint256(credChainId_).toString())

119:         symbol = string(abi.encodePacked("PHI-", uint256(credId_).toString(), "-", uint256(credChainId_).toString()));

149:             tokenIdCounter += 1;

151:         if ((msg.value - artFee) > 0) {

152:             _msgSender().safeTransferETH(msg.value - artFee);

342:         for (uint256 i; i < ids_.length; i++) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/curve/BondingCurve.sol

4: import { Ownable2Step } from "@openzeppelin/contracts/access/Ownable2Step.sol";

5: import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

6: import { IBondingCurve } from "../interfaces/IBondingCurve.sol";

7: import { ICred } from "../interfaces/ICred.sol";

9: import { console2 } from "forge-std/console2.sol";

48:         return _curve((supply_ + amount_) * 1 ether) - _curve(supply_ * 1 ether);

63:         price = isSign_ ? getPrice(supply_, amount_) : getPrice(supply_ - amount_, amount_);

71:         creatorFee = (price * royaltyRate) / RATIO_BASE;

91:         return price + protocolFee + creatorFee;

99:         return getPrice(supply_ - amount_, amount_);

110:         return price - protocolFee - creatorFee;

118:         return (TOTAL_SUPPLY_FACTOR * CURVE_FACTOR * 1 ether) / (TOTAL_SUPPLY_FACTOR - targetAmount_)

119:             - CURVE_FACTOR * 1 ether - INITIAL_PRICE_FACTOR * targetAmount_ / 1000;

124:         return price_ * credContract.protocolFeePercent() / RATIO_BASE;

148:         creatorFee = (price_ * royaltyRate) / RATIO_BASE;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/curve/BondingCurve.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

4: import { Logo } from "../lib/Logo.sol";

5: import { ICuratorRewardsDistributor } from "../interfaces/ICuratorRewardsDistributor.sol";

6: import { IPhiRewards } from "../interfaces/IPhiRewards.sol";

7: import { ICred } from "../interfaces/ICred.sol";

8: import { SafeTransferLib } from "solady/utils/SafeTransferLib.sol";

9: import { Ownable2Step } from "@openzeppelin/contracts/access/Ownable2Step.sol";

10: import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

12: import { console2 } from "forge-std/console2.sol";

73:         balanceOf[credId] += amount;

87:         for (uint256 i = 0; i < distributeAddresses.length; i++) {

88:             totalNum += credContract.getShareNumber(credId, distributeAddresses[i]);

98:         uint256 royaltyfee = (totalBalance * withdrawRoyalty) / RATIO_BASE;

99:         uint256 distributeAmount = totalBalance - royaltyfee;

106:         for (uint256 i = 0; i < distributeAddresses.length; i++) {

110:             uint256 userRewards = (distributeAmount * userAmounts) / totalNum;

114:                 actualDistributeAmount += userRewards;

118:         balanceOf[credId] -= totalBalance;

120:         _msgSender().safeTransferETH(royaltyfee + distributeAmount - actualDistributeAmount);

128:             credId, _msgSender(), royaltyfee + distributeAmount - actualDistributeAmount, distributeAmount, totalBalance

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

```solidity
File: src/reward/PhiRewards.sol

4: import { Logo } from "../lib/Logo.sol";

5: import { IPhiRewards } from "../interfaces/IPhiRewards.sol";

6: import { RewardControl } from "../abstract/RewardControl.sol";

7: import { ICuratorRewardsDistributor } from "../interfaces/ICuratorRewardsDistributor.sol";

8: import { SafeTransferLib } from "solady/utils/SafeTransferLib.sol";

9: import { Ownable2Step } from "@openzeppelin/contracts/access/Ownable2Step.sol";

10: import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

98:             artistTotalReward_ += referralTotalReward_;

101:             balanceOf[referral_] += referralTotalReward_;

104:         balanceOf[verifier_] += verifierTotalReward_;

105:         balanceOf[receiver_] += artistTotalReward_;

113:             balanceOf[receiver_] += curateTotalReward_;

115:                 abi.encode(artistTotalReward_ + curateTotalReward_, referralTotalReward_, verifierTotalReward_, 0);

142:             quantity_ * (mintFee_ + artistReward),

143:             quantity_ * referralReward,

144:             quantity_ * verifierReward,

145:             quantity_ * curateReward,

154:         return quantity_ * (artistReward + mintFee_ + referralReward + verifierReward + curateReward);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/PhiRewards.sol)

### <a name="GAS-9"></a>[GAS-9] Avoid contract existence checks by using low level calls

Prior to 0.8.10 the compiler inserted extra code, including `EXTCODESIZE` (**100 gas**), to check for contract existence for external function calls. In more recent solidity versions, the compiler will not insert these checks if the external call has a return value. Similar behavior can be achieved in earlier versions by using low-level calls, since low level calls never check for contract existence

*Instances (2)*:

```solidity
File: src/Cred.sol

889:         return ECDSA.recover(ECDSA.toEthSignedMessageHash(hash_), signature_);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

580:         return ECDSA.recover(ECDSA.toEthSignedMessageHash(hash_), signature_);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

### <a name="GAS-10"></a>[GAS-10] Stack variable used as a cheaper cache for a state variable is only used once

If the variable is only accessed once, it's cheaper to use the state variable directly that one time, and save the **3 gas** the extra stack assignment would spend

*Instances (1)*:

```solidity
File: src/art/PhiNFT1155.sol

146:         uint256 createdTokenId = tokenIdCounter;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

### <a name="GAS-11"></a>[GAS-11] State variables only set in the constructor should be declared `immutable`

Variables only set in the constructor and never edited afterwards should be marked as immutable, as it would avoid the expensive storage-writing operation in the constructor (around **20 000 gas** per variable) and replace the expensive storage-reading operations (around **2100 gas** per reading) to a less expensive value reading (**3 gas**)

*Instances (1)*:

```solidity
File: src/reward/CuratorRewardsDistributor.sol

43:         credContract = ICred(credContract_);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

### <a name="GAS-12"></a>[GAS-12] Functions guaranteed to revert when called by normal users can be marked `payable`

If a function modifier such as `onlyOwner` is used, the function will revert if a normal user tries to pay the function. Marking the function as `payable` will lower the gas cost for legitimate callers because the compiler will not include checks for whether a payment was provided.

*Instances (32)*:

```solidity
File: src/Cred.sol

100:     function pause() external onlyOwner {

105:     function unPause() external onlyOwner {

129:     function setPhiSignerAddress(address phiSignerAddress_) external nonZeroAddress(phiSignerAddress_) onlyOwner {

147:     function setProtocolFeePercent(uint256 protocolFeePercent_) external onlyOwner {

154:     function setPhiRewardsAddress(address phiRewardsAddress_) external nonZeroAddress(phiRewardsAddress_) onlyOwner {

163:     function addToWhitelist(address address_) external onlyOwner {

170:     function removeFromWhitelist(address address_) external onlyOwner {

937:     function _authorizeUpgrade(address newImplementation) internal override onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

156:     function pause() external onlyOwner {

161:     function unPause() external onlyOwner {

170:     function pauseArtContract(uint256 artId_) external onlyOwner {

176:     function unPauseArtContract(uint256 artId_) external onlyOwner {

180:     function pauseArtContract(address artAddress_) external onlyOwner {

184:     function unPauseArtContract(address artAddress_) external onlyOwner {

390:     function setPhiSignerAddress(address phiSignerAddress_) external nonZeroAddress(phiSignerAddress_) onlyOwner {

397:     function setPhiRewardsAddress(address phiRewardsAddress_) external nonZeroAddress(phiRewardsAddress_) onlyOwner {

404:     function setErc1155ArtAddress(address erc1155ArtAddress_) external nonZeroAddress(erc1155ArtAddress_) onlyOwner {

422:     function setProtocolFee(uint256 protocolFee_) external onlyOwner {

430:     function setArtCreatFee(uint256 artCreateFee_) external onlyOwner {

570:     function _authorizeUpgrade(address newImplementation) internal override onlyOwner { }

786:     function withdraw() external onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

128:     function pause() external onlyOwner {

133:     function unPause() external onlyOwner {

352:     function _authorizeUpgrade(address newImplementation) internal override onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/curve/BondingCurve.sol

34:     function setCredContract(address credContract_) external onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/curve/BondingCurve.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

49:     function updatePhiRewardsContract(address phiRewardsContract_) external onlyOwner {

57:     function updateRoyalty(uint256 newRoyalty_) external onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

```solidity
File: src/reward/PhiRewards.sol

39:     function updateArtistReward(uint256 newArtistReward_) external onlyOwner {

46:     function updateReferralReward(uint256 newReferralReward_) external onlyOwner {

53:     function updateVerifierReward(uint256 newVerifyReward_) external onlyOwner {

60:     function updateCurateReward(uint256 newCurateReward_) external onlyOwner {

68:     function updateCuratorRewardsDistributor(address curatorRewardsDistributor_) external onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/PhiRewards.sol)

### <a name="GAS-13"></a>[GAS-13] `++i` costs less gas compared to `i++` or `i += 1` (same for `--i` vs `i--` or `i -= 1`)

Pre-increments and pre-decrements are cheaper.

For a `uint256 i` variable, the following is true with the Optimizer enabled at 10k:

**Increment:**

- `i += 1` is the most expensive form
- `i++` costs 6 gas less than `i += 1`
- `++i` costs 5 gas less than `i++` (11 gas less than `i += 1`)

**Decrement:**

- `i -= 1` is the most expensive form
- `i--` costs 11 gas less than `i -= 1`
- `--i` costs 5 gas less than `i--` (16 gas less than `i -= 1`)

Note that post-increments (or post-decrements) return the old value before incrementing or decrementing, hence the name *post-increment*:

```solidity
uint i = 1;  
uint j = 2;
require(j == i++, "This will be false as i is incremented after the comparison");
```
  
However, pre-increments (or pre-decrements) return the new value:
  
```solidity
uint i = 1;  
uint j = 2;
require(j == ++i, "This will be true as i is incremented before the comparison");
```

In the pre-increment case, the compiler has to create a temporary variable (when used) for returning `1` instead of `2`.

Consider using pre-increments and pre-decrements where they are relevant (meaning: not where post-increments/decrements logic are relevant).

*Saves 5 gas per instance*

*Instances (13)*:

```solidity
File: src/Cred.sol

452:         for (uint256 i = 0; i < curatorData.length; i++) {

509:         for (uint256 i = start_; i < stopIndex; i++) {

515:                 index++;

925:                 index++;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

211:         artIdCounter++;

313:         for (uint256 i = 0; i < encodeDatas_.length; i++) {

318:         for (uint256 i = 0; i < encodeDatas_.length; i++) {

526:         for (uint256 i = 0; i < artId_.length; i++) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/RewardControl.sol

70:         for (uint256 i = 0; i < numRecipients; i++) {

78:         for (uint256 i = 0; i < numRecipients; i++) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/RewardControl.sol)

```solidity
File: src/art/PhiNFT1155.sol

342:         for (uint256 i; i < ids_.length; i++) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

87:         for (uint256 i = 0; i < distributeAddresses.length; i++) {

106:         for (uint256 i = 0; i < distributeAddresses.length; i++) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

### <a name="GAS-14"></a>[GAS-14] Using `private` rather than `public` for constants, saves gas

If needed, the values can be read from the verified contract source code, or if there are multiple values there can be a single getter function that [returns a tuple](https://github.com/code-423n4/2022-08-frax/blob/90f55a9ce4e25bceed3a74290b854341d8de6afa/src/contracts/FraxlendPair.sol#L156-L178) of the values of all currently-public constants. Saves **3406-3606 gas** in deployment gas due to the compiler not having to create non-payable getter functions for deployment calldata, not having to store the bytes of the value outside of where it's used, and not adding another entry to the method ID table

*Instances (2)*:

```solidity
File: src/Cred.sol

33:     uint256 public constant SHARE_LOCK_PERIOD = 10 minutes;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/abstract/RewardControl.sol

23:     bytes32 public constant WITHDRAW_TYPEHASH =

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/RewardControl.sol)

### <a name="GAS-15"></a>[GAS-15] Use of `this` instead of marking as `public` an `external` function

Using `this.` is like making an expensive external call. Consider marking the called function as public

*Saves around 2000 gas per instance*

*Instances (3)*:

```solidity
File: src/PhiFactory.sol

283:             this.merkleClaim{ value: mintFee }(proof, claimData, mintArgs, leafPart_);

300:             this.signatureClaim{ value: mintFee }(signature_, claimData, mintArgs);

319:             this.claim{ value: ethValue_[i] }(encodeDatas_[i]);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

### <a name="GAS-16"></a>[GAS-16] `uint256` to `bool` `mapping`: Utilizing Bitmaps to dramatically save on Gas
<https://soliditydeveloper.com/bitmaps>

<https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/structs/BitMaps.sol>

- [BitMaps.sol#L5-L16](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/structs/BitMaps.sol#L5-L16):

```solidity
/**
 * @dev Library for managing uint256 to bool mapping in a compact and efficient way, provided the keys are sequential.
 * Largely inspired by Uniswap's https://github.com/Uniswap/merkle-distributor/blob/master/contracts/MerkleDistributor.sol[merkle-distributor].
 *
 * BitMaps pack 256 booleans across each bit of a single 256-bit slot of `uint256` type.
 * Hence booleans corresponding to 256 _sequential_ indices would only consume a single slot,
 * unlike the regular `bool` which would consume an entire slot for a single value.
 *
 * This results in gas savings in two ways:
 *
 * - Setting a zero value to non-zero only once every 256 times
 * - Accessing the same warm slot for every 256 _sequential_ indices
 */
```

*Instances (1)*:

```solidity
File: src/Cred.sol

51:     mapping(address curator => mapping(uint256 credId => bool exist)) private _credIdExistsPerAddress;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

### <a name="GAS-17"></a>[GAS-17] Increments/decrements can be unchecked in for-loops

In Solidity 0.8+, there's a default overflow check on unsigned integers. It's possible to uncheck this in for-loops and save some gas at each iteration, but at the cost of some code readability, as this uncheck cannot be made inline.

[ethereum/solidity#10695](https://github.com/ethereum/solidity/issues/10695)

The change would be:

```diff
- for (uint256 i; i < numIterations; i++) {
+ for (uint256 i; i < numIterations;) {
 // ...  
+   unchecked { ++i; }
}  
```

These save around **25 gas saved** per instance.

The same can be applied with decrements (which should use `break` when `i == 0`).

The risk of overflow is non-existent for `uint256`.

*Instances (17)*:

```solidity
File: src/Cred.sol

352:         for (uint256 i = 0; i < credIds_.length; ++i) {

373:         for (uint256 i = 0; i < credIds_.length; ++i) {

452:         for (uint256 i = 0; i < curatorData.length; i++) {

509:         for (uint256 i = start_; i < stopIndex; i++) {

751:         for (uint256 i = 0; i < credIds_.length; ++i) {

772:         for (uint256 i = 0; i < credIds_.length; ++i) {

838:         for (uint256 i = 0; i < length; ++i) {

848:             for (uint256 j = 0; j < i; ++j) {

920:         for (uint256 i = start_; i < stopIndex; ++i) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

313:         for (uint256 i = 0; i < encodeDatas_.length; i++) {

318:         for (uint256 i = 0; i < encodeDatas_.length; i++) {

526:         for (uint256 i = 0; i < artId_.length; i++) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/RewardControl.sol

70:         for (uint256 i = 0; i < numRecipients; i++) {

78:         for (uint256 i = 0; i < numRecipients; i++) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/RewardControl.sol)

```solidity
File: src/art/PhiNFT1155.sol

342:         for (uint256 i; i < ids_.length; i++) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

87:         for (uint256 i = 0; i < distributeAddresses.length; i++) {

106:         for (uint256 i = 0; i < distributeAddresses.length; i++) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

### <a name="GAS-18"></a>[GAS-18] Use != 0 instead of > 0 for unsigned integer comparison

*Instances (9)*:

```solidity
File: src/Cred.sol

208:         if (refund > 0) {

420:         return amounts > 0;

641:             if (excessPayment > 0) {

726:         if (_credIdsPerAddressArrLength[sender_] > 0) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

739:         if ((etherValue_ - mintFee) > 0) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/CreatorRoyaltiesControl.sol

59:         if (configuration.royaltyRecipient == address(0) && configuration.royaltyBPS > 0) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/CreatorRoyaltiesControl.sol)

```solidity
File: src/art/PhiNFT1155.sol

151:         if ((msg.value - artFee) > 0) {

242:         if (bytes(advancedTokenURI[tokenId_][minter_]).length > 0) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

112:             if (userRewards > 0) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

## Non Critical Issues

| |Issue|Instances|
|-|:-|:-:|
| [NC-1](#NC-1) | Replace `abi.encodeWithSignature` and `abi.encodeWithSelector` with `abi.encodeCall` which keeps the code typo/type safe | 3 |
| [NC-2](#NC-2) | Missing checks for `address(0)` when assigning values to address state variables | 13 |
| [NC-3](#NC-3) | Use `string.concat()` or `bytes.concat()` instead of `abi.encodePacked` | 6 |
| [NC-4](#NC-4) | `constant`s should be defined rather than using magic numbers | 13 |
| [NC-5](#NC-5) | Control structures do not follow the Solidity Style Guide | 127 |
| [NC-6](#NC-6) | Delete rogue `console.log` imports | 2 |
| [NC-7](#NC-7) | Consider disabling `renounceOwnership()` | 5 |
| [NC-8](#NC-8) | Events that mark critical parameter changes should contain both the old and the new value | 20 |
| [NC-9](#NC-9) | Function ordering does not follow the Solidity style guide | 8 |
| [NC-10](#NC-10) | Functions should not be longer than 50 lines | 102 |
| [NC-11](#NC-11) | Change int to int256 | 1 |
| [NC-12](#NC-12) | Lack of checks in setters | 16 |
| [NC-13](#NC-13) | Missing Event for critical parameters change | 2 |
| [NC-14](#NC-14) | NatSpec is completely non-existent on functions that should have them | 20 |
| [NC-15](#NC-15) | Incomplete NatSpec: `@param` is missing on actually documented functions | 12 |
| [NC-16](#NC-16) | Incomplete NatSpec: `@return` is missing on actually documented functions | 1 |
| [NC-17](#NC-17) | Use a `modifier` instead of a `require/if` statement for a special `msg.sender` actor | 4 |
| [NC-18](#NC-18) | Consider using named mappings | 1 |
| [NC-19](#NC-19) | Owner can renounce while system is paused | 10 |
| [NC-20](#NC-20) | Adding a `return` statement when the function defines a named return variable, is redundant | 5 |
| [NC-21](#NC-21) | Take advantage of Custom Error's return value property | 98 |
| [NC-22](#NC-22) | Avoid the use of sensitive terms | 10 |
| [NC-23](#NC-23) | Strings should use double quotes rather than single quotes | 11 |
| [NC-24](#NC-24) | Contract does not follow the Solidity style guide's suggested layout ordering | 3 |
| [NC-25](#NC-25) | Use Underscores for Number Literals (add an underscore every 3 digits) | 4 |
| [NC-26](#NC-26) | Internal and private variables and functions names should begin with an underscore | 16 |
| [NC-27](#NC-27) | `override` function arguments that are unused should have the variable name removed or commented out to avoid compiler warnings | 3 |
| [NC-28](#NC-28) | `public` functions not called by the contract should be declared `external` instead | 23 |
| [NC-29](#NC-29) | Variables need not be initialized to zero | 17 |

### <a name="NC-1"></a>[NC-1] Replace `abi.encodeWithSignature` and `abi.encodeWithSelector` with `abi.encodeCall` which keeps the code typo/type safe

When using `abi.encodeWithSignature`, it is possible to include a typo for the correct function signature.
When using `abi.encodeWithSignature` or `abi.encodeWithSelector`, it is also possible to provide parameters that are not of the correct type for the function.

To avoid these pitfalls, it would be best to use [`abi.encodeCall`](https://solidity-by-example.org/abi-encode/) instead.

*Instances (3)*:

```solidity
File: src/PhiFactory.sol

641:             newArt.call{ value: msg.value }(abi.encodeWithSignature("createArtFromFactory(uint256)", newArtId));

664:             existingArt.call{ value: msg.value }(abi.encodeWithSignature("createArtFromFactory(uint256)", newArtId));

745:             abi.encodeWithSignature(

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

### <a name="NC-2"></a>[NC-2] Missing checks for `address(0)` when assigning values to address state variables

*Instances (13)*:

```solidity
File: src/Cred.sol

88:         phiSignerAddress = phiSignerAddress_;

90:         phiRewardsAddress = phiRewardsAddress_;

130:         phiSignerAddress = phiSignerAddress_;

141:         protocolFeeDestination = protocolFeeDestination_;

155:         phiRewardsAddress = phiRewardsAddress_;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

149:         phiSignerAddress = phiSignerAddress_;

150:         protocolFeeDestination = protocolFeeDestination_;

151:         erc1155ArtAddress = erc1155ArtAddress_;

152:         phiRewardsAddress = phiRewardsAddress_;

391:         phiSignerAddress = phiSignerAddress_;

398:         phiRewardsAddress = phiRewardsAddress_;

405:         erc1155ArtAddress = erc1155ArtAddress_;

416:         protocolFeeDestination = protocolFeeDestination_;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

### <a name="NC-3"></a>[NC-3] Use `string.concat()` or `bytes.concat()` instead of `abi.encodePacked`

Solidity version 0.8.4 introduces `bytes.concat()` (vs `abi.encodePacked(<bytes>,<bytes>)`)

Solidity version 0.8.12 introduces `string.concat()` (vs `abi.encodePacked(<str>,<str>), which catches concatenation errors (in the event of a`bytes`data mixed in the concatenation)`)

*Instances (6)*:

```solidity
File: src/PhiFactory.sol

69:             abi.encodePacked(

632:             payable(erc1155ArtAddress.cloneDeterministic(keccak256(abi.encodePacked(block.chainid, newArtId, credId))));

765:             abi.encodePacked(

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/Claimable.sol

39:         bytes memory signature = abi.encodePacked(r_, vs_);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/Claimable.sol)

```solidity
File: src/art/PhiNFT1155.sol

117:             abi.encodePacked("Phi Cred-", uint256(credId_).toString(), " on Chain-", uint256(credChainId_).toString())

119:         symbol = string(abi.encodePacked("PHI-", uint256(credId_).toString(), "-", uint256(credChainId_).toString()));

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

### <a name="NC-4"></a>[NC-4] `constant`s should be defined rather than using magic numbers

Even [assembly](https://github.com/code-423n4/2022-05-opensea-seaport/blob/9d7ce4d08bf3c3010304a0476a785c70c0e90ae7/contracts/lib/TokenTransferrer.sol#L35-L39) can benefit from using readable constants instead of hex/numeric literals

*Instances (13)*:

```solidity
File: src/Cred.sol

34:     uint256 private immutable RATIO_BASE = 10_000;

35:     uint256 private immutable MAX_ROYALTY_RANGE = 5000;

114:         locked = 2;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

101:         locked = 2;

423:         if (protocolFee_ > 10_000) revert ProtocolFeeTooHigh();

431:         if (artCreateFee_ > 10_000) revert ArtCreatFeeTooHigh();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/Claimable.sol

80:         if (msg.data.length < 260) revert InvalidMerkleClaimData();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/Claimable.sol)

```solidity
File: src/abstract/CreatorRoyaltiesControl.sol

34:         return RoyaltyConfiguration({ royaltyBPS: 500, royaltyRecipient: royaltyRecipient });

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/CreatorRoyaltiesControl.sol)

```solidity
File: src/curve/BondingCurve.sol

21:     uint256 private immutable RATIO_BASE = 10_000;

119:             - CURVE_FACTOR * 1 ether - INITIAL_PRICE_FACTOR * targetAmount_ / 1000;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/curve/BondingCurve.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

29:     uint256 private withdrawRoyalty = 100;

30:     uint256 private immutable RATIO_BASE = 10_000;

31:     uint256 private immutable MAX_ROYALTY_RANGE = 1000;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

### <a name="NC-5"></a>[NC-5] Control structures do not follow the Solidity Style Guide

See the [control structures](https://docs.soliditylang.org/en/latest/style-guide.html#control-structures) section of the Solidity Style Guide

*Instances (127)*:

```solidity
File: src/Cred.sol

110:                                MODIFIERS

113:         if (locked != 1) revert Reentrancy();

120:         if (address_ == address(0)) revert InvalidAddressZero();

187:         if (curator_ == address(0)) revert InvalidAddressZero();

203:         if (totalCost > msg.value) revert InsufficientBatchPayment();

243:         if (_recoverSigner(keccak256(signedData_), signature_) != phiSignerAddress) revert AddressNotSigned();

251:             string memory verificationType,

254:         if (expiresIn <= block.timestamp) revert SignatureExpired();

256:         if (sender != _msgSender()) revert Unauthorized();

258:         if (!curatePriceWhitelist[bondingCurve]) revert Unauthorized();

267:             revert InvalidVerificationType();

274:             creator_, credURL, credType, verificationType, bondingCurve, buyShareRoyalty_, sellShareRoyalty_

292:         if (_recoverSigner(keccak256(signedData_), signature_) != phiSignerAddress) revert AddressNotSigned();

295:         if (expiresIn_ <= block.timestamp) revert SignatureExpired();

297:         if (sender != _msgSender()) revert Unauthorized();

299:         if (creds[credId].creator != _msgSender()) revert Unauthorized();

548:         string memory verificationType_,

564:         creds[credIdCounter].verificationType = verificationType_;

572:         emit CredCreated(creator_, credIdCounter, credURL_, credType_, verificationType_);

615:             if (priceLimit != 0 && price + protocolFee + creatorFee > priceLimit) revert PriceExceedsLimit();

624:             if (priceLimit != 0 && price - protocolFee - creatorFee < priceLimit) revert PriceBelowLimit();

697:         if (_credIdsPerAddress[sender_].length == 0) revert EmptyArray();

702:         if (indexToRemove >= _credIdsPerAddress[sender_].length) revert IndexOutofBounds();

706:         if (credId_ != credIdToRemove) revert WrongCredId();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

4: import { IPhiFactory } from "./interfaces/IPhiFactory.sol";

95:                                MODIFIERS

100:         if (locked != 1) revert Reentrancy();

107:         if (address_ == address(0)) revert InvalidAddressZero();

112:         if (arts[artId_].artist != _msgSender()) revert NotArtCreator();

289:                 address verifier_,

297:             bytes memory claimData = abi.encode(expiresIn_, minter_, ref_, verifier_, artId, block.chainid, data_);

302:             revert InvalidVerificationType();

309:         if (encodeDatas_.length != ethValue_.length) revert ArrayLengthMismatch();

316:         if (msg.value != totalEthValue) revert InvalidEthValue();

336:         (uint256 expiresIn_, address minter_, address ref_, address verifier_, uint256 artId_,, bytes32 data_) =

339:         if (expiresIn_ <= block.timestamp) revert SignatureExpired();

340:         if (_recoverSigner(keccak256(encodeData_), signature_) != phiSignerAddress) revert AddressNotSigned();

343:         _processClaim(artId_, minter_, ref_, verifier_, mintArgs_.quantity, data_, mintArgs_.imageURI, msg.value);

345:         emit ArtClaimedData(artId_, "SIGNATURE", minter_, ref_, verifier_, arts[artId_].artAddress, mintArgs_.quantity);

369:         if (

370:             !MerkleProofLib.verifyCalldata(

423:         if (protocolFee_ > 10_000) revert ProtocolFeeTooHigh();

431:         if (artCreateFee_ > 10_000) revert ArtCreatFeeTooHigh();

476:         if (thisArt.artAddress == address(0)) revert ArtNotCreated();

485:             verificationType: thisArt.verificationType,

542:         return MerkleProofLib.verifyCalldata(proof, root, leaf);

557:         (uint256 credId,, string memory verificationType, uint256 credChainId,) =

562:             artAddress = _createNewNFTContract(currentArt, newArtId, createData_, credId, credChainId, verificationType);

584:         if (arts[createData_.artId].artAddress != address(0)) revert ArtAlreadyCreated();

585:         if (createData_.endTime <= block.timestamp) revert EndTimeInPast();

586:         if (createData_.endTime <= createData_.startTime) revert EndTimeLessThanOrEqualToStartTime();

590:         if (_recoverSigner(keccak256(signedData_), signature_) != phiSignerAddress) revert AddressNotSigned();

592:         if (expiresIn_ <= block.timestamp) revert SignatureExpired();

599:             string memory verificationType,

607:         art.verificationType = verificationType;

626:         string memory verificationType

636:         IPhiNFT1155Ownable(newArt).initialize(credChainId, credId, verificationType, protocolFeeDestination);

643:         if (!success_) revert CreateFailed();

666:         if (!success_) revert CreateFailed();

709:         if (msg.value < getArtMintFee(artId_, quantity_)) revert InvalidMintFee();

710:         if (block.timestamp < art.startTime) revert ArtNotStarted();

711:         if (block.timestamp > art.endTime) revert ArtEnded();

712:         if (quantity_ == 0) revert InvalidQuantity();

713:         if (art.numberMinted + quantity_ > art.maxSupply) revert OverMaxAllowedToMint();

727:         address verifier_,

750:                 verifier_,

757:         if (!success_) revert ClaimFailed();

774:                 "The cred is verified using ",

775:                 art.verificationType,

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/Claimable.sol

4: import { IPhiFactory } from "../interfaces/IPhiFactory.sol";

15:     function getPhiFactoryContract() public view virtual returns (IPhiFactory);

27:             address verifier_,

38:         bytes memory claimData_ = abi.encode(expiresIn_, minter_, ref_, verifier_, artId, block.chainid, data_);

41:         IPhiFactory phiFactoryContract = getPhiFactoryContract();

42:         IPhiFactory.MintArgs memory mintArgs_ = IPhiFactory.MintArgs(tokenId_, quantity_, imageURI_);

59:         IPhiFactory phiFactory = getPhiFactoryContract();

63:         IPhiFactory.MintArgs memory mintArgs = IPhiFactory.MintArgs(tokenId, quantity, imageURI);

80:         if (msg.data.length < 260) revert InvalidMerkleClaimData();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/Claimable.sol)

```solidity
File: src/abstract/CreatorRoyaltiesControl.sol

18:         if (_royaltyRecipient == address(0)) revert InvalidRoyaltyRecipient();

19:         if (initilaized) revert AlreadyInitialized();

28:         if (!initilaized) revert NotInitialized();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/CreatorRoyaltiesControl.sol)

```solidity
File: src/abstract/RewardControl.sol

40:         if (to == address(0)) revert InvalidAddressZero();

101:         if (block.timestamp > deadline) revert DeadlineExpired();

102:         if (!_verifySignature(from, to, amount, nonces[from], deadline, sig)) revert InvalidSignature();

123:         if (to == address(0)) revert InvalidAddressZero();

130:         if (amount > balance) revert InvalidAmount();

146:     function _verifySignature(

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/RewardControl.sol)

```solidity
File: src/art/PhiNFT1155.sol

5: import { IPhiFactory } from "../interfaces/IPhiFactory.sol";

41:     IPhiFactory public phiFactoryContract;

52:     string public verificationType;

73:                                MODIFIERS

79:         address artist = phiFactoryContract.artData(artId).artist;

80:         if (msg.sender != artist && msg.sender != owner()) revert NotArtCreator();

86:         if (msg.sender != address(phiFactoryContract)) revert NotPhiFactory();

99:         string memory verificationType_,

120:         phiFactoryContract = IPhiFactory(payable(msg.sender));

122:         protocolFeeDestination = phiFactoryContract.protocolFeeDestination();

123:         verificationType = verificationType_;

124:         emit InitializePhiNFT1155(credId_, verificationType_);

142:         uint256 artFee = phiFactoryContract.artCreateFee();

168:         address verifier_,

176:         onlyPhiFactory

183:         address aristRewardReceiver = phiFactoryContract.artData(artId_).receiver;

184:         bytes memory addressesData_ = abi.encode(minter_, aristRewardReceiver, ref_, verifier_);

189:         emit ArtClaimedData(minter_, aristRewardReceiver, ref_, verifier_, artId_, tokenId_, quantity_, data_);

228:         return phiFactoryContract.contractURI(address(this));

235:         return phiFactoryContract.getTokenURI(_tokenIdToArtId[tokenId_]);

245:             return phiFactoryContract.getTokenURI(_tokenIdToArtId[tokenId_]);

252:         return phiFactoryContract;

264:         return phiFactoryContract.artData(artId_);

268:         return phiFactoryContract.artData(_tokenIdToArtId[tokenId_]).mintFee;

272:         return phiFactoryContract.artData(_tokenIdToArtId[tokenId_]).soulBounded;

317:         if (from_ != address(0) && soulBounded(id_)) revert TokenNotTransferable();

343:             if (from_ != address(0) && soulBounded(ids_[i])) revert TokenNotTransferable();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

69:         if (!credContract.isExist(credId)) revert InvalidCredId();

78:         if (!credContract.isExist(credId)) revert InvalidCredId();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

```solidity
File: src/reward/PhiRewards.sol

26:     uint256 public verifierReward = 0.00005 ether;

54:         verifierReward = newVerifyReward_;

55:         emit VerifierRewardUpdated(newVerifyReward_);

84:         uint256 verifierTotalReward_,

90:         (address minter_, address receiver_, address referral_, address verifier_) =

104:         balanceOf[verifier_] += verifierTotalReward_;

111:             rewardsData = abi.encode(artistTotalReward_, referralTotalReward_, verifierTotalReward_, curateTotalReward_);

115:                 abi.encode(artistTotalReward_ + curateTotalReward_, referralTotalReward_, verifierTotalReward_, 0);

120:         emit RewardsDeposit(credData, minter_, receiver_, referral_, verifier_, rewardsData);

144:             quantity_ * verifierReward,

154:         return quantity_ * (artistReward + mintFee_ + referralReward + verifierReward + curateReward);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/PhiRewards.sol)

### <a name="NC-6"></a>[NC-6] Delete rogue `console.log` imports

These shouldn't be deployed in production

*Instances (2)*:

```solidity
File: src/curve/BondingCurve.sol

9: import { console2 } from "forge-std/console2.sol";

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/curve/BondingCurve.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

12: import { console2 } from "forge-std/console2.sol";

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

### <a name="NC-7"></a>[NC-7] Consider disabling `renounceOwnership()`

If the plan for your project does not include eventually giving up all ownership control, consider overwriting OpenZeppelin's `Ownable`'s `renounceOwnership()` function in order to disable it.

*Instances (5)*:

```solidity
File: src/Cred.sol

19: contract Cred is Initializable, UUPSUpgradeable, Ownable2StepUpgradeable, PausableUpgradeable, ICred {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

22: contract PhiFactory is Initializable, UUPSUpgradeable, Ownable2StepUpgradeable, PausableUpgradeable, IPhiFactory {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/curve/BondingCurve.sol

12: contract BondingCurve is Ownable2Step, IBondingCurve {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/curve/BondingCurve.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

17: contract CuratorRewardsDistributor is Logo, Ownable2Step, ICuratorRewardsDistributor {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

```solidity
File: src/reward/PhiRewards.sol

14: contract PhiRewards is Logo, RewardControl, Ownable2Step, IPhiRewards {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/PhiRewards.sol)

### <a name="NC-8"></a>[NC-8] Events that mark critical parameter changes should contain both the old and the new value

This should especially be done if the new value is not required to be different from the old value

*Instances (20)*:

```solidity
File: src/Cred.sol

129:     function setPhiSignerAddress(address phiSignerAddress_) external nonZeroAddress(phiSignerAddress_) onlyOwner {
             phiSignerAddress = phiSignerAddress_;
             emit PhiSignerAddressSet(phiSignerAddress_);

136:     function setProtocolFeeDestination(address protocolFeeDestination_)
             external
             nonZeroAddress(protocolFeeDestination_)
             onlyOwner
         {
             protocolFeeDestination = protocolFeeDestination_;
             emit ProtocolFeeDestinationChanged(_msgSender(), protocolFeeDestination_);

147:     function setProtocolFeePercent(uint256 protocolFeePercent_) external onlyOwner {
             protocolFeePercent = protocolFeePercent_;
             emit ProtocolFeePercentChanged(_msgSender(), protocolFeePercent_);

154:     function setPhiRewardsAddress(address phiRewardsAddress_) external nonZeroAddress(phiRewardsAddress_) onlyOwner {
             phiRewardsAddress = phiRewardsAddress_;
             emit PhiRewardsAddressSet(phiRewardsAddress_);

283:     function updateCred(
             bytes calldata signedData_,
             bytes calldata signature_,
             uint16 buyShareRoyalty_,
             uint16 sellShareRoyalty_
         )
             external
             whenNotPaused
         {
             if (_recoverSigner(keccak256(signedData_), signature_) != phiSignerAddress) revert AddressNotSigned();
             (uint256 expiresIn_, address sender,, uint256 credId, string memory credURL) =
                 abi.decode(signedData_, (uint256, address, uint256, uint256, string));
             if (expiresIn_ <= block.timestamp) revert SignatureExpired();
     
             if (sender != _msgSender()) revert Unauthorized();
     
             if (creds[credId].creator != _msgSender()) revert Unauthorized();
             if (buyShareRoyalty_ > MAX_ROYALTY_RANGE || sellShareRoyalty_ > MAX_ROYALTY_RANGE) {
                 revert InvalidRoyaltyRange();
             }
     
             creds[credId].credURL = credURL;
             creds[credId].updatedAt = uint40(block.timestamp);
             creds[credId].buyShareRoyalty = buyShareRoyalty_;
             creds[credId].sellShareRoyalty = sellShareRoyalty_;
     
             emit CredUpdated(_msgSender(), credId, credURL, buyShareRoyalty_, sellShareRoyalty_);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

215:     function updateArtSettings(
             uint256 artId_,
             string memory url_,
             address receiver_,
             uint256 maxSupply_,
             uint256 mintFee_,
             uint256 startTime_,
             uint256 endTime_,
             bool soulBounded_,
             IPhiNFT1155Ownable.RoyaltyConfiguration memory configuration
         )
             external
             onlyArtCreator(artId_)
         {
             if (receiver_ == address(0)) {
                 revert InvalidAddressZero();
             }
     
             if (endTime_ < startTime_) {
                 revert InvalidTimeRange();
             }
             if (endTime_ < block.timestamp) {
                 revert EndTimeInPast();
             }
     
             PhiArt storage art = arts[artId_];
     
             if (art.numberMinted > maxSupply_) {
                 revert ExceedMaxSupply();
             }
     
             art.receiver = receiver_;
             art.maxSupply = maxSupply_;
             art.mintFee = mintFee_;
             art.startTime = startTime_;
             art.endTime = endTime_;
             art.soulBounded = soulBounded_;
             art.uri = url_;
     
             uint256 tokenId = IPhiNFT1155Ownable(art.artAddress).getTokenIdFromFactoryArtId(artId_);
             IPhiNFT1155Ownable(art.artAddress).updateRoyalties(tokenId, configuration);
             emit ArtUpdated(artId_, url_, receiver_, maxSupply_, mintFee_, startTime_, endTime_, soulBounded_);

390:     function setPhiSignerAddress(address phiSignerAddress_) external nonZeroAddress(phiSignerAddress_) onlyOwner {
             phiSignerAddress = phiSignerAddress_;
             emit PhiSignerAddressSet(phiSignerAddress_);

397:     function setPhiRewardsAddress(address phiRewardsAddress_) external nonZeroAddress(phiRewardsAddress_) onlyOwner {
             phiRewardsAddress = phiRewardsAddress_;
             emit PhiRewardsAddressSet(phiRewardsAddress_);

404:     function setErc1155ArtAddress(address erc1155ArtAddress_) external nonZeroAddress(erc1155ArtAddress_) onlyOwner {
             erc1155ArtAddress = erc1155ArtAddress_;
             emit ERC1155ArtAddressSet(erc1155ArtAddress_);

411:     function setProtocolFeeDestination(address protocolFeeDestination_)
             external
             nonZeroAddress(protocolFeeDestination_)
             onlyOwner
         {
             protocolFeeDestination = protocolFeeDestination_;
             emit ProtocolFeeDestinationSet(protocolFeeDestination_);

422:     function setProtocolFee(uint256 protocolFee_) external onlyOwner {
             if (protocolFee_ > 10_000) revert ProtocolFeeTooHigh();
             mintProtocolFee = protocolFee_;
             emit ProtocolFeeSet(protocolFee_);

430:     function setArtCreatFee(uint256 artCreateFee_) external onlyOwner {
             if (artCreateFee_ > 10_000) revert ArtCreatFeeTooHigh();
             artCreateFee = artCreateFee_;
             emit ArtCreatFeeSet(artCreateFee_);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

206:     function setContractURI() external {
             emit ContractURIUpdated();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

49:     function updatePhiRewardsContract(address phiRewardsContract_) external onlyOwner {
            if (phiRewardsContract_ == address(0)) {
                revert InvalidAddressZero();
            }
            phiRewardsContract = IPhiRewards(phiRewardsContract_);
            emit PhiRewardsContractUpdated(phiRewardsContract_);

57:     function updateRoyalty(uint256 newRoyalty_) external onlyOwner {
            if (newRoyalty_ > MAX_ROYALTY_RANGE) {
                revert InvalidRoyalty(newRoyalty_);
            }
            withdrawRoyalty = newRoyalty_;
            emit RoyaltyUpdated(newRoyalty_);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

```solidity
File: src/reward/PhiRewards.sol

39:     function updateArtistReward(uint256 newArtistReward_) external onlyOwner {
            artistReward = newArtistReward_;
            emit ArtistRewardUpdated(newArtistReward_);

46:     function updateReferralReward(uint256 newReferralReward_) external onlyOwner {
            referralReward = newReferralReward_;
            emit ReferralRewardUpdated(newReferralReward_);

53:     function updateVerifierReward(uint256 newVerifyReward_) external onlyOwner {
            verifierReward = newVerifyReward_;
            emit VerifierRewardUpdated(newVerifyReward_);

60:     function updateCurateReward(uint256 newCurateReward_) external onlyOwner {
            curateReward = newCurateReward_;
            emit CurateRewardUpdated(newCurateReward_);

68:     function updateCuratorRewardsDistributor(address curatorRewardsDistributor_) external onlyOwner {
            curatorRewardsDistributor = ICuratorRewardsDistributor(curatorRewardsDistributor_);
            emit CuratorRewardsDistributorUpdated(curatorRewardsDistributor_);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/PhiRewards.sol)

### <a name="NC-9"></a>[NC-9] Function ordering does not follow the Solidity style guide

According to the [Solidity style guide](https://docs.soliditylang.org/en/v0.8.17/style-guide.html#order-of-functions), functions should be laid out in the following order :`constructor()`, `receive()`, `fallback()`, `external`, `public`, `internal`, `private`, but the cases below do not follow this pattern

*Instances (8)*:

```solidity
File: src/Cred.sol

1: 
   Current order:
   external initialize
   public version
   external pause
   external unPause
   external setPhiSignerAddress
   external setProtocolFeeDestination
   external setProtocolFeePercent
   external setPhiRewardsAddress
   external addToWhitelist
   external removeFromWhitelist
   public buyShareCred
   public sellShareCred
   public buyShareCredFor
   public batchBuyShareCred
   public batchSellShareCred
   public createCred
   external updateCred
   external getCredBuyPrice
   external getCredSellPrice
   external getCredBuyPriceWithFee
   external getCredSellPriceWithFee
   external getBatchBuyPrice
   external getBatchSellPrice
   public isExist
   external getCredCreator
   external getCurrentSupply
   public getCreatorRoyalty
   external credInfo
   public isShareHolder
   external getShareNumber
   external getCuratorAddressLength
   public getCuratorAddresses
   public getCuratorAddressesWithAmount
   external getPositionsForCurator
   public getRoot
   internal _createCredInternal
   internal _handleTrade
   internal _updateCuratorShareBalance
   public _addCredIdPerAddress
   public _removeCredIdPerAddress
   internal _executeBatchTrade
   internal _executeBatchBuy
   internal _executeBatchSell
   internal _validateAndCalculateBatch
   private _recoverSigner
   internal _getCuratorData
   internal _authorizeUpgrade
   
   Suggested order:
   external initialize
   external pause
   external unPause
   external setPhiSignerAddress
   external setProtocolFeeDestination
   external setProtocolFeePercent
   external setPhiRewardsAddress
   external addToWhitelist
   external removeFromWhitelist
   external updateCred
   external getCredBuyPrice
   external getCredSellPrice
   external getCredBuyPriceWithFee
   external getCredSellPriceWithFee
   external getBatchBuyPrice
   external getBatchSellPrice
   external getCredCreator
   external getCurrentSupply
   external credInfo
   external getShareNumber
   external getCuratorAddressLength
   external getPositionsForCurator
   public version
   public buyShareCred
   public sellShareCred
   public buyShareCredFor
   public batchBuyShareCred
   public batchSellShareCred
   public createCred
   public isExist
   public getCreatorRoyalty
   public isShareHolder
   public getCuratorAddresses
   public getCuratorAddressesWithAmount
   public getRoot
   public _addCredIdPerAddress
   public _removeCredIdPerAddress
   internal _createCredInternal
   internal _handleTrade
   internal _updateCuratorShareBalance
   internal _executeBatchTrade
   internal _executeBatchBuy
   internal _executeBatchSell
   internal _validateAndCalculateBatch
   internal _getCuratorData
   internal _authorizeUpgrade
   private _recoverSigner

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

1: 
   Current order:
   public version
   public contractURI
   external initialize
   external pause
   external unPause
   external pauseArtContract
   external unPauseArtContract
   external pauseArtContract
   external unPauseArtContract
   external createArt
   external updateArtSettings
   external claim
   external batchClaim
   external signatureClaim
   external merkleClaim
   external setPhiSignerAddress
   external setPhiRewardsAddress
   external setErc1155ArtAddress
   external setProtocolFeeDestination
   external setProtocolFee
   external setArtCreatFee
   external isCredMinted
   external isArtMinted
   external getArtAddress
   external getNumberMinted
   external getTokenURI
   external artData
   public getArtMintFee
   external getTotalMintFee
   public checkProof
   internal createERC1155Internal
   internal _authorizeUpgrade
   private _recoverSigner
   private _validateArtCreation
   private _validateArtCreationSignature
   private _initializePhiArt
   private _createNewNFTContract
   private _useExistingNFTContract
   private _createERC1155Data
   private _validateAndUpdateClaimState
   private _processClaim
   internal _buildDescription
   external withdraw
   
   Suggested order:
   external initialize
   external pause
   external unPause
   external pauseArtContract
   external unPauseArtContract
   external pauseArtContract
   external unPauseArtContract
   external createArt
   external updateArtSettings
   external claim
   external batchClaim
   external signatureClaim
   external merkleClaim
   external setPhiSignerAddress
   external setPhiRewardsAddress
   external setErc1155ArtAddress
   external setProtocolFeeDestination
   external setProtocolFee
   external setArtCreatFee
   external isCredMinted
   external isArtMinted
   external getArtAddress
   external getNumberMinted
   external getTokenURI
   external artData
   external getTotalMintFee
   external withdraw
   public version
   public contractURI
   public getArtMintFee
   public checkProof
   internal createERC1155Internal
   internal _authorizeUpgrade
   internal _buildDescription
   private _recoverSigner
   private _validateArtCreation
   private _validateArtCreationSignature
   private _initializePhiArt
   private _createNewNFTContract
   private _useExistingNFTContract
   private _createERC1155Data
   private _validateAndUpdateClaimState
   private _processClaim

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/Claimable.sol

1: 
   Current order:
   public getPhiFactoryContract
   public getFactoryArtId
   external signatureClaim
   external merkleClaim
   private _decodeMerkleClaimData
   
   Suggested order:
   external signatureClaim
   external merkleClaim
   public getPhiFactoryContract
   public getFactoryArtId
   private _decodeMerkleClaimData

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/Claimable.sol)

```solidity
File: src/abstract/CreatorRoyaltiesControl.sol

1: 
   Current order:
   internal initializeRoyalties
   public getRoyalties
   public royaltyInfo
   internal _updateRoyalties
   public supportsInterface
   
   Suggested order:
   public getRoyalties
   public royaltyInfo
   public supportsInterface
   internal initializeRoyalties
   internal _updateRoyalties

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/CreatorRoyaltiesControl.sol)

```solidity
File: src/abstract/RewardControl.sol

1: 
   Current order:
   external deposit
   external depositBatch
   external withdraw
   external withdrawFor
   external withdrawWithSig
   external totalSupply
   internal _withdraw
   internal _domainNameAndVersion
   internal _verifySignature
   public hashTypedData
   
   Suggested order:
   external deposit
   external depositBatch
   external withdraw
   external withdrawFor
   external withdrawWithSig
   external totalSupply
   public hashTypedData
   internal _withdraw
   internal _domainNameAndVersion
   internal _verifySignature

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/RewardControl.sol)

```solidity
File: src/art/PhiNFT1155.sol

1: 
   Current order:
   public version
   external initialize
   external pause
   external unPause
   external createArtFromFactory
   external claimFromFactory
   external updateRoyalties
   external setContractURI
   public supportsInterface
   public contractURI
   public uri
   public uri
   public getPhiFactoryContract
   public getTokenIdFromFactoryArtId
   public getFactoryArtId
   public getArtDataFromFactory
   public mintFee
   public soulBounded
   internal mint
   public safeTransferFrom
   public safeBatchTransferFrom
   internal _authorizeUpgrade
   
   Suggested order:
   external initialize
   external pause
   external unPause
   external createArtFromFactory
   external claimFromFactory
   external updateRoyalties
   external setContractURI
   public version
   public supportsInterface
   public contractURI
   public uri
   public uri
   public getPhiFactoryContract
   public getTokenIdFromFactoryArtId
   public getFactoryArtId
   public getArtDataFromFactory
   public mintFee
   public soulBounded
   public safeTransferFrom
   public safeBatchTransferFrom
   internal mint
   internal _authorizeUpgrade

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/curve/BondingCurve.sol

1: 
   Current order:
   external setCredContract
   external getCredContract
   public getPrice
   public getPriceData
   public getBuyPrice
   public getBuyPriceAfterFee
   public getSellPrice
   public getSellPriceAfterFee
   private _curve
   internal _getProtocolFee
   internal _getCreatorFee
   
   Suggested order:
   external setCredContract
   external getCredContract
   public getPrice
   public getPriceData
   public getBuyPrice
   public getBuyPriceAfterFee
   public getSellPrice
   public getSellPriceAfterFee
   internal _getProtocolFee
   internal _getCreatorFee
   private _curve

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/curve/BondingCurve.sol)

```solidity
File: src/reward/PhiRewards.sol

1: 
   Current order:
   external updateArtistReward
   external updateReferralReward
   external updateVerifierReward
   external updateCurateReward
   external updateCuratorRewardsDistributor
   internal depositRewards
   external handleRewardsAndGetValueSent
   public computeMintReward
   
   Suggested order:
   external updateArtistReward
   external updateReferralReward
   external updateVerifierReward
   external updateCurateReward
   external updateCuratorRewardsDistributor
   external handleRewardsAndGetValueSent
   public computeMintReward
   internal depositRewards

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/PhiRewards.sol)

### <a name="NC-10"></a>[NC-10] Functions should not be longer than 50 lines

Overly complex code can make understanding functionality more difficult, try to further modularize your code to ensure readability

*Instances (102)*:

```solidity
File: src/Cred.sol

95:     function version() public pure returns (uint256) {

129:     function setPhiSignerAddress(address phiSignerAddress_) external nonZeroAddress(phiSignerAddress_) onlyOwner {

136:     function setProtocolFeeDestination(address protocolFeeDestination_)

147:     function setProtocolFeePercent(uint256 protocolFeePercent_) external onlyOwner {

154:     function setPhiRewardsAddress(address phiRewardsAddress_) external nonZeroAddress(phiRewardsAddress_) onlyOwner {

163:     function addToWhitelist(address address_) external onlyOwner {

170:     function removeFromWhitelist(address address_) external onlyOwner {

178:     function buyShareCred(uint256 credId_, uint256 amount_, uint256 maxPrice_) public payable {

182:     function sellShareCred(uint256 credId_, uint256 amount_, uint256 minPrice_) public {

186:     function buyShareCredFor(uint256 credId_, uint256 amount_, address curator_, uint256 maxPrice_) public payable {

319:     function getCredBuyPrice(uint256 credId_, uint256 amount_) external view returns (uint256) {

323:     function getCredSellPrice(uint256 credId_, uint256 amount_) external view returns (uint256) {

327:     function getCredBuyPriceWithFee(uint256 credId_, uint256 amount_) external view returns (uint256) {

333:     function getCredSellPriceWithFee(uint256 credId_, uint256 amount_) external view returns (uint256) {

387:     function isExist(uint256 credId_) public view returns (bool) {

391:     function getCredCreator(uint256 credId_) external view returns (address) {

395:     function getCurrentSupply(uint256 credId_) external view returns (uint256) {

399:     function getCreatorRoyalty(uint256 credId_) public view returns (uint16 buyShareRoyalty, uint16 sellShareRoyalty) {

407:     function credInfo(uint256 credId_) external view returns (PhiCred memory) {

418:     function isShareHolder(uint256 credId_, address curator_) public view returns (bool) {

427:     function getShareNumber(uint256 credId_, address curator_) external view returns (uint256) {

431:     function getCuratorAddressLength(uint256 credId_) external view returns (uint256) {

531:     function getRoot(uint256 credId_) public view returns (bytes32) {

666:     function _updateCuratorShareBalance(uint256 credId_, address sender_, uint256 amount_, bool isBuy) internal {

685:     function _addCredIdPerAddress(uint256 credId_, address sender_) public {

695:     function _removeCredIdPerAddress(uint256 credId_, address sender_) public {

888:     function _recoverSigner(bytes32 hash_, bytes memory signature_) private view returns (address) {

937:     function _authorizeUpgrade(address newImplementation) internal override onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

60:     function version() public pure returns (uint256) {

64:     function contractURI(address nftAddress) public view returns (string memory) {

170:     function pauseArtContract(uint256 artId_) external onlyOwner {

176:     function unPauseArtContract(uint256 artId_) external onlyOwner {

180:     function pauseArtContract(address artAddress_) external onlyOwner {

184:     function unPauseArtContract(address artAddress_) external onlyOwner {

264:     function claim(bytes calldata encodeData_) external payable {

308:     function batchClaim(bytes[] calldata encodeDatas_, uint256[] calldata ethValue_) external payable {

390:     function setPhiSignerAddress(address phiSignerAddress_) external nonZeroAddress(phiSignerAddress_) onlyOwner {

397:     function setPhiRewardsAddress(address phiRewardsAddress_) external nonZeroAddress(phiRewardsAddress_) onlyOwner {

404:     function setErc1155ArtAddress(address erc1155ArtAddress_) external nonZeroAddress(erc1155ArtAddress_) onlyOwner {

411:     function setProtocolFeeDestination(address protocolFeeDestination_)

422:     function setProtocolFee(uint256 protocolFee_) external onlyOwner {

430:     function setArtCreatFee(uint256 artCreateFee_) external onlyOwner {

440:     function isCredMinted(uint256 credChainId_, uint256 credId_, address minter_) external view returns (bool) {

448:     function isArtMinted(uint256 artId_, address address_) external view returns (bool) {

455:     function getArtAddress(uint256 artId_) external view returns (address) {

462:     function getNumberMinted(uint256 artId_) external view returns (uint256) {

466:     function getTokenURI(uint256 artId_) external view returns (string memory) {

473:     function artData(uint256 artId_) external view returns (ArtData memory) {

509:     function getArtMintFee(uint256 artId_, uint256 quantity_) public view returns (uint256) {

541:     function checkProof(bytes32[] calldata proof, bytes32 leaf, bytes32 root) public pure returns (bool) {

551:     function createERC1155Internal(uint256 newArtId, ERC1155Data memory createData_) internal returns (address) {

570:     function _authorizeUpgrade(address newImplementation) internal override onlyOwner { }

579:     function _recoverSigner(bytes32 hash_, bytes memory signature_) private view returns (address) {

583:     function _validateArtCreation(ERC1155Data memory createData_) private view {

589:     function _validateArtCreationSignature(bytes calldata signedData_, bytes calldata signature_) private view {

595:     function _initializePhiArt(PhiArt storage art, ERC1155Data memory createData_) private {

702:     function _validateAndUpdateClaimState(uint256 artId_, address minter_, uint256 quantity_) private {

763:     function _buildDescription(PhiArt memory art) internal pure returns (string memory) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/Claimable.sol

15:     function getPhiFactoryContract() public view virtual returns (IPhiFactory);

16:     function getFactoryArtId(uint256 tokenId) public view virtual returns (uint256);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/Claimable.sol)

```solidity
File: src/abstract/CreatorRoyaltiesControl.sol

17:     function initializeRoyalties(address _royaltyRecipient) internal {

27:     function getRoyalties(uint256 tokenId) public view returns (RoyaltyConfiguration memory) {

58:     function _updateRoyalties(uint256 tokenId, RoyaltyConfiguration memory configuration) internal {

71:     function supportsInterface(bytes4 interfaceId) public view virtual returns (bool) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/CreatorRoyaltiesControl.sol)

```solidity
File: src/abstract/RewardControl.sol

39:     function deposit(address to, bytes4 reason, string calldata comment) external payable {

92:     function withdraw(address to, uint256 amount) external {

96:     function withdrawFor(address from, uint256 amount) external {

100:     function withdrawWithSig(address from, address to, uint256 amount, uint256 deadline, bytes calldata sig) external {

115:     function totalSupply() external view returns (uint256) {

122:     function _withdraw(address from, address to, uint256 amount) internal {

141:     function _domainNameAndVersion() internal pure override returns (string memory name, string memory version) {

164:     function hashTypedData(bytes32 structHash) public view returns (bytes32) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/RewardControl.sol)

```solidity
File: src/art/PhiNFT1155.sol

68:     function version() public pure returns (uint256) {

138:     function createArtFromFactory(uint256 artId_) external payable onlyPhiFactory whenNotPaused returns (uint256) {

227:     function contractURI() public view returns (string memory) {

234:     function uri(uint256 tokenId_) public view override returns (string memory) {

241:     function uri(uint256 tokenId_, address minter_) public view returns (string memory) {

251:     function getPhiFactoryContract() public view override returns (IPhiFactory) {

255:     function getTokenIdFromFactoryArtId(uint256 artId_) public view returns (uint256 tokenId) {

259:     function getFactoryArtId(uint256 tokenId_) public view override(Claimable, IPhiNFT1155) returns (uint256) {

263:     function getArtDataFromFactory(uint256 artId_) public view returns (IPhiFactory.ArtData memory) {

267:     function mintFee(uint256 tokenId_) public view returns (uint256) {

271:     function soulBounded(uint256 tokenId_) public view returns (bool) {

352:     function _authorizeUpgrade(address newImplementation) internal override onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/curve/BondingCurve.sol

34:     function setCredContract(address credContract_) external onlyOwner {

43:     function getCredContract() external view returns (address) {

47:     function getPrice(uint256 supply_, uint256 amount_) public pure returns (uint256) {

78:     function getBuyPrice(uint256 supply_, uint256 amount_) public pure returns (uint256) {

86:     function getBuyPriceAfterFee(uint256 credId_, uint256 supply_, uint256 amount_) public view returns (uint256) {

98:     function getSellPrice(uint256 supply_, uint256 amount_) public pure returns (uint256) {

106:     function getSellPriceAfterFee(uint256 credId_, uint256 supply_, uint256 amount_) public view returns (uint256) {

117:     function _curve(uint256 targetAmount_) private pure returns (uint256) {

123:     function _getProtocolFee(uint256 price_) internal view returns (uint256) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/curve/BondingCurve.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

49:     function updatePhiRewardsContract(address phiRewardsContract_) external onlyOwner {

57:     function updateRoyalty(uint256 newRoyalty_) external onlyOwner {

68:     function deposit(uint256 credId, uint256 amount) external payable {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

```solidity
File: src/reward/PhiRewards.sol

39:     function updateArtistReward(uint256 newArtistReward_) external onlyOwner {

46:     function updateReferralReward(uint256 newReferralReward_) external onlyOwner {

53:     function updateVerifierReward(uint256 newVerifyReward_) external onlyOwner {

60:     function updateCurateReward(uint256 newCurateReward_) external onlyOwner {

68:     function updateCuratorRewardsDistributor(address curatorRewardsDistributor_) external onlyOwner {

153:     function computeMintReward(uint256 quantity_, uint256 mintFee_) public view returns (uint256) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/PhiRewards.sol)

### <a name="NC-11"></a>[NC-11] Change int to int256

Throughout the code base, some variables are declared as `int`. To favor explicitness, consider changing all instances of `int` to `int256`

*Instances (1)*:

```solidity
File: src/PhiFactory.sol

504:                              MINT FEE CALCULATION

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

### <a name="NC-12"></a>[NC-12] Lack of checks in setters

Be it sanity checks (like checks against `0`-values) or initial setting checks: it's best for Setter functions to have them

*Instances (16)*:

```solidity
File: src/Cred.sol

129:     function setPhiSignerAddress(address phiSignerAddress_) external nonZeroAddress(phiSignerAddress_) onlyOwner {
             phiSignerAddress = phiSignerAddress_;
             emit PhiSignerAddressSet(phiSignerAddress_);

136:     function setProtocolFeeDestination(address protocolFeeDestination_)
             external
             nonZeroAddress(protocolFeeDestination_)
             onlyOwner
         {
             protocolFeeDestination = protocolFeeDestination_;
             emit ProtocolFeeDestinationChanged(_msgSender(), protocolFeeDestination_);

147:     function setProtocolFeePercent(uint256 protocolFeePercent_) external onlyOwner {
             protocolFeePercent = protocolFeePercent_;
             emit ProtocolFeePercentChanged(_msgSender(), protocolFeePercent_);

154:     function setPhiRewardsAddress(address phiRewardsAddress_) external nonZeroAddress(phiRewardsAddress_) onlyOwner {
             phiRewardsAddress = phiRewardsAddress_;
             emit PhiRewardsAddressSet(phiRewardsAddress_);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

390:     function setPhiSignerAddress(address phiSignerAddress_) external nonZeroAddress(phiSignerAddress_) onlyOwner {
             phiSignerAddress = phiSignerAddress_;
             emit PhiSignerAddressSet(phiSignerAddress_);

397:     function setPhiRewardsAddress(address phiRewardsAddress_) external nonZeroAddress(phiRewardsAddress_) onlyOwner {
             phiRewardsAddress = phiRewardsAddress_;
             emit PhiRewardsAddressSet(phiRewardsAddress_);

404:     function setErc1155ArtAddress(address erc1155ArtAddress_) external nonZeroAddress(erc1155ArtAddress_) onlyOwner {
             erc1155ArtAddress = erc1155ArtAddress_;
             emit ERC1155ArtAddressSet(erc1155ArtAddress_);

411:     function setProtocolFeeDestination(address protocolFeeDestination_)
             external
             nonZeroAddress(protocolFeeDestination_)
             onlyOwner
         {
             protocolFeeDestination = protocolFeeDestination_;
             emit ProtocolFeeDestinationSet(protocolFeeDestination_);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

195:     function updateRoyalties(
             uint256 tokenId_,
             RoyaltyConfiguration memory configuration
         )
             external
             onlyArtCreator(tokenId_)
         {
             _updateRoyalties(tokenId_, configuration);

206:     function setContractURI() external {
             emit ContractURIUpdated();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/curve/BondingCurve.sol

34:     function setCredContract(address credContract_) external onlyOwner {
            credContract = ICred(credContract_);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/curve/BondingCurve.sol)

```solidity
File: src/reward/PhiRewards.sol

39:     function updateArtistReward(uint256 newArtistReward_) external onlyOwner {
            artistReward = newArtistReward_;
            emit ArtistRewardUpdated(newArtistReward_);

46:     function updateReferralReward(uint256 newReferralReward_) external onlyOwner {
            referralReward = newReferralReward_;
            emit ReferralRewardUpdated(newReferralReward_);

53:     function updateVerifierReward(uint256 newVerifyReward_) external onlyOwner {
            verifierReward = newVerifyReward_;
            emit VerifierRewardUpdated(newVerifyReward_);

60:     function updateCurateReward(uint256 newCurateReward_) external onlyOwner {
            curateReward = newCurateReward_;
            emit CurateRewardUpdated(newCurateReward_);

68:     function updateCuratorRewardsDistributor(address curatorRewardsDistributor_) external onlyOwner {
            curatorRewardsDistributor = ICuratorRewardsDistributor(curatorRewardsDistributor_);
            emit CuratorRewardsDistributorUpdated(curatorRewardsDistributor_);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/PhiRewards.sol)

### <a name="NC-13"></a>[NC-13] Missing Event for critical parameters change

Events help non-contract tools to track changes, and events prevent users from being surprised by changes.

*Instances (2)*:

```solidity
File: src/art/PhiNFT1155.sol

195:     function updateRoyalties(
             uint256 tokenId_,
             RoyaltyConfiguration memory configuration
         )
             external
             onlyArtCreator(tokenId_)
         {
             _updateRoyalties(tokenId_, configuration);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/curve/BondingCurve.sol

34:     function setCredContract(address credContract_) external onlyOwner {
            credContract = ICred(credContract_);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/curve/BondingCurve.sol)

### <a name="NC-14"></a>[NC-14] NatSpec is completely non-existent on functions that should have them

Public and external functions that aren't view or pure should have NatSpec comments

*Instances (20)*:

```solidity
File: src/Cred.sol

178:     function buyShareCred(uint256 credId_, uint256 amount_, uint256 maxPrice_) public payable {

182:     function sellShareCred(uint256 credId_, uint256 amount_, uint256 minPrice_) public {

186:     function buyShareCredFor(uint256 credId_, uint256 amount_, address curator_, uint256 maxPrice_) public payable {

191:     function batchBuyShareCred(

213:     function batchSellShareCred(

685:     function _addCredIdPerAddress(uint256 credId_, address sender_) public {

695:     function _removeCredIdPerAddress(uint256 credId_, address sender_) public {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

180:     function pauseArtContract(address artAddress_) external onlyOwner {

184:     function unPauseArtContract(address artAddress_) external onlyOwner {

215:     function updateArtSettings(

786:     function withdraw() external onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/RewardControl.sol

92:     function withdraw(address to, uint256 amount) external {

96:     function withdrawFor(address from, uint256 amount) external {

100:     function withdrawWithSig(address from, address to, uint256 amount, uint256 deadline, bytes calldata sig) external {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/RewardControl.sol)

```solidity
File: src/art/PhiNFT1155.sol

195:     function updateRoyalties(

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

49:     function updatePhiRewardsContract(address phiRewardsContract_) external onlyOwner {

57:     function updateRoyalty(uint256 newRoyalty_) external onlyOwner {

68:     function deposit(uint256 credId, uint256 amount) external payable {

77:     function distribute(uint256 credId) external {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

```solidity
File: src/reward/PhiRewards.sol

123:     function handleRewardsAndGetValueSent(

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/PhiRewards.sol)

### <a name="NC-15"></a>[NC-15] Incomplete NatSpec: `@param` is missing on actually documented functions

The following functions are missing `@param` NatSpec comments.

*Instances (12)*:

```solidity
File: src/Cred.sol

64:     /// @notice Initializes the contract.
        /// @param ownerAddress_ The address of the contract owner.
        /// @param protocolFeeDestination_ The address to receive protocol fees.
        /// @param protocolFeePercent_ The percentage of protocol fees. (100 = 1%)
        /// @param bondingCurveAddress_ The address of the CuratePrice contract.
        function initialize(
            address phiSignerAddress_,
            address ownerAddress_,
            address protocolFeeDestination_,
            uint256 protocolFeePercent_,
            address bondingCurveAddress_,
            address phiRewardsAddress_

162:     /// @notice Adds an address to the whitelist.
         function addToWhitelist(address address_) external onlyOwner {

231:     /// @notice Creates a new cred.
         function createCred(
             address creator_,
             bytes calldata signedData_,
             bytes calldata signature_,
             uint16 buyShareRoyalty_,
             uint16 sellShareRoyalty_

282:     /// @notice Updates the URL of a cred.
         function updateCred(
             bytes calldata signedData_,
             bytes calldata signature_,
             uint16 buyShareRoyalty_,
             uint16 sellShareRoyalty_

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

168:     /// @notice Pause a art contract.
         /// @dev effect to all tokens in a art contract
         function pauseArtContract(uint256 artId_) external onlyOwner {

174:     /// @notice unPause a art contract.
         /// @dev effect to all tokens in a art contract
         function unPauseArtContract(uint256 artId_) external onlyOwner {

306:     /// @notice Claims multiple art rewards in a batch.
         /// @param encodeDatas_ The array of encoded claim data.
         function batchClaim(bytes[] calldata encodeDatas_, uint256[] calldata ethValue_) external payable {

348:     /// @notice Claims a art reward using a Merkle proof.
         /// @param proof_ The Merkle proof.
         /// @param encodeData_ The encoded claim data.
         /// @param mintArgs_ The minting arguments.
         function merkleClaim(
             bytes32[] calldata proof_,
             bytes calldata encodeData_,
             MintArgs calldata mintArgs_,
             bytes32 leafPart_

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

93:     /// @notice Initializes the contract.
        /// @param credId_ The cred ID.
        /// @param verificationType_ The verification type.
        function initialize(
            uint256 credChainId_,
            uint256 credId_,
            string memory verificationType_,
            address protocolFeeDestination_

137:     /// @notice Creates a new art from the Phi Factory contract.
         function createArtFromFactory(uint256 artId_) external payable onlyPhiFactory whenNotPaused returns (uint256) {

158:     /// @notice Claims a art token from the Phi Factory contract.
         /// @param minter_ The address claiming the art token.
         /// @param ref_ The referrer address.
         /// @param verifier_ The verifier address.
         /// @param data_ The value associated with the claim.
         /// @param imageURI_ The imageURI associated with the claim.
         function claimFromFactory(
             uint256 artId_,
             address minter_,
             address ref_,
             address verifier_,
             uint256 quantity_,
             bytes32 data_,
             string calldata imageURI_

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/reward/PhiRewards.sol

65:     /// @notice Update curator rewards distributor
        /// @dev This method is only used credential contract is deployed on a same network,
        /// if not, it should be set to address(0)
        function updateCuratorRewardsDistributor(address curatorRewardsDistributor_) external onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/PhiRewards.sol)

### <a name="NC-16"></a>[NC-16] Incomplete NatSpec: `@return` is missing on actually documented functions

The following functions are missing `@return` NatSpec comments.

*Instances (1)*:

```solidity
File: src/art/PhiNFT1155.sol

137:     /// @notice Creates a new art from the Phi Factory contract.
         function createArtFromFactory(uint256 artId_) external payable onlyPhiFactory whenNotPaused returns (uint256) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

### <a name="NC-17"></a>[NC-17] Use a `modifier` instead of a `require/if` statement for a special `msg.sender` actor

If a function is supposed to be access-controlled, a `modifier` should be used instead of a `require/if` statement for more readability.

*Instances (4)*:

```solidity
File: src/PhiFactory.sol

706:         if (tx.origin != _msgSender() && msg.sender != art.artAddress && msg.sender != address(this)) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

80:         if (msg.sender != artist && msg.sender != owner()) revert NotArtCreator();

86:         if (msg.sender != address(phiFactoryContract)) revert NotPhiFactory();

120:         phiFactoryContract = IPhiFactory(payable(msg.sender));

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

### <a name="NC-18"></a>[NC-18] Consider using named mappings

Consider moving to solidity version 0.8.18 or later, and using [named mappings](https://ethereum.stackexchange.com/questions/51629/how-to-name-the-arguments-in-mapping/145555#145555) to make it easier to understand the purpose of each mapping

*Instances (1)*:

```solidity
File: src/PhiFactory.sol

50:     mapping(uint256 credChainId => mapping(uint256 credId => mapping(address => bool))) private credMinted;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

### <a name="NC-19"></a>[NC-19] Owner can renounce while system is paused

The contract owner or single user with a role is not prevented from renouncing the role/ownership while the contract is paused, which would cause any user assets stored in the protocol, to be locked indefinitely.

*Instances (10)*:

```solidity
File: src/Cred.sol

100:     function pause() external onlyOwner {

105:     function unPause() external onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

156:     function pause() external onlyOwner {

161:     function unPause() external onlyOwner {

170:     function pauseArtContract(uint256 artId_) external onlyOwner {

176:     function unPauseArtContract(uint256 artId_) external onlyOwner {

180:     function pauseArtContract(address artAddress_) external onlyOwner {

184:     function unPauseArtContract(address artAddress_) external onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

128:     function pause() external onlyOwner {

133:     function unPause() external onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

### <a name="NC-20"></a>[NC-20] Adding a `return` statement when the function defines a named return variable, is redundant

*Instances (5)*:

```solidity
File: src/Cred.sol

476:     /// @notice Gets the cred IDs and amounts for creds where the given address has a position
         /// @param  curator_ The address to check.
         /// @return credIds The IDs of the creds where the address has a position.
         /// @return amounts The corresponding amounts for each cred.
         function getPositionsForCurator(
             address curator_,
             uint256 start_,
             uint256 stop_
         )
             external
             view
             returns (uint256[] memory credIds, uint256[] memory amounts)
         {
             uint256[] storage userCredIds = _credIdsPerAddress[curator_];
     
             uint256 stopIndex;
             if (userCredIds.length == 0) {
                 return (credIds, amounts);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/abstract/RewardControl.sol

141:     function _domainNameAndVersion() internal pure override returns (string memory name, string memory version) {
             return ("PHI Rewards", "1");

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/RewardControl.sol)

```solidity
File: src/art/PhiNFT1155.sol

255:     function getTokenIdFromFactoryArtId(uint256 artId_) public view returns (uint256 tokenId) {
             return _artIdToTokenId[artId_];

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/curve/BondingCurve.sol

51:     function getPriceData(
            uint256 credId_,
            uint256 supply_,
            uint256 amount_,
            bool isSign_
        )
            public
            view
            returns (uint256 price, uint256 protocolFee, uint256 creatorFee)
        {
            (uint16 buyShareRoyalty, uint16 sellShareRoyalty) = credContract.getCreatorRoyalty(credId_);
    
            price = isSign_ ? getPrice(supply_, amount_) : getPrice(supply_ - amount_, amount_);
    
            protocolFee = _getProtocolFee(price);
            if (supply_ == 0) {
                creatorFee = 0;
                return (price, protocolFee, creatorFee);

127:     /// @dev Returns the creator fee.
         function _getCreatorFee(
             uint256 credId_,
             uint256 supply_,
             uint256 price_,
             bool isSign_
         )
             internal
             view
             returns (uint256 creatorFee)
         {
             if (!credContract.isExist(credId_)) {
                 return 0;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/curve/BondingCurve.sol)

### <a name="NC-21"></a>[NC-21] Take advantage of Custom Error's return value property

An important feature of Custom Error is that values such as address, tokenID, msg.value can be written inside the () sign, this kind of approach provides a serious advantage in debugging and examining the revert details of dapps such as tenderly.

*Instances (98)*:

```solidity
File: src/Cred.sol

84:             revert InvalidAddressZero();

113:         if (locked != 1) revert Reentrancy();

120:         if (address_ == address(0)) revert InvalidAddressZero();

187:         if (curator_ == address(0)) revert InvalidAddressZero();

203:         if (totalCost > msg.value) revert InsufficientBatchPayment();

243:         if (_recoverSigner(keccak256(signedData_), signature_) != phiSignerAddress) revert AddressNotSigned();

254:         if (expiresIn <= block.timestamp) revert SignatureExpired();

256:         if (sender != _msgSender()) revert Unauthorized();

258:         if (!curatePriceWhitelist[bondingCurve]) revert Unauthorized();

261:             revert InvalidCredType();

264:             revert InvalidMerkleRoot();

267:             revert InvalidVerificationType();

270:             revert InvalidRoyaltyRange();

292:         if (_recoverSigner(keccak256(signedData_), signature_) != phiSignerAddress) revert AddressNotSigned();

295:         if (expiresIn_ <= block.timestamp) revert SignatureExpired();

297:         if (sender != _msgSender()) revert Unauthorized();

299:         if (creds[credId].creator != _msgSender()) revert Unauthorized();

301:             revert InvalidRoyaltyRange();

502:             revert InvalidPaginationParameters();

558:             revert InvalidAddressZero();

599:             revert InvalidAmount();

603:             revert InvalidCredId();

615:             if (priceLimit != 0 && price + protocolFee + creatorFee > priceLimit) revert PriceExceedsLimit();

617:                 revert MaxSupplyReached();

621:                 revert InsufficientPayment();

624:             if (priceLimit != 0 && price - protocolFee - creatorFee < priceLimit) revert PriceBelowLimit();

632:                 revert InsufficientShares();

697:         if (_credIdsPerAddress[sender_].length == 0) revert EmptyArray();

702:         if (indexToRemove >= _credIdsPerAddress[sender_].length) revert IndexOutofBounds();

706:         if (credId_ != credIdToRemove) revert WrongCredId();

748:             revert InvalidAddressZero();

827:             revert InvalidArrayLength();

830:             revert EmptyBatchOperation();

842:                 revert InvalidAmount();

845:                 revert InvalidCredId();

850:                     revert DuplicateCredId();

862:                     revert PriceExceedsLimit();

865:                     revert MaxSupplyReached();

869:                     revert PriceBelowLimit();

873:                     revert InsufficientShares();

914:             revert InvalidPaginationParameters();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

100:         if (locked != 1) revert Reentrancy();

107:         if (address_ == address(0)) revert InvalidAddressZero();

112:         if (arts[artId_].artist != _msgSender()) revert NotArtCreator();

230:             revert InvalidAddressZero();

234:             revert InvalidTimeRange();

237:             revert EndTimeInPast();

243:             revert ExceedMaxSupply();

302:             revert InvalidVerificationType();

309:         if (encodeDatas_.length != ethValue_.length) revert ArrayLengthMismatch();

316:         if (msg.value != totalEthValue) revert InvalidEthValue();

339:         if (expiresIn_ <= block.timestamp) revert SignatureExpired();

340:         if (_recoverSigner(keccak256(encodeData_), signature_) != phiSignerAddress) revert AddressNotSigned();

367:             revert InvalidMerkleProof();

374:             revert InvalidMerkleProof();

423:         if (protocolFee_ > 10_000) revert ProtocolFeeTooHigh();

431:         if (artCreateFee_ > 10_000) revert ArtCreatFeeTooHigh();

476:         if (thisArt.artAddress == address(0)) revert ArtNotCreated();

584:         if (arts[createData_.artId].artAddress != address(0)) revert ArtAlreadyCreated();

585:         if (createData_.endTime <= block.timestamp) revert EndTimeInPast();

586:         if (createData_.endTime <= createData_.startTime) revert EndTimeLessThanOrEqualToStartTime();

590:         if (_recoverSigner(keccak256(signedData_), signature_) != phiSignerAddress) revert AddressNotSigned();

592:         if (expiresIn_ <= block.timestamp) revert SignatureExpired();

643:         if (!success_) revert CreateFailed();

666:         if (!success_) revert CreateFailed();

707:             revert TxOriginMismatch();

709:         if (msg.value < getArtMintFee(artId_, quantity_)) revert InvalidMintFee();

710:         if (block.timestamp < art.startTime) revert ArtNotStarted();

711:         if (block.timestamp > art.endTime) revert ArtEnded();

712:         if (quantity_ == 0) revert InvalidQuantity();

713:         if (art.numberMinted + quantity_ > art.maxSupply) revert OverMaxAllowedToMint();

757:         if (!success_) revert ClaimFailed();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/Claimable.sol

80:         if (msg.data.length < 260) revert InvalidMerkleClaimData();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/Claimable.sol)

```solidity
File: src/abstract/CreatorRoyaltiesControl.sol

18:         if (_royaltyRecipient == address(0)) revert InvalidRoyaltyRecipient();

19:         if (initilaized) revert AlreadyInitialized();

28:         if (!initilaized) revert NotInitialized();

60:             revert InvalidRoyaltyRecipient();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/CreatorRoyaltiesControl.sol)

```solidity
File: src/abstract/RewardControl.sol

40:         if (to == address(0)) revert InvalidAddressZero();

66:             revert ArrayLengthMismatch();

75:             revert InvalidDeposit();

83:                 revert InvalidAddressZero();

101:         if (block.timestamp > deadline) revert DeadlineExpired();

102:         if (!_verifySignature(from, to, amount, nonces[from], deadline, sig)) revert InvalidSignature();

123:         if (to == address(0)) revert InvalidAddressZero();

130:         if (amount > balance) revert InvalidAmount();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/RewardControl.sol)

```solidity
File: src/art/PhiNFT1155.sol

80:         if (msg.sender != artist && msg.sender != owner()) revert NotArtCreator();

86:         if (msg.sender != address(phiFactoryContract)) revert NotPhiFactory();

180:             revert InValdidTokenId();

317:         if (from_ != address(0) && soulBounded(id_)) revert TokenNotTransferable();

343:             if (from_ != address(0) && soulBounded(ids_[i])) revert TokenNotTransferable();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

39:             revert InvalidAddressZero();

51:             revert InvalidAddressZero();

69:         if (!credContract.isExist(credId)) revert InvalidCredId();

78:         if (!credContract.isExist(credId)) revert InvalidCredId();

81:             revert NoBalanceToDistribute();

92:             revert NoSharesToDistribute();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

```solidity
File: src/reward/PhiRewards.sol

94:             revert InvalidAddressZero();

135:             revert InvalidDeposit();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/PhiRewards.sol)

### <a name="NC-22"></a>[NC-22] Avoid the use of sensitive terms

Use [alternative variants](https://www.zdnet.com/article/mysql-drops-master-slave-and-blacklist-whitelist-terminology/), e.g. allowlist/denylist instead of whitelist/blacklist

*Instances (10)*:

```solidity
File: src/Cred.sol

49:     mapping(address priceCurve => bool enable) public curatePriceWhitelist;

92:         curatePriceWhitelist[bondingCurveAddress_] = true;

160:                              Whitelist

163:     function addToWhitelist(address address_) external onlyOwner {

164:         curatePriceWhitelist[address_] = true;

165:         emit AddedToWhitelist(_msgSender(), address_);

170:     function removeFromWhitelist(address address_) external onlyOwner {

171:         curatePriceWhitelist[address_] = false;

172:         emit RemovedFromWhitelist(_msgSender(), address_);

258:         if (!curatePriceWhitelist[bondingCurve]) revert Unauthorized();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

### <a name="NC-23"></a>[NC-23] Strings should use double quotes rather than single quotes

See the Solidity Style Guide: <https://docs.soliditylang.org/en/v0.8.20/style-guide.html#other-recommendations>

*Instances (11)*:

```solidity
File: src/PhiFactory.sol

71:                 '"name":"',

73:                 '",',

74:                 '"description":"',

76:                 '",',

77:                 '"image":"',

79:                 '",',

80:                 '"featured_image":"',

82:                 '",',

83:                 '"external_link":"https://phiprotocol.xyz/",',

84:                 '"collaborators":["',

86:                 '"]',

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

### <a name="NC-24"></a>[NC-24] Contract does not follow the Solidity style guide's suggested layout ordering

The [style guide](https://docs.soliditylang.org/en/v0.8.16/style-guide.html#order-of-layout) says that, within a contract, the ordering should be:

1) Type declarations
2) State variables
3) Events
4) Modifiers
5) Functions

However, the contract(s) below do not follow this ordering

*Instances (3)*:

```solidity
File: src/Cred.sol

1: 
   Current order:
   UsingForDirective.SafeTransferLib
   UsingForDirective.LibString
   UsingForDirective.LibString
   UsingForDirective.EnumerableMap.AddressToUintMap
   VariableDeclaration.MAX_SUPPLY
   VariableDeclaration.SHARE_LOCK_PERIOD
   VariableDeclaration.RATIO_BASE
   VariableDeclaration.MAX_ROYALTY_RANGE
   VariableDeclaration.credIdCounter
   VariableDeclaration.protocolFeePercent
   VariableDeclaration.locked
   VariableDeclaration.phiSignerAddress
   VariableDeclaration.protocolFeeDestination
   VariableDeclaration.phiRewardsAddress
   VariableDeclaration.creds
   VariableDeclaration.credsMerkeRoot
   VariableDeclaration.shareBalance
   VariableDeclaration.lastTradeTimestamp
   VariableDeclaration.curatePriceWhitelist
   VariableDeclaration._credIdsPerAddress
   VariableDeclaration._credIdExistsPerAddress
   VariableDeclaration._credIdsPerAddressArrLength
   VariableDeclaration._credIdsPerAddressCredIdIndex
   FunctionDefinition.constructor
   FunctionDefinition.initialize
   FunctionDefinition.version
   FunctionDefinition.pause
   FunctionDefinition.unPause
   ModifierDefinition.nonReentrant
   ModifierDefinition.nonZeroAddress
   FunctionDefinition.setPhiSignerAddress
   FunctionDefinition.setProtocolFeeDestination
   FunctionDefinition.setProtocolFeePercent
   FunctionDefinition.setPhiRewardsAddress
   FunctionDefinition.addToWhitelist
   FunctionDefinition.removeFromWhitelist
   FunctionDefinition.buyShareCred
   FunctionDefinition.sellShareCred
   FunctionDefinition.buyShareCredFor
   FunctionDefinition.batchBuyShareCred
   FunctionDefinition.batchSellShareCred
   FunctionDefinition.createCred
   FunctionDefinition.updateCred
   FunctionDefinition.getCredBuyPrice
   FunctionDefinition.getCredSellPrice
   FunctionDefinition.getCredBuyPriceWithFee
   FunctionDefinition.getCredSellPriceWithFee
   FunctionDefinition.getBatchBuyPrice
   FunctionDefinition.getBatchSellPrice
   FunctionDefinition.isExist
   FunctionDefinition.getCredCreator
   FunctionDefinition.getCurrentSupply
   FunctionDefinition.getCreatorRoyalty
   FunctionDefinition.credInfo
   FunctionDefinition.isShareHolder
   FunctionDefinition.getShareNumber
   FunctionDefinition.getCuratorAddressLength
   FunctionDefinition.getCuratorAddresses
   FunctionDefinition.getCuratorAddressesWithAmount
   FunctionDefinition.getPositionsForCurator
   FunctionDefinition.getRoot
   FunctionDefinition._createCredInternal
   FunctionDefinition._handleTrade
   FunctionDefinition._updateCuratorShareBalance
   FunctionDefinition._addCredIdPerAddress
   FunctionDefinition._removeCredIdPerAddress
   FunctionDefinition._executeBatchTrade
   FunctionDefinition._executeBatchBuy
   FunctionDefinition._executeBatchSell
   FunctionDefinition._validateAndCalculateBatch
   FunctionDefinition._recoverSigner
   FunctionDefinition._getCuratorData
   FunctionDefinition._authorizeUpgrade
   
   Suggested order:
   UsingForDirective.SafeTransferLib
   UsingForDirective.LibString
   UsingForDirective.LibString
   UsingForDirective.EnumerableMap.AddressToUintMap
   VariableDeclaration.MAX_SUPPLY
   VariableDeclaration.SHARE_LOCK_PERIOD
   VariableDeclaration.RATIO_BASE
   VariableDeclaration.MAX_ROYALTY_RANGE
   VariableDeclaration.credIdCounter
   VariableDeclaration.protocolFeePercent
   VariableDeclaration.locked
   VariableDeclaration.phiSignerAddress
   VariableDeclaration.protocolFeeDestination
   VariableDeclaration.phiRewardsAddress
   VariableDeclaration.creds
   VariableDeclaration.credsMerkeRoot
   VariableDeclaration.shareBalance
   VariableDeclaration.lastTradeTimestamp
   VariableDeclaration.curatePriceWhitelist
   VariableDeclaration._credIdsPerAddress
   VariableDeclaration._credIdExistsPerAddress
   VariableDeclaration._credIdsPerAddressArrLength
   VariableDeclaration._credIdsPerAddressCredIdIndex
   ModifierDefinition.nonReentrant
   ModifierDefinition.nonZeroAddress
   FunctionDefinition.constructor
   FunctionDefinition.initialize
   FunctionDefinition.version
   FunctionDefinition.pause
   FunctionDefinition.unPause
   FunctionDefinition.setPhiSignerAddress
   FunctionDefinition.setProtocolFeeDestination
   FunctionDefinition.setProtocolFeePercent
   FunctionDefinition.setPhiRewardsAddress
   FunctionDefinition.addToWhitelist
   FunctionDefinition.removeFromWhitelist
   FunctionDefinition.buyShareCred
   FunctionDefinition.sellShareCred
   FunctionDefinition.buyShareCredFor
   FunctionDefinition.batchBuyShareCred
   FunctionDefinition.batchSellShareCred
   FunctionDefinition.createCred
   FunctionDefinition.updateCred
   FunctionDefinition.getCredBuyPrice
   FunctionDefinition.getCredSellPrice
   FunctionDefinition.getCredBuyPriceWithFee
   FunctionDefinition.getCredSellPriceWithFee
   FunctionDefinition.getBatchBuyPrice
   FunctionDefinition.getBatchSellPrice
   FunctionDefinition.isExist
   FunctionDefinition.getCredCreator
   FunctionDefinition.getCurrentSupply
   FunctionDefinition.getCreatorRoyalty
   FunctionDefinition.credInfo
   FunctionDefinition.isShareHolder
   FunctionDefinition.getShareNumber
   FunctionDefinition.getCuratorAddressLength
   FunctionDefinition.getCuratorAddresses
   FunctionDefinition.getCuratorAddressesWithAmount
   FunctionDefinition.getPositionsForCurator
   FunctionDefinition.getRoot
   FunctionDefinition._createCredInternal
   FunctionDefinition._handleTrade
   FunctionDefinition._updateCuratorShareBalance
   FunctionDefinition._addCredIdPerAddress
   FunctionDefinition._removeCredIdPerAddress
   FunctionDefinition._executeBatchTrade
   FunctionDefinition._executeBatchBuy
   FunctionDefinition._executeBatchSell
   FunctionDefinition._validateAndCalculateBatch
   FunctionDefinition._recoverSigner
   FunctionDefinition._getCuratorData
   FunctionDefinition._authorizeUpgrade

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

1: 
   Current order:
   UsingForDirective.SafeTransferLib
   UsingForDirective.LibClone
   UsingForDirective.LibString
   UsingForDirective.LibString
   UsingForDirective.LibString
   VariableDeclaration.phiSignerAddress
   VariableDeclaration.protocolFeeDestination
   VariableDeclaration.erc1155ArtAddress
   VariableDeclaration.phiRewardsAddress
   VariableDeclaration.locked
   VariableDeclaration.artIdCounter
   VariableDeclaration.artCreateFee
   VariableDeclaration.mintProtocolFee
   VariableDeclaration.arts
   VariableDeclaration.artMinted
   VariableDeclaration.credMerkleRoot
   VariableDeclaration.credNFTContracts
   VariableDeclaration.credMinted
   FunctionDefinition.constructor
   FunctionDefinition.version
   FunctionDefinition.contractURI
   ModifierDefinition.nonReentrant
   ModifierDefinition.nonZeroAddress
   ModifierDefinition.onlyArtCreator
   FunctionDefinition.initialize
   FunctionDefinition.pause
   FunctionDefinition.unPause
   FunctionDefinition.pauseArtContract
   FunctionDefinition.unPauseArtContract
   FunctionDefinition.pauseArtContract
   FunctionDefinition.unPauseArtContract
   FunctionDefinition.createArt
   FunctionDefinition.updateArtSettings
   FunctionDefinition.claim
   FunctionDefinition.batchClaim
   FunctionDefinition.signatureClaim
   FunctionDefinition.merkleClaim
   FunctionDefinition.setPhiSignerAddress
   FunctionDefinition.setPhiRewardsAddress
   FunctionDefinition.setErc1155ArtAddress
   FunctionDefinition.setProtocolFeeDestination
   FunctionDefinition.setProtocolFee
   FunctionDefinition.setArtCreatFee
   FunctionDefinition.isCredMinted
   FunctionDefinition.isArtMinted
   FunctionDefinition.getArtAddress
   FunctionDefinition.getNumberMinted
   FunctionDefinition.getTokenURI
   FunctionDefinition.artData
   FunctionDefinition.getArtMintFee
   FunctionDefinition.getTotalMintFee
   FunctionDefinition.checkProof
   FunctionDefinition.createERC1155Internal
   FunctionDefinition._authorizeUpgrade
   FunctionDefinition._recoverSigner
   FunctionDefinition._validateArtCreation
   FunctionDefinition._validateArtCreationSignature
   FunctionDefinition._initializePhiArt
   FunctionDefinition._createNewNFTContract
   FunctionDefinition._useExistingNFTContract
   FunctionDefinition._createERC1155Data
   FunctionDefinition._validateAndUpdateClaimState
   FunctionDefinition._processClaim
   FunctionDefinition._buildDescription
   FunctionDefinition.withdraw
   
   Suggested order:
   UsingForDirective.SafeTransferLib
   UsingForDirective.LibClone
   UsingForDirective.LibString
   UsingForDirective.LibString
   UsingForDirective.LibString
   VariableDeclaration.phiSignerAddress
   VariableDeclaration.protocolFeeDestination
   VariableDeclaration.erc1155ArtAddress
   VariableDeclaration.phiRewardsAddress
   VariableDeclaration.locked
   VariableDeclaration.artIdCounter
   VariableDeclaration.artCreateFee
   VariableDeclaration.mintProtocolFee
   VariableDeclaration.arts
   VariableDeclaration.artMinted
   VariableDeclaration.credMerkleRoot
   VariableDeclaration.credNFTContracts
   VariableDeclaration.credMinted
   ModifierDefinition.nonReentrant
   ModifierDefinition.nonZeroAddress
   ModifierDefinition.onlyArtCreator
   FunctionDefinition.constructor
   FunctionDefinition.version
   FunctionDefinition.contractURI
   FunctionDefinition.initialize
   FunctionDefinition.pause
   FunctionDefinition.unPause
   FunctionDefinition.pauseArtContract
   FunctionDefinition.unPauseArtContract
   FunctionDefinition.pauseArtContract
   FunctionDefinition.unPauseArtContract
   FunctionDefinition.createArt
   FunctionDefinition.updateArtSettings
   FunctionDefinition.claim
   FunctionDefinition.batchClaim
   FunctionDefinition.signatureClaim
   FunctionDefinition.merkleClaim
   FunctionDefinition.setPhiSignerAddress
   FunctionDefinition.setPhiRewardsAddress
   FunctionDefinition.setErc1155ArtAddress
   FunctionDefinition.setProtocolFeeDestination
   FunctionDefinition.setProtocolFee
   FunctionDefinition.setArtCreatFee
   FunctionDefinition.isCredMinted
   FunctionDefinition.isArtMinted
   FunctionDefinition.getArtAddress
   FunctionDefinition.getNumberMinted
   FunctionDefinition.getTokenURI
   FunctionDefinition.artData
   FunctionDefinition.getArtMintFee
   FunctionDefinition.getTotalMintFee
   FunctionDefinition.checkProof
   FunctionDefinition.createERC1155Internal
   FunctionDefinition._authorizeUpgrade
   FunctionDefinition._recoverSigner
   FunctionDefinition._validateArtCreation
   FunctionDefinition._validateArtCreationSignature
   FunctionDefinition._initializePhiArt
   FunctionDefinition._createNewNFTContract
   FunctionDefinition._useExistingNFTContract
   FunctionDefinition._createERC1155Data
   FunctionDefinition._validateAndUpdateClaimState
   FunctionDefinition._processClaim
   FunctionDefinition._buildDescription
   FunctionDefinition.withdraw

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

1: 
   Current order:
   UsingForDirective.SafeTransferLib
   UsingForDirective.LibString
   VariableDeclaration.phiFactoryContract
   VariableDeclaration.protocolFeeDestination
   VariableDeclaration.credChainId
   VariableDeclaration.credId
   VariableDeclaration.tokenIdCounter
   VariableDeclaration.name
   VariableDeclaration.symbol
   VariableDeclaration.verificationType
   VariableDeclaration._artIdToTokenId
   VariableDeclaration._tokenIdToArtId
   VariableDeclaration.minted
   VariableDeclaration.minterData
   VariableDeclaration.advancedTokenURI
   FunctionDefinition.constructor
   FunctionDefinition.version
   ModifierDefinition.onlyArtCreator
   ModifierDefinition.onlyPhiFactory
   FunctionDefinition.initialize
   FunctionDefinition.pause
   FunctionDefinition.unPause
   FunctionDefinition.createArtFromFactory
   FunctionDefinition.claimFromFactory
   FunctionDefinition.updateRoyalties
   FunctionDefinition.setContractURI
   FunctionDefinition.supportsInterface
   FunctionDefinition.contractURI
   FunctionDefinition.uri
   FunctionDefinition.uri
   FunctionDefinition.getPhiFactoryContract
   FunctionDefinition.getTokenIdFromFactoryArtId
   FunctionDefinition.getFactoryArtId
   FunctionDefinition.getArtDataFromFactory
   FunctionDefinition.mintFee
   FunctionDefinition.soulBounded
   FunctionDefinition.mint
   FunctionDefinition.safeTransferFrom
   FunctionDefinition.safeBatchTransferFrom
   FunctionDefinition._authorizeUpgrade
   FunctionDefinition.receive
   
   Suggested order:
   UsingForDirective.SafeTransferLib
   UsingForDirective.LibString
   VariableDeclaration.phiFactoryContract
   VariableDeclaration.protocolFeeDestination
   VariableDeclaration.credChainId
   VariableDeclaration.credId
   VariableDeclaration.tokenIdCounter
   VariableDeclaration.name
   VariableDeclaration.symbol
   VariableDeclaration.verificationType
   VariableDeclaration._artIdToTokenId
   VariableDeclaration._tokenIdToArtId
   VariableDeclaration.minted
   VariableDeclaration.minterData
   VariableDeclaration.advancedTokenURI
   ModifierDefinition.onlyArtCreator
   ModifierDefinition.onlyPhiFactory
   FunctionDefinition.constructor
   FunctionDefinition.version
   FunctionDefinition.initialize
   FunctionDefinition.pause
   FunctionDefinition.unPause
   FunctionDefinition.createArtFromFactory
   FunctionDefinition.claimFromFactory
   FunctionDefinition.updateRoyalties
   FunctionDefinition.setContractURI
   FunctionDefinition.supportsInterface
   FunctionDefinition.contractURI
   FunctionDefinition.uri
   FunctionDefinition.uri
   FunctionDefinition.getPhiFactoryContract
   FunctionDefinition.getTokenIdFromFactoryArtId
   FunctionDefinition.getFactoryArtId
   FunctionDefinition.getArtDataFromFactory
   FunctionDefinition.mintFee
   FunctionDefinition.soulBounded
   FunctionDefinition.mint
   FunctionDefinition.safeTransferFrom
   FunctionDefinition.safeBatchTransferFrom
   FunctionDefinition._authorizeUpgrade
   FunctionDefinition.receive

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

### <a name="NC-25"></a>[NC-25] Use Underscores for Number Literals (add an underscore every 3 digits)

*Instances (4)*:

```solidity
File: src/Cred.sol

35:     uint256 private immutable MAX_ROYALTY_RANGE = 5000;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/curve/BondingCurve.sol

18:     uint256 private constant TOTAL_SUPPLY_FACTOR = 1000 ether;

119:             - CURVE_FACTOR * 1 ether - INITIAL_PRICE_FACTOR * targetAmount_ / 1000;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/curve/BondingCurve.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

31:     uint256 private immutable MAX_ROYALTY_RANGE = 1000;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

### <a name="NC-26"></a>[NC-26] Internal and private variables and functions names should begin with an underscore

According to the Solidity Style Guide, Non-`external` variable and function names should begin with an [underscore](https://docs.soliditylang.org/en/latest/style-guide.html#underscore-prefix-for-non-external-functions-and-variables)

*Instances (16)*:

```solidity
File: src/Cred.sol

38:     uint256 private locked;

44:     mapping(uint256 credId => PhiCred creds) private creds;

46:     mapping(uint256 credId => EnumerableMap.AddressToUintMap balance) private shareBalance;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

40:     uint256 private locked;

45:     mapping(uint256 artId => PhiArt art) private arts;

46:     mapping(uint256 artId => mapping(address minter => bool)) private artMinted;

49:     mapping(uint256 credChainId => mapping(uint256 credId => address)) private credNFTContracts;

50:     mapping(uint256 credChainId => mapping(uint256 credId => mapping(address => bool))) private credMinted;

551:     function createERC1155Internal(uint256 newArtId, ERC1155Data memory createData_) internal returns (address) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/CreatorRoyaltiesControl.sol

12:     address private royaltyRecipient;

13:     bool private initilaized;

17:     function initializeRoyalties(address _royaltyRecipient) internal {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/CreatorRoyaltiesControl.sol)

```solidity
File: src/art/PhiNFT1155.sol

58:     mapping(uint256 tokenId => mapping(address minter => string uri)) private advancedTokenURI;

283:     function mint(

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

29:     uint256 private withdrawRoyalty = 100;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

```solidity
File: src/reward/PhiRewards.sol

78:     function depositRewards(

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/PhiRewards.sol)

### <a name="NC-27"></a>[NC-27] `override` function arguments that are unused should have the variable name removed or commented out to avoid compiler warnings

*Instances (3)*:

```solidity
File: src/Cred.sol

937:     function _authorizeUpgrade(address newImplementation) internal override onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

570:     function _authorizeUpgrade(address newImplementation) internal override onlyOwner { }

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

352:     function _authorizeUpgrade(address newImplementation) internal override onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

### <a name="NC-28"></a>[NC-28] `public` functions not called by the contract should be declared `external` instead

*Instances (23)*:

```solidity
File: src/Cred.sol

95:     function version() public pure returns (uint256) {

182:     function sellShareCred(uint256 credId_, uint256 amount_, uint256 minPrice_) public {

186:     function buyShareCredFor(uint256 credId_, uint256 amount_, address curator_, uint256 maxPrice_) public payable {

191:     function batchBuyShareCred(

213:     function batchSellShareCred(

232:     function createCred(

399:     function getCreatorRoyalty(uint256 credId_) public view returns (uint16 buyShareRoyalty, uint16 sellShareRoyalty) {

440:     function getCuratorAddresses(

464:     function getCuratorAddressesWithAmount(

531:     function getRoot(uint256 credId_) public view returns (bytes32) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

60:     function version() public pure returns (uint256) {

64:     function contractURI(address nftAddress) public view returns (string memory) {

541:     function checkProof(bytes32[] calldata proof, bytes32 leaf, bytes32 root) public pure returns (bool) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/CreatorRoyaltiesControl.sol

42:     function royaltyInfo(

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/CreatorRoyaltiesControl.sol)

```solidity
File: src/abstract/RewardControl.sol

164:     function hashTypedData(bytes32 structHash) public view returns (bytes32) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/RewardControl.sol)

```solidity
File: src/art/PhiNFT1155.sol

68:     function version() public pure returns (uint256) {

227:     function contractURI() public view returns (string memory) {

241:     function uri(uint256 tokenId_, address minter_) public view returns (string memory) {

255:     function getTokenIdFromFactoryArtId(uint256 artId_) public view returns (uint256 tokenId) {

263:     function getArtDataFromFactory(uint256 artId_) public view returns (IPhiFactory.ArtData memory) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/curve/BondingCurve.sol

51:     function getPriceData(

86:     function getBuyPriceAfterFee(uint256 credId_, uint256 supply_, uint256 amount_) public view returns (uint256) {

106:     function getSellPriceAfterFee(uint256 credId_, uint256 supply_, uint256 amount_) public view returns (uint256) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/curve/BondingCurve.sol)

### <a name="NC-29"></a>[NC-29] Variables need not be initialized to zero

The default value for variables is zero, so initializing them to zero is superfluous.

*Instances (17)*:

```solidity
File: src/Cred.sol

352:         for (uint256 i = 0; i < credIds_.length; ++i) {

373:         for (uint256 i = 0; i < credIds_.length; ++i) {

452:         for (uint256 i = 0; i < curatorData.length; i++) {

508:         uint256 index = 0;

751:         for (uint256 i = 0; i < credIds_.length; ++i) {

772:         for (uint256 i = 0; i < credIds_.length; ++i) {

838:         for (uint256 i = 0; i < length; ++i) {

848:             for (uint256 j = 0; j < i; ++j) {

918:         uint256 index = 0;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

313:         for (uint256 i = 0; i < encodeDatas_.length; i++) {

318:         for (uint256 i = 0; i < encodeDatas_.length; i++) {

526:         for (uint256 i = 0; i < artId_.length; i++) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/RewardControl.sol

70:         for (uint256 i = 0; i < numRecipients; i++) {

78:         for (uint256 i = 0; i < numRecipients; i++) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/RewardControl.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

87:         for (uint256 i = 0; i < distributeAddresses.length; i++) {

105:         uint256 actualDistributeAmount = 0;

106:         for (uint256 i = 0; i < distributeAddresses.length; i++) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

## Low Issues

| |Issue|Instances|
|-|:-|:-:|
| [L-1](#L-1) | Use of `tx.origin` is unsafe in almost every context | 1 |
| [L-2](#L-2) | Missing checks for `address(0)` when assigning values to address state variables | 13 |
| [L-3](#L-3) | `abi.encodePacked()` should not be used with dynamic types when passing the result to a hash function such as `keccak256()` | 33 |
| [L-4](#L-4) | Use of `tx.origin` is unsafe in almost every context | 1 |
| [L-5](#L-5) | Division by zero not prevented | 2 |
| [L-6](#L-6) | Empty Function Body - Consider commenting why | 3 |
| [L-7](#L-7) | Empty `receive()/payable fallback()` function does not authenticate requests | 1 |
| [L-8](#L-8) | External calls in an un-bounded `for-`loop may result in a DOS | 3 |
| [L-9](#L-9) | External call recipient may consume all transaction gas | 3 |
| [L-10](#L-10) | Initializers could be front-run | 16 |
| [L-11](#L-11) | Signature use at deadlines should be allowed | 6 |
| [L-12](#L-12) | Prevent accidentally burning tokens | 32 |
| [L-13](#L-13) | Owner can renounce while system is paused | 10 |
| [L-14](#L-14) | Possible rounding issue | 2 |
| [L-15](#L-15) | Loss of precision | 7 |
| [L-16](#L-16) | Solidity version 0.8.20+ may not work on other chains due to `PUSH0` | 6 |
| [L-17](#L-17) | Use `Ownable2Step.transferOwnership` instead of `Ownable.transferOwnership` | 4 |
| [L-18](#L-18) | Upgradeable contract is missing a `__gap[50]` storage variable to allow for new storage variables in later versions | 27 |
| [L-19](#L-19) | Upgradeable contract not initialized | 52 |

### <a name="L-1"></a>[L-1] Use of `tx.origin` is unsafe in almost every context

According to [Vitalik Buterin](https://ethereum.stackexchange.com/questions/196/how-do-i-make-my-dapp-serenity-proof), contracts should *not* `assume that tx.origin will continue to be usable or meaningful`. An example of this is [EIP-3074](https://eips.ethereum.org/EIPS/eip-3074#allowing-txorigin-as-signer-1) which explicitly mentions the intention to change its semantics when it's used with new op codes. There have also been calls to [remove](https://github.com/ethereum/solidity/issues/683) `tx.origin`, and there are [security issues](solidity.readthedocs.io/en/v0.4.24/security-considerations.html#tx-origin) associated with using it for authorization. For these reasons, it's best to completely avoid the feature.

*Instances (1)*:

```solidity
File: src/PhiFactory.sol

706:         if (tx.origin != _msgSender() && msg.sender != art.artAddress && msg.sender != address(this)) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

### <a name="L-2"></a>[L-2] Missing checks for `address(0)` when assigning values to address state variables

*Instances (13)*:

```solidity
File: src/Cred.sol

88:         phiSignerAddress = phiSignerAddress_;

90:         phiRewardsAddress = phiRewardsAddress_;

130:         phiSignerAddress = phiSignerAddress_;

141:         protocolFeeDestination = protocolFeeDestination_;

155:         phiRewardsAddress = phiRewardsAddress_;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

149:         phiSignerAddress = phiSignerAddress_;

150:         protocolFeeDestination = protocolFeeDestination_;

151:         erc1155ArtAddress = erc1155ArtAddress_;

152:         phiRewardsAddress = phiRewardsAddress_;

391:         phiSignerAddress = phiSignerAddress_;

398:         phiRewardsAddress = phiRewardsAddress_;

405:         erc1155ArtAddress = erc1155ArtAddress_;

416:         protocolFeeDestination = protocolFeeDestination_;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

### <a name="L-3"></a>[L-3] `abi.encodePacked()` should not be used with dynamic types when passing the result to a hash function such as `keccak256()`

Use `abi.encode()` instead which will pad items to 32 bytes, which will [prevent hash collisions](https://docs.soliditylang.org/en/v0.8.13/abi-spec.html#non-standard-packed-mode) (e.g. `abi.encodePacked(0x123,0x456)` => `0x123456` => `abi.encodePacked(0x1,0x23456)`, but `abi.encode(0x123,0x456)` => `0x0...1230...456`). "Unless there is a compelling reason, `abi.encode` should be preferred". If there is only one argument to `abi.encodePacked()` it can often be cast to `bytes()` or `bytes32()` [instead](https://ethereum.stackexchange.com/questions/30912/how-to-compare-strings-in-solidity#answer-82739).
If all arguments are strings and or bytes, `bytes.concat()` should be used instead

*Instances (33)*:

```solidity
File: src/PhiFactory.sol

70:                 "{",

71:                 '"name":"',

72:                 "Phi Cred NFT",

73:                 '",',

74:                 '"description":"',

75:                 _buildDescription(art),

76:                 '",',

77:                 '"image":"',

78:                 "https://gateway.irys.xyz/H2OgtiAtsJRB8svr4d-kV2BtAE4BTI_q0wtAn5aKjcU",

79:                 '",',

80:                 '"featured_image":"',

81:                 "https://www.arweave.net/47AloaAgG7UFYuZjieYi4b2QOD1TG2pFYAbsshULtEY?ext=png",

82:                 '",',

83:                 '"external_link":"https://phiprotocol.xyz/",',

84:                 '"collaborators":["',

85:                 owner().toHexString(),

86:                 '"]',

87:                 "}"

766:                 "Phi Cred NFT for credId ",

767:                 uint256(art.credId).toString(),

768:                 " on chain ",

769:                 uint256(art.credChainId).toString(),

770:                 ". ",

771:                 "This NFT represents a unique on-chain cred created by ",

772:                 art.credCreator.toHexString(),

773:                 ". ",

774:                 "The cred is verified using ",

775:                 art.verificationType,

776:                 ". ",

777:                 "Holders of this NFT have proven their eligibility for the cred. ",

778:                 "Join the Phi community to collect and showcase your on-chain achievements."

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

117:             abi.encodePacked("Phi Cred-", uint256(credId_).toString(), " on Chain-", uint256(credChainId_).toString())

119:         symbol = string(abi.encodePacked("PHI-", uint256(credId_).toString(), "-", uint256(credChainId_).toString()));

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

### <a name="L-4"></a>[L-4] Use of `tx.origin` is unsafe in almost every context

According to [Vitalik Buterin](https://ethereum.stackexchange.com/questions/196/how-do-i-make-my-dapp-serenity-proof), contracts should *not* `assume that tx.origin will continue to be usable or meaningful`. An example of this is [EIP-3074](https://eips.ethereum.org/EIPS/eip-3074#allowing-txorigin-as-signer-1) which explicitly mentions the intention to change its semantics when it's used with new op codes. There have also been calls to [remove](https://github.com/ethereum/solidity/issues/683) `tx.origin`, and there are [security issues](solidity.readthedocs.io/en/v0.4.24/security-considerations.html#tx-origin) associated with using it for authorization. For these reasons, it's best to completely avoid the feature.

*Instances (1)*:

```solidity
File: src/PhiFactory.sol

706:         if (tx.origin != _msgSender() && msg.sender != art.artAddress && msg.sender != address(this)) {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

### <a name="L-5"></a>[L-5] Division by zero not prevented

The divisions below take an input parameter which does not have any zero-value checks, which may lead to the functions reverting when zero is passed.

*Instances (2)*:

```solidity
File: src/curve/BondingCurve.sol

118:         return (TOTAL_SUPPLY_FACTOR * CURVE_FACTOR * 1 ether) / (TOTAL_SUPPLY_FACTOR - targetAmount_)

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/curve/BondingCurve.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

110:             uint256 userRewards = (distributeAmount * userAmounts) / totalNum;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

### <a name="L-6"></a>[L-6] Empty Function Body - Consider commenting why

*Instances (3)*:

```solidity
File: src/Cred.sol

937:     function _authorizeUpgrade(address newImplementation) internal override onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

570:     function _authorizeUpgrade(address newImplementation) internal override onlyOwner { }

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

352:     function _authorizeUpgrade(address newImplementation) internal override onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

### <a name="L-7"></a>[L-7] Empty `receive()/payable fallback()` function does not authenticate requests

If the intention is for the Ether to be used, the function should call another function, otherwise it should revert (e.g. require(msg.sender == address(weth))). Having no access control on the function means that someone may send Ether to the contract, and have no way to get anything back out, which is a loss of funds. If the concern is having to spend a small amount of gas to check the sender against an immutable address, the code should at least have a function to rescue unused Ether.

*Instances (1)*:

```solidity
File: src/art/PhiNFT1155.sol

359:     receive() external payable {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

### <a name="L-8"></a>[L-8] External calls in an un-bounded `for-`loop may result in a DOS

Consider limiting the number of iterations in for-loops that make external calls

*Instances (3)*:

```solidity
File: src/Cred.sol

512:                 uint256 amount = shareBalance[credId].get(curator_);

871:                 (, uint256 num) = shareBalance[credId].tryGet(_msgSender());

921:             (address key, uint256 shareAmount) = shareBalance[credId_].at(i);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

### <a name="L-9"></a>[L-9] External call recipient may consume all transaction gas

There is no limit specified on the amount of gas used, so the recipient can use up all of the transaction's gas, causing it to revert. Use `addr.call{gas: <amount>}("")` or [this](https://github.com/nomad-xyz/ExcessivelySafeCall) library instead.

*Instances (3)*:

```solidity
File: src/PhiFactory.sol

641:             newArt.call{ value: msg.value }(abi.encodeWithSignature("createArtFromFactory(uint256)", newArtId));

664:             existingArt.call{ value: msg.value }(abi.encodeWithSignature("createArtFromFactory(uint256)", newArtId));

744:         (bool success_,) = art.artAddress.call{ value: mintFee - mintProtocolFee * quantity_ }(

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

### <a name="L-10"></a>[L-10] Initializers could be front-run

Initializers could be front-run, allowing an attacker to either set their own values, take ownership of the contract, and in the best case forcing a re-deployment

*Instances (16)*:

```solidity
File: src/Cred.sol

69:     function initialize(

78:         initializer

80:         __Ownable_init(ownerAddress_);

81:         __Pausable_init();

82:         __UUPSUpgradeable_init();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

127:     function initialize(

137:         initializer

139:         __Ownable_init(ownerAddress_);

140:         __Pausable_init();

141:         __UUPSUpgradeable_init();

636:         IPhiNFT1155Ownable(newArt).initialize(credChainId, credId, verificationType, protocolFeeDestination);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

96:     function initialize(

103:         initializer

105:         __Ownable_init(msg.sender);

107:         __Pausable_init();

108:         __ReentrancyGuard_init();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

### <a name="L-11"></a>[L-11] Signature use at deadlines should be allowed

According to [EIP-2612](https://github.com/ethereum/EIPs/blob/71dc97318013bf2ac572ab63fab530ac9ef419ca/EIPS/eip-2612.md?plain=1#L58), signatures used on exactly the deadline timestamp are supposed to be allowed. While the signature may or may not be used for the exact EIP-2612 use case (transfer approvals), for consistency's sake, all deadlines should follow this semantic. If the timestamp is an expiration rather than a deadline, consider whether it makes more sense to include the expiration timestamp as a valid timestamp, as is done for deadlines.

*Instances (6)*:

```solidity
File: src/Cred.sol

254:         if (expiresIn <= block.timestamp) revert SignatureExpired();

295:         if (expiresIn_ <= block.timestamp) revert SignatureExpired();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

236:         if (endTime_ < block.timestamp) {

339:         if (expiresIn_ <= block.timestamp) revert SignatureExpired();

585:         if (createData_.endTime <= block.timestamp) revert EndTimeInPast();

592:         if (expiresIn_ <= block.timestamp) revert SignatureExpired();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

### <a name="L-12"></a>[L-12] Prevent accidentally burning tokens

Minting and burning tokens to address(0) prevention

*Instances (32)*:

```solidity
File: src/PhiFactory.sol

256:         emit ArtUpdated(artId_, url_, receiver_, maxSupply_, mintFee_, startTime_, endTime_, soulBounded_);

280:             bytes memory claimData = abi.encode(minter_, ref_, artId);

283:             this.merkleClaim{ value: mintFee }(proof, claimData, mintArgs, leafPart_);

297:             bytes memory claimData = abi.encode(expiresIn_, minter_, ref_, verifier_, artId, block.chainid, data_);

300:             this.signatureClaim{ value: mintFee }(signature_, claimData, mintArgs);

342:         _validateAndUpdateClaimState(artId_, minter_, mintArgs_.quantity);

343:         _processClaim(artId_, minter_, ref_, verifier_, mintArgs_.quantity, data_, mintArgs_.imageURI, msg.value);

345:         emit ArtClaimedData(artId_, "SIGNATURE", minter_, ref_, verifier_, arts[artId_].artAddress, mintArgs_.quantity);

370:             !MerkleProofLib.verifyCalldata(

371:                 proof_, credMerkleRootHash, keccak256(bytes.concat(keccak256(abi.encode(minter_, leafPart_))))

371:                 proof_, credMerkleRootHash, keccak256(bytes.concat(keccak256(abi.encode(minter_, leafPart_))))

377:         _validateAndUpdateClaimState(artId_, minter_, mintArgs_.quantity);

378:         _processClaim(

382:         emit ArtClaimedData(artId_, "MERKLE", minter_, ref_, art.credCreator, art.artAddress, mintArgs_.quantity);

740:             _msgSender().safeTransferETH(etherValue_ - mintFee);

742:         protocolFeeDestination.safeTransferETH(mintProtocolFee * quantity_);

744:         (bool success_,) = art.artAddress.call{ value: mintFee - mintProtocolFee * quantity_ }(

745:             abi.encodeWithSignature(

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/Claimable.sol

38:         bytes memory claimData_ = abi.encode(expiresIn_, minter_, ref_, verifier_, artId, block.chainid, data_);

43:         phiFactoryContract.signatureClaim{ value: msg.value }(signature, claimData_, mintArgs_);

61:         bytes memory claimData = abi.encode(minter, ref, artId);

64:         phiFactory.merkleClaim{ value: msg.value }(proof, claimData, mintArgs, leafPart);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/Claimable.sol)

```solidity
File: src/art/PhiNFT1155.sol

182:         mint(minter_, tokenId_, quantity_, imageURI_, data_);

184:         bytes memory addressesData_ = abi.encode(minter_, aristRewardReceiver, ref_, verifier_);

186:         IPhiRewards(payable(phiFactoryContract.phiRewardsAddress())).handleRewardsAndGetValueSent{ value: msg.value }(

187:             artId_, credId, quantity_, mintFee(tokenId_), addressesData_, credChainId == block.chainid

189:         emit ArtClaimedData(minter_, aristRewardReceiver, ref_, verifier_, artId_, tokenId_, quantity_, data_);

242:         if (bytes(advancedTokenURI[tokenId_][minter_]).length > 0) {

298:         _mint(to_, tokenId_, quantity_, "0x00");

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/reward/PhiRewards.sol

120:         emit RewardsDeposit(credData, minter_, receiver_, referral_, verifier_, rewardsData);

134:         if (computeMintReward(quantity_, mintFee_) != msg.value) {

138:         depositRewards(

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/PhiRewards.sol)

### <a name="L-13"></a>[L-13] Owner can renounce while system is paused

The contract owner or single user with a role is not prevented from renouncing the role/ownership while the contract is paused, which would cause any user assets stored in the protocol, to be locked indefinitely.

*Instances (10)*:

```solidity
File: src/Cred.sol

100:     function pause() external onlyOwner {

105:     function unPause() external onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

156:     function pause() external onlyOwner {

161:     function unPause() external onlyOwner {

170:     function pauseArtContract(uint256 artId_) external onlyOwner {

176:     function unPauseArtContract(uint256 artId_) external onlyOwner {

180:     function pauseArtContract(address artAddress_) external onlyOwner {

184:     function unPauseArtContract(address artAddress_) external onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

128:     function pause() external onlyOwner {

133:     function unPause() external onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

### <a name="L-14"></a>[L-14] Possible rounding issue

Division by large numbers may result in the result being zero, due to solidity not supporting fractions. Consider requiring a minimum amount for the numerator to ensure that it is always larger than the denominator. Also, there is indication of multiplication and division without the use of parenthesis which could result in issues.

*Instances (2)*:

```solidity
File: src/curve/BondingCurve.sol

118:         return (TOTAL_SUPPLY_FACTOR * CURVE_FACTOR * 1 ether) / (TOTAL_SUPPLY_FACTOR - targetAmount_)

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/curve/BondingCurve.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

110:             uint256 userRewards = (distributeAmount * userAmounts) / totalNum;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

### <a name="L-15"></a>[L-15] Loss of precision

Division by large numbers may result in the result being zero, due to solidity not supporting fractions. Consider requiring a minimum amount for the numerator to ensure that it is always larger than the denominator

*Instances (7)*:

```solidity
File: src/abstract/CreatorRoyaltiesControl.sol

51:         royaltyAmount = (config.royaltyBPS * salePrice) / ROYALTY_BPS_TO_PERCENT;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/CreatorRoyaltiesControl.sol)

```solidity
File: src/curve/BondingCurve.sol

71:         creatorFee = (price * royaltyRate) / RATIO_BASE;

118:         return (TOTAL_SUPPLY_FACTOR * CURVE_FACTOR * 1 ether) / (TOTAL_SUPPLY_FACTOR - targetAmount_)

124:         return price_ * credContract.protocolFeePercent() / RATIO_BASE;

148:         creatorFee = (price_ * royaltyRate) / RATIO_BASE;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/curve/BondingCurve.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

98:         uint256 royaltyfee = (totalBalance * withdrawRoyalty) / RATIO_BASE;

110:             uint256 userRewards = (distributeAmount * userAmounts) / totalNum;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

### <a name="L-16"></a>[L-16] Solidity version 0.8.20+ may not work on other chains due to `PUSH0`

The compiler for Solidity 0.8.20 switches the default target EVM version to [Shanghai](https://blog.soliditylang.org/2023/05/10/solidity-0.8.20-release-announcement/#important-note), which includes the new `PUSH0` op code. This op code may not yet be implemented on all L2s, so deployment on these chains will fail. To work around this issue, use an earlier [EVM](https://docs.soliditylang.org/en/v0.8.20/using-the-compiler.html?ref=zaryabs.com#setting-the-evm-version-to-target) [version](https://book.getfoundry.sh/reference/config/solidity-compiler#evm_version). While the project itself may or may not compile with 0.8.20, other projects with which it integrates, or which extend this project may, and those projects will have problems deploying these contracts/libraries.

*Instances (6)*:

```solidity
File: src/Cred.sol

2: pragma solidity 0.8.25;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

2: pragma solidity 0.8.25;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

2: pragma solidity 0.8.25;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/curve/BondingCurve.sol

2: pragma solidity 0.8.25;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/curve/BondingCurve.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

2: pragma solidity 0.8.25;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

```solidity
File: src/reward/PhiRewards.sol

2: pragma solidity 0.8.25;

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/PhiRewards.sol)

### <a name="L-17"></a>[L-17] Use `Ownable2Step.transferOwnership` instead of `Ownable.transferOwnership`

Use [Ownable2Step.transferOwnership](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable2Step.sol) which is safer. Use it as it is more secure due to 2-stage ownership transfer.

**Recommended Mitigation Steps**

Use <a href="https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable2Step.sol">Ownable2Step.sol</a>
  
  ```solidity
      function acceptOwnership() external {
          address sender = _msgSender();
          require(pendingOwner() == sender, "Ownable2Step: caller is not the new owner");
          _transferOwnership(sender);
      }
```

*Instances (4)*:

```solidity
File: src/PhiFactory.sol

6: import { IPhiNFT1155Ownable } from "./interfaces/IPhiNFT1155Ownable.sol";

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/curve/BondingCurve.sol

5: import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/curve/BondingCurve.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

10: import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

```solidity
File: src/reward/PhiRewards.sol

10: import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/PhiRewards.sol)

### <a name="L-18"></a>[L-18] Upgradeable contract is missing a `__gap[50]` storage variable to allow for new storage variables in later versions

See [this](https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps) link for a description of this storage variable. While some contracts may not currently be sub-classed, adding the variable now protects against forgetting to add it in the future.

*Instances (27)*:

```solidity
File: src/Cred.sol

5: import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

6: import { PausableUpgradeable } from "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";

7: import { Ownable2StepUpgradeable } from "@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol";

8: import { UUPSUpgradeable } from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

19: contract Cred is Initializable, UUPSUpgradeable, Ownable2StepUpgradeable, PausableUpgradeable, ICred {

82:         __UUPSUpgradeable_init();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

8: import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

9: import { PausableUpgradeable } from "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";

10: import { Ownable2StepUpgradeable } from "@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol";

11: import { UUPSUpgradeable } from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

22: contract PhiFactory is Initializable, UUPSUpgradeable, Ownable2StepUpgradeable, PausableUpgradeable, IPhiFactory {

141:         __UUPSUpgradeable_init();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

8: import { ERC1155Upgradeable } from "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";

9: import { ERC1155SupplyUpgradeable } from

10:     "@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/ERC1155SupplyUpgradeable.sol";

11: import { PausableUpgradeable } from "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";

12: import { ReentrancyGuardUpgradeable } from "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";

13: import { Ownable2StepUpgradeable } from "@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol";

17: import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

18: import { UUPSUpgradeable } from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

23:     UUPSUpgradeable,

24:     ERC1155SupplyUpgradeable,

25:     ReentrancyGuardUpgradeable,

26:     PausableUpgradeable,

27:     Ownable2StepUpgradeable,

220:         override(CreatorRoyaltiesControl, ERC1155Upgradeable, IERC165)

224:             || ERC1155Upgradeable.supportsInterface(interfaceId);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

### <a name="L-19"></a>[L-19] Upgradeable contract not initialized

Upgradeable contracts are initialized via an initializer function rather than by a constructor. Leaving such a contract uninitialized may lead to it being taken over by a malicious user

*Instances (52)*:

```solidity
File: src/Cred.sol

5: import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

6: import { PausableUpgradeable } from "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";

7: import { Ownable2StepUpgradeable } from "@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol";

8: import { UUPSUpgradeable } from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

19: contract Cred is Initializable, UUPSUpgradeable, Ownable2StepUpgradeable, PausableUpgradeable, ICred {

61:         _disableInitializers();

69:     function initialize(

78:         initializer

80:         __Ownable_init(ownerAddress_);

81:         __Pausable_init();

82:         __UUPSUpgradeable_init();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

8: import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

9: import { PausableUpgradeable } from "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";

10: import { Ownable2StepUpgradeable } from "@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol";

11: import { UUPSUpgradeable } from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

22: contract PhiFactory is Initializable, UUPSUpgradeable, Ownable2StepUpgradeable, PausableUpgradeable, IPhiFactory {

57:         _disableInitializers();

117:                               INITIALIZER

127:     function initialize(

137:         initializer

139:         __Ownable_init(ownerAddress_);

140:         __Pausable_init();

141:         __UUPSUpgradeable_init();

555:         _initializePhiArt(currentArt, createData_);

595:     function _initializePhiArt(PhiArt storage art, ERC1155Data memory createData_) private {

636:         IPhiNFT1155Ownable(newArt).initialize(credChainId, credId, verificationType, protocolFeeDestination);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/abstract/CreatorRoyaltiesControl.sol

17:     function initializeRoyalties(address _royaltyRecipient) internal {

19:         if (initilaized) revert AlreadyInitialized();

28:         if (!initilaized) revert NotInitialized();

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/abstract/CreatorRoyaltiesControl.sol)

```solidity
File: src/art/PhiNFT1155.sol

8: import { ERC1155Upgradeable } from "@openzeppelin/contracts-upgradeable/token/ERC1155/ERC1155Upgradeable.sol";

9: import { ERC1155SupplyUpgradeable } from

10:     "@openzeppelin/contracts-upgradeable/token/ERC1155/extensions/ERC1155SupplyUpgradeable.sol";

11: import { PausableUpgradeable } from "@openzeppelin/contracts-upgradeable/utils/PausableUpgradeable.sol";

12: import { ReentrancyGuardUpgradeable } from "@openzeppelin/contracts-upgradeable/utils/ReentrancyGuardUpgradeable.sol";

13: import { Ownable2StepUpgradeable } from "@openzeppelin/contracts-upgradeable/access/Ownable2StepUpgradeable.sol";

17: import { Initializable } from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

18: import { UUPSUpgradeable } from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

23:     UUPSUpgradeable,

24:     ERC1155SupplyUpgradeable,

25:     ReentrancyGuardUpgradeable,

26:     PausableUpgradeable,

27:     Ownable2StepUpgradeable,

65:         _disableInitializers();

96:     function initialize(

103:         initializer

105:         __Ownable_init(msg.sender);

107:         __Pausable_init();

108:         __ReentrancyGuard_init();

109:         initializeRoyalties(protocolFeeDestination_);

124:         emit InitializePhiNFT1155(credId_, verificationType_);

220:         override(CreatorRoyaltiesControl, ERC1155Upgradeable, IERC165)

224:             || ERC1155Upgradeable.supportsInterface(interfaceId);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

## Medium Issues

| |Issue|Instances|
|-|:-|:-:|
| [M-1](#M-1) | Centralization Risk for trusted owners | 55 |
| [M-2](#M-2) | Fees can be set to be greater than 100%. | 3 |
| [M-3](#M-3) | Direct `supportsInterface()` calls may cause caller to revert | 2 |

### <a name="M-1"></a>[M-1] Centralization Risk for trusted owners

#### Impact

Contracts have owners with privileged rights to perform admin tasks and need to be trusted to not perform malicious updates or drain funds.

*Instances (55)*:

```solidity
File: src/Cred.sol

100:     function pause() external onlyOwner {

105:     function unPause() external onlyOwner {

129:     function setPhiSignerAddress(address phiSignerAddress_) external nonZeroAddress(phiSignerAddress_) onlyOwner {

147:     function setProtocolFeePercent(uint256 protocolFeePercent_) external onlyOwner {

154:     function setPhiRewardsAddress(address phiRewardsAddress_) external nonZeroAddress(phiRewardsAddress_) onlyOwner {

163:     function addToWhitelist(address address_) external onlyOwner {

170:     function removeFromWhitelist(address address_) external onlyOwner {

937:     function _authorizeUpgrade(address newImplementation) internal override onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

6: import { IPhiNFT1155Ownable } from "./interfaces/IPhiNFT1155Ownable.sol";

65:         uint256 artId = IPhiNFT1155Ownable(nftAddress).getFactoryArtId(1);

156:     function pause() external onlyOwner {

161:     function unPause() external onlyOwner {

170:     function pauseArtContract(uint256 artId_) external onlyOwner {

171:         IPhiNFT1155Ownable(arts[artId_].artAddress).pause();

176:     function unPauseArtContract(uint256 artId_) external onlyOwner {

177:         IPhiNFT1155Ownable(arts[artId_].artAddress).unPause();

180:     function pauseArtContract(address artAddress_) external onlyOwner {

181:         IPhiNFT1155Ownable(artAddress_).pause();

184:     function unPauseArtContract(address artAddress_) external onlyOwner {

185:         IPhiNFT1155Ownable(artAddress_).unPause();

254:         uint256 tokenId = IPhiNFT1155Ownable(art.artAddress).getTokenIdFromFactoryArtId(artId_);

255:         IPhiNFT1155Ownable(art.artAddress).updateRoyalties(tokenId, configuration);

268:         uint256 tokenId = IPhiNFT1155Ownable(art.artAddress).getTokenIdFromFactoryArtId(artId);

390:     function setPhiSignerAddress(address phiSignerAddress_) external nonZeroAddress(phiSignerAddress_) onlyOwner {

397:     function setPhiRewardsAddress(address phiRewardsAddress_) external nonZeroAddress(phiRewardsAddress_) onlyOwner {

404:     function setErc1155ArtAddress(address erc1155ArtAddress_) external nonZeroAddress(erc1155ArtAddress_) onlyOwner {

422:     function setProtocolFee(uint256 protocolFee_) external onlyOwner {

430:     function setArtCreatFee(uint256 artCreateFee_) external onlyOwner {

478:         IPhiNFT1155Ownable artContract = IPhiNFT1155Ownable(thisArt.artAddress);

570:     function _authorizeUpgrade(address newImplementation) internal override onlyOwner { }

636:         IPhiNFT1155Ownable(newArt).initialize(credChainId, credId, verificationType, protocolFeeDestination);

786:     function withdraw() external onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

```solidity
File: src/art/PhiNFT1155.sol

128:     function pause() external onlyOwner {

133:     function unPause() external onlyOwner {

352:     function _authorizeUpgrade(address newImplementation) internal override onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)

```solidity
File: src/curve/BondingCurve.sol

4: import { Ownable2Step } from "@openzeppelin/contracts/access/Ownable2Step.sol";

5: import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

12: contract BondingCurve is Ownable2Step, IBondingCurve {

27:     constructor(address owner_) Ownable(owner_) { }

34:     function setCredContract(address credContract_) external onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/curve/BondingCurve.sol)

```solidity
File: src/reward/CuratorRewardsDistributor.sol

9: import { Ownable2Step } from "@openzeppelin/contracts/access/Ownable2Step.sol";

10: import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

17: contract CuratorRewardsDistributor is Logo, Ownable2Step, ICuratorRewardsDistributor {

37:     constructor(address phiRewardsContract_, address credContract_) payable Ownable(msg.sender) {

49:     function updatePhiRewardsContract(address phiRewardsContract_) external onlyOwner {

57:     function updateRoyalty(uint256 newRoyalty_) external onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/CuratorRewardsDistributor.sol)

```solidity
File: src/reward/PhiRewards.sol

9: import { Ownable2Step } from "@openzeppelin/contracts/access/Ownable2Step.sol";

10: import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

14: contract PhiRewards is Logo, RewardControl, Ownable2Step, IPhiRewards {

32:     constructor(address ownerAddress_) payable Ownable(ownerAddress_) { }

39:     function updateArtistReward(uint256 newArtistReward_) external onlyOwner {

46:     function updateReferralReward(uint256 newReferralReward_) external onlyOwner {

53:     function updateVerifierReward(uint256 newVerifyReward_) external onlyOwner {

60:     function updateCurateReward(uint256 newCurateReward_) external onlyOwner {

68:     function updateCuratorRewardsDistributor(address curatorRewardsDistributor_) external onlyOwner {

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/reward/PhiRewards.sol)

### <a name="M-2"></a>[M-2] Fees can be set to be greater than 100%

There should be an upper limit to reasonable fees.
A malicious owner can keep the fee rate at zero, but if a large value transfer enters the mempool, the owner can jack the rate up to the maximum and sandwich attack a user.

*Instances (3)*:

```solidity
File: src/Cred.sol

136:     function setProtocolFeeDestination(address protocolFeeDestination_)
             external
             nonZeroAddress(protocolFeeDestination_)
             onlyOwner
         {
             protocolFeeDestination = protocolFeeDestination_;
             emit ProtocolFeeDestinationChanged(_msgSender(), protocolFeeDestination_);

147:     function setProtocolFeePercent(uint256 protocolFeePercent_) external onlyOwner {
             protocolFeePercent = protocolFeePercent_;
             emit ProtocolFeePercentChanged(_msgSender(), protocolFeePercent_);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/Cred.sol)

```solidity
File: src/PhiFactory.sol

411:     function setProtocolFeeDestination(address protocolFeeDestination_)
             external
             nonZeroAddress(protocolFeeDestination_)
             onlyOwner
         {
             protocolFeeDestination = protocolFeeDestination_;
             emit ProtocolFeeDestinationSet(protocolFeeDestination_);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/PhiFactory.sol)

### <a name="M-3"></a>[M-3] Direct `supportsInterface()` calls may cause caller to revert

Calling `supportsInterface()` on a contract that doesn't implement the ERC-165 standard will result in the call reverting. Even if the caller does support the function, the contract may be malicious and consume all of the transaction's available gas. Call it via a low-level [staticcall()](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/f959d7e4e6ee0b022b41e5b644c79369869d8411/contracts/utils/introspection/ERC165Checker.sol#L119), with a fixed amount of gas, and check the return code, or use OpenZeppelin's [`ERC165Checker.supportsInterface()`](https://github.com/OpenZeppelin/openzeppelin-contracts/blob/f959d7e4e6ee0b022b41e5b644c79369869d8411/contracts/utils/introspection/ERC165Checker.sol#L36-L39).

*Instances (2)*:

```solidity
File: src/art/PhiNFT1155.sol

223:         return super.supportsInterface(interfaceId) || interfaceId == type(IPhiNFT1155).interfaceId

224:             || ERC1155Upgradeable.supportsInterface(interfaceId);

```

[Link to code](https://github.com/code-423n4/2024-08-phi/blob/main/src/art/PhiNFT1155.sol)
