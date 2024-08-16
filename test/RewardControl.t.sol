// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.25;

import { PRBTest } from "@prb/test/src/PRBTest.sol";
import { Test } from "forge-std/Test.sol";
import { console2 } from "forge-std/console2.sol";

import { PhiRewards } from "../src/reward/PhiRewards.sol";
import { Settings } from "./helpers/Settings.sol";

contract TestRewardControl is Settings {
    function setUp() public override {
        super.setUp();
    }

    // function getDomainSeparator() internal view virtual returns (bytes32) {
    //     return keccak256(
    //         abi.encode(
    //             keccak256("EIP712Domain(string name,string version,uint256 chainId,address verifyingContract)"),
    //             keccak256(bytes("PhiRewards")),
    //             keccak256(bytes("1")),
    //             block.chainid,
    //             address(phiRewards)
    //         )
    //     );
    // }

    /*//////////////////////////////////////////////////////////////
                             Deposit
    //////////////////////////////////////////////////////////////*/
    function testDeposit(uint256 amount, address to) public {
        vm.assume(amount < ETH_SUPPLY);
        vm.assume(to != address(0));

        vm.deal(participant, amount);

        assertEq(phiRewards.balanceOf(to), 0);
        vm.prank(participant);
        phiRewards.deposit{ value: amount }(to, bytes4(0), "test");
        assertEq(phiRewards.balanceOf(to), amount);
    }

    function testDepositBatch(uint8 numRecipients) public {
        address[] memory recipients = new address[](numRecipients);
        uint256[] memory amounts = new uint256[](numRecipients);
        bytes4[] memory reasons = new bytes4[](numRecipients);

        uint256 totalValue;

        for (uint256 i; i < numRecipients; ++i) {
            recipients[i] = makeAddr(vm.toString(i + 1));
            amounts[i] = i + 1 ether;

            totalValue += amounts[i];
        }

        vm.deal(participant, totalValue);
        vm.prank(participant);
        phiRewards.depositBatch{ value: totalValue }(recipients, amounts, reasons, "test");

        for (uint256 i; i < numRecipients; ++i) {
            assertEq(phiRewards.balanceOf(recipients[i]), amounts[i]);
        }
    }

    /*//////////////////////////////////////////////////////////////
                             Withdraw
    //////////////////////////////////////////////////////////////*/
    function testWithdraw() public {
        uint256 beforeCreatorBalance = artCreator.balance;
        uint256 beforeTotalSupply = phiRewards.totalSupply();

        uint256 creatorRewardsBalance = phiRewards.balanceOf(artCreator);

        vm.prank(artCreator);
        phiRewards.withdraw(artCreator, creatorRewardsBalance);

        assertEq(artCreator.balance, beforeCreatorBalance + creatorRewardsBalance);
        assertEq(phiRewards.totalSupply(), beforeTotalSupply - creatorRewardsBalance);
    }

    function testWithdrawFullBalance() public {
        uint256 beforeCreatorBalance = artCreator.balance;
        uint256 beforeTotalSupply = phiRewards.totalSupply();

        uint256 creatorRewardsBalance = phiRewards.balanceOf(artCreator);

        vm.prank(artCreator);
        phiRewards.withdraw(artCreator, 0);

        assertEq(artCreator.balance, beforeCreatorBalance + creatorRewardsBalance);
        assertEq(phiRewards.totalSupply(), beforeTotalSupply - creatorRewardsBalance);
    }

    function testWithdrawFor() public {
        uint256 beforeCreatorBalance = artCreator.balance;
        uint256 beforeTotalSupply = phiRewards.totalSupply();

        uint256 creatorRewardsBalance = phiRewards.balanceOf(artCreator);

        phiRewards.withdrawFor(artCreator, creatorRewardsBalance);

        assertEq(artCreator.balance, beforeCreatorBalance + creatorRewardsBalance);
        assertEq(phiRewards.totalSupply(), beforeTotalSupply - creatorRewardsBalance);
    }

    function testWithdrawWithSig() public {
        uint256 artCreatorRewardsBalance = phiRewards.balanceOf(artCreator);

        (, uint256 artCreatorPrivateKey) = makeAddrAndKey("artCreator");

        uint256 nonce = phiRewards.nonces(artCreator);
        uint256 deadline = block.timestamp + 1 days;

        uint256 beforeartCreatorBalance = artCreator.balance;
        uint256 beforeTotalSupply = phiRewards.totalSupply();

        bytes memory sig =
            _signMint(artCreatorPrivateKey, artCreator, artCreator, artCreatorRewardsBalance, nonce, deadline);
        phiRewards.withdrawWithSig(artCreator, artCreator, artCreatorRewardsBalance, deadline, sig);

        assertEq(artCreator.balance, beforeartCreatorBalance + artCreatorRewardsBalance);
        assertEq(phiRewards.totalSupply(), beforeTotalSupply - artCreatorRewardsBalance);
    }

    function _signMint(
        uint256 pk,
        address from,
        address to,
        uint256 amount,
        uint256 nonce,
        uint256 deadline
    )
        public
        returns (bytes memory signature)
    {
        bytes32 digest = phiRewards.hashTypedData(
            keccak256(abi.encode(phiRewards.WITHDRAW_TYPEHASH(), from, to, amount, nonce++, deadline))
        );
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(pk, digest);
        signature = abi.encodePacked(r, s, v);
        assertEq(signature.length, 65);
    }
}
