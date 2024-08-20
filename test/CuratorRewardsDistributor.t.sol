// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import { PRBTest } from "@prb/test/src/PRBTest.sol";
import { StdCheats } from "forge-std/StdCheats.sol";
import { console2 } from "forge-std/console2.sol";

import { Settings } from "./helpers/Settings.sol";
import { ECDSA } from "solady/utils/ECDSA.sol";
import { ICred } from "../src/interfaces/ICred.sol";
import { ICuratorRewardsDistributor } from "../src/interfaces/ICuratorRewardsDistributor.sol";
import { IPhiRewards } from "../src/interfaces/IPhiRewards.sol";

contract CuratorRewardsDistributorTest is Settings {
    string constant credUUID = "18cd3748-9a76-4a05-8c69-ba0b8c1a9d17";

    function setUp() public override {
        super.setUp();
        vm.warp(START_TIME + 1);
        vm.startPrank(owner);
        // Create a cred
        string memory credURL = "test";
        uint256 expiresIn = START_TIME + 100;
        bytes memory signCreateData =
            abi.encode(expiresIn, owner, 31_337, address(bondingCurve), credURL, "BASIC", "SIGNATURE", bytes32(0));
        bytes32 createMsgHash = keccak256(signCreateData);
        bytes32 createDigest = ECDSA.toEthSignedMessageHash(createMsgHash);
        (uint8 cv, bytes32 cr, bytes32 cs) = vm.sign(claimSignerPrivateKey, createDigest);
        if (cv != 27) cs = cs | bytes32(uint256(1) << 255);

        uint256 buyPrice = bondingCurve.getBuyPriceAfterFee(0, 0, 1);
        cred.createCred{ value: buyPrice }(participant, signCreateData, abi.encodePacked(cr, cs), 100, 100);

        vm.stopPrank();
    }

    function testDistribute() public {
        uint256 credId = 1;
        uint256 depositAmount = 1 ether;

        // Deposit some ETH to the curatorRewardsDistributor
        curatorRewardsDistributor.deposit{ value: depositAmount }(credId, depositAmount);

        // Signal creds for different users
        vm.startPrank(user1);
        vm.deal(user1, bondingCurve.getBuyPriceAfterFee(credId, 1, 1));
        cred.buyShareCred{ value: bondingCurve.getBuyPriceAfterFee(credId, 1, 1) }(credId, 1, 0);
        vm.stopPrank();

        vm.startPrank(user2);
        vm.deal(user2, bondingCurve.getBuyPriceAfterFee(credId, 2, 2));
        cred.buyShareCred{ value: bondingCurve.getBuyPriceAfterFee(credId, 2, 2) }(credId, 2, 0);
        vm.stopPrank();

        assertEq(cred.getShareNumber(credId, user1), 1, "Signal count should be 1");
        assertEq(cred.getShareNumber(credId, user2), 2, "Signal count should be 2");
        assertEq(cred.getCurrentSupply(credId), 4, "Signal count should be 3");
        assertEq(cred.getCuratorAddressLength(credId), 3, "Signal count should be 3");

        // Record initial balances
        uint256 initialUser1Balance = phiRewards.balanceOf(user1);
        uint256 initialUser2Balance = phiRewards.balanceOf(user2);
        uint256 ownerBalance = owner.balance;

        // Distribute rewards
        vm.prank(owner);
        curatorRewardsDistributor.distribute(credId);

        // Check final balances
        uint256 finalUser1Balance = phiRewards.balanceOf(user1);
        uint256 finalUser2Balance = phiRewards.balanceOf(user2);
        uint256 finalOwnerBalance = owner.balance;

        // Assert the distribution
        assertEq(
            finalUser1Balance - initialUser1Balance,
            (depositAmount - depositAmount / 100) / 4,
            "User1 should receive 1/4 of the rewards"
        );
        assertEq(
            finalUser2Balance - initialUser2Balance,
            ((depositAmount - depositAmount / 100) * 2) / 4,
            "User2 should receive 2/4 of the rewards"
        );
        assertEq(
            finalOwnerBalance - ownerBalance, (depositAmount / 100), "Distributer should receive 1/100 of the rewards"
        );

        // Check that the balance in curatorRewardsDistributor is now 0
        assertEq(
            curatorRewardsDistributor.balanceOf(credId),
            0,
            "CuratorRewardsDistributor balance should be 0 after distribution"
        );
    }

    function testDistributeNoBalance() public {
        uint256 credId = 1;

        vm.expectRevert(ICuratorRewardsDistributor.NoBalanceToDistribute.selector);
        curatorRewardsDistributor.distribute(credId);
    }

    function testDistributeNoShares() public {
        uint256 credId = 1;
        vm.prank(owner);

        vm.warp(block.timestamp + 10 minutes + 1 seconds);
        cred.sellShareCred(credId, 1, 0);
        uint256 depositAmount = 1 ether;

        // Deposit some ETH to the curatorRewardsDistributor
        curatorRewardsDistributor.deposit{ value: depositAmount }(credId, depositAmount);

        vm.expectRevert(ICuratorRewardsDistributor.NoSharesToDistribute.selector);
        curatorRewardsDistributor.distribute(credId);
    }
}
