// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import { PRBTest } from "@prb/test/src/PRBTest.sol";
import { StdCheats } from "forge-std/StdCheats.sol";
import { console2 } from "forge-std/console2.sol";
import { ECDSA } from "solady/utils/ECDSA.sol";
import { Settings } from "./helpers/Settings.sol";
import { IContributeRewards } from "../src/interfaces/IContributeRewards.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract ContributeRewardsTest is Settings {
    string constant credUUID = "18cd3748-9a76-4a05-8c69-ba0b8c1a9d17";

    function setUp() public override {
        super.setUp();
        // Create a cred
        vm.warp(START_TIME + 1);
        vm.startPrank(owner);
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

    function testSetRewardInfo() public {
        uint256 credId = 1;
        uint256 claimPeriodEnds = block.timestamp + 7 days;
        bytes32 merkleRoot = keccak256("test");
        uint256 totalRewardAmount = 1000 ether;

        assertGe(mockToken.balanceOf(owner), totalRewardAmount, "Insufficient token balance");

        vm.startPrank(owner);
        bool approved = mockToken.approve(address(contributeRewards), totalRewardAmount);
        assertTrue(approved, "Approval failed");

        contributeRewards.setRewardInfo(
            credId, claimPeriodEnds, merkleRoot, address(mockToken), totalRewardAmount, false
        );
        vm.stopPrank();

        (
            uint256 storedClaimPeriodEnds,
            bytes32 storedMerkleRoot,
            address storedRewardToken,
            uint256 storedTotalRewardAmount,
            uint256 storedClaimedAmount,
            address storedRewardSetter,
            bool isOpen
        ) = contributeRewards.getRewardInfo(credId, 0);

        assertEq(storedClaimPeriodEnds, claimPeriodEnds);
        assertEq(storedMerkleRoot, merkleRoot);
        assertEq(storedRewardToken, address(mockToken));
        assertEq(storedTotalRewardAmount, totalRewardAmount);
        assertEq(storedClaimedAmount, 0);
        assertEq(storedRewardSetter, owner);
        assertTrue(isOpen);
    }

    function testClaimReward() public {
        uint256 credId = 1;
        uint256 claimPeriodEnds = block.timestamp + 7 days;
        bytes32 merkleRoot = 0x1234567890123456789012345678901234567890123456789012345678901234;
        uint256 totalRewardAmount = 1000 ether;

        vm.startPrank(owner);
        mockToken.approve(address(contributeRewards), totalRewardAmount);

        contributeRewards.setRewardInfo(
            credId, claimPeriodEnds, merkleRoot, address(mockToken), totalRewardAmount, false
        );
        vm.stopPrank();

        uint256 rewardId = 0;
        uint256 claimAmount = 10 ether;
        bytes32[] memory proof = new bytes32[](1);
        proof[0] = bytes32(0x2345678901234567890123456789012345678901234567890123456789012345);

        vm.prank(user1);
        vm.expectRevert(IContributeRewards.InvalidProof.selector);
        contributeRewards.claimReward(credId, rewardId, claimAmount, proof);
    }

    function testCloseAndSweep() public {
        uint256 credId = 1;
        uint256 claimPeriodEnds = block.timestamp + 1 days;
        bytes32 merkleRoot = keccak256("test");
        uint256 totalRewardAmount = 1000 ether;

        vm.startPrank(owner);
        mockToken.approve(address(contributeRewards), totalRewardAmount);

        contributeRewards.setRewardInfo(
            credId, claimPeriodEnds, merkleRoot, address(mockToken), totalRewardAmount, false
        );

        uint256 rewardId = 0;

        vm.warp(claimPeriodEnds + 1);

        uint256 initialBalance = mockToken.balanceOf(owner);
        contributeRewards.closeAndSweep(credId, rewardId);
        uint256 finalBalance = mockToken.balanceOf(owner);
        vm.stopPrank();

        assertEq(finalBalance - initialBalance, totalRewardAmount);

        // Test that the reward is closed
        (,,,,,, bool isOpen) = contributeRewards.getRewardInfo(credId, rewardId);
        assertFalse(isOpen);
    }
}
