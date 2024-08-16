// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.25;

import { PRBTest } from "@prb/test/src/PRBTest.sol";
import { Test } from "forge-std/Test.sol";
import { console2 } from "forge-std/console2.sol";
import { ECDSA } from "solady/utils/ECDSA.sol";
import { LibClone } from "solady/utils/LibClone.sol";
import { Settings } from "./helpers/Settings.sol";
import { Cred } from "../src/Cred.sol";
import { ICred } from "../src/interfaces/ICred.sol";
import { BondingCurve } from "../src/curve/BondingCurve.sol";

contract TestCred is Settings {
    uint256 private constant GRACE_PERIOD = 14 days;
    uint256 private constant CLEARING_PERIOD = 30 days;
    string constant credUUID = "18cd3748-9a76-4a05-8c69-ba0b8c1a9d17";

    function setUp() public override {
        super.setUp();
    }

    function test_constructor() public view {
        assertEq(cred.owner(), owner, "owner is correct");
        assertEq(cred.protocolFeeDestination(), protocolFeeDestination, "protocolFeeDestination is correct");
        assertEq(cred.protocolFeePercent(), 500, "protocolFeePercen is correct");
    }

    function _createCred(string memory credType, string memory verificationType, bytes32 merkleRoot) internal {
        vm.warp(START_TIME + 1);
        vm.startPrank(participant);
        uint256 credId = 1;
        uint256 supply = 0;
        uint256 amount = 1;
        uint256 expiresIn = START_TIME + 100;
        uint256 buyPrice = bondingCurve.getBuyPriceAfterFee(credId, supply, amount);
        string memory credURL = "test";
        bytes memory signCreateData = abi.encode(
            expiresIn, participant, 31_337, address(bondingCurve), credURL, credType, verificationType, merkleRoot
        );
        bytes32 createMsgHash = keccak256(signCreateData);
        bytes32 createDigest = ECDSA.toEthSignedMessageHash(createMsgHash);
        (uint8 cv, bytes32 cr, bytes32 cs) = vm.sign(claimSignerPrivateKey, createDigest);
        if (cv != 27) cs = cs | bytes32(uint256(1) << 255);

        cred.createCred{ value: buyPrice }(participant, signCreateData, abi.encodePacked(cr, cs), 100, 100);
        vm.stopPrank();
    }

    /*//////////////////////////////////////////////////////////////
                             Trade
    //////////////////////////////////////////////////////////////*/
    function test_createCred() public {
        vm.warp(START_TIME + 1);

        _createCred("BASIC", "SIGNATURE", 0x0);
        cred.isShareHolder(1, participant);

        assertEq(cred.isShareHolder(1, participant), true, "cred 1 is voted by participant");
    }

    function test_updateCred() public {
        vm.warp(START_TIME + 1);
        uint256 credId = 1;
        _createCred("BASIC", "SIGNATURE", 0x0);

        vm.startPrank(participant);
        string memory credURL = "test";
        uint256 expiresIn = START_TIME + 100;
        bytes memory signCreateData = abi.encode(expiresIn, participant, 31_337, credId, credURL);
        bytes32 createMsgHash = keccak256(signCreateData);
        bytes32 createDigest = ECDSA.toEthSignedMessageHash(createMsgHash);
        (uint8 cv, bytes32 cr, bytes32 cs) = vm.sign(claimSignerPrivateKey, createDigest);
        if (cv != 27) cs = cs | bytes32(uint256(1) << 255);
        cred.updateCred(signCreateData, abi.encodePacked(cr, cs), 80, 110);
        vm.stopPrank();

        Cred.PhiCred memory credInfo = cred.credInfo(credId);
        assertEq(credInfo.buyShareRoyalty, 80, "buy royalty is correct");
        assertEq(credInfo.sellShareRoyalty, 110, "sell royalty is correct");
    }

    function test_TradeAction() public {
        _createCred("BASIC", "SIGNATURE", 0x0);
        uint256 buyPrice = bondingCurve.getBuyPriceAfterFee(1, 1, 1);
        assertEq(buyPrice, 1_091_874_359_329_268, "buy price is correct");
        vm.startPrank(anyone);
        cred.buyShareCred{ value: buyPrice }(1, 1, 0);
        assertEq(cred.isShareHolder(1, anyone), true, "cred 0 is voted by anyone");
    }

    function test_SellAction() public {
        _createCred("BASIC", "SIGNATURE", 0x0);
        vm.startPrank(anyone);
        uint256 buyPrice = bondingCurve.getBuyPriceAfterFee(1, 1, 1);
        uint256 maxPrice = bondingCurve.getBuyPriceAfterFee(1, 1, 2);

        cred.buyShareCred{ value: buyPrice }(1, 1, maxPrice);
        assertEq(cred.isShareHolder(1, anyone), true, "cred 1 is voted by anyone");
        vm.warp(block.timestamp + 10 minutes + 1 seconds);
        uint256 minPrice = bondingCurve.getSellPriceAfterFee(1, 1, 1);
        cred.sellShareCred(1, 1, minPrice);
        assertEq(cred.isShareHolder(1, anyone), false, "cred 1 isnt voted by anyone");
    }

    function test_batchTradeAction() public {
        vm.warp(START_TIME + 1);

        _createCred("BASIC", "SIGNATURE", 0x0);
        _createCred("ADVANCED", "SIGNATURE", 0x0);

        uint256[] memory credIds = new uint256[](2);
        credIds[0] = 1;
        credIds[1] = 2;
        bool[] memory checks = new bool[](2);
        checks[0] = true;
        checks[1] = true;
        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 1;
        amounts[1] = 1;

        vm.startPrank(anyone);
        uint256 sumPrice = cred.getBatchBuyPrice(credIds, amounts);
        uint256[] memory maxPrices = new uint256[](2);
        maxPrices[0] = bondingCurve.getBuyPriceAfterFee(1, 1, 2);
        maxPrices[1] = bondingCurve.getBuyPriceAfterFee(2, 1, 2);

        cred.batchBuyShareCred{ value: sumPrice }(credIds, amounts, maxPrices, anyone);
        vm.stopPrank();
        assertEq(cred.isShareHolder(1, anyone), true, "cred 1 is voted by anyone");
        assertEq(cred.isShareHolder(2, anyone), true, "cred 2 is voted by anyone");
        address[] memory vote2addresses = cred.getCuratorAddresses(2, 0, 0);
        assertEq(vote2addresses[0], participant, "vote1addresses[0] is correct");
        assertEq(vote2addresses[1], anyone, "vote1addresses[1] is correct");
        assertEq(vote2addresses.length, 2, "vote1addresses length is correct");

        vm.startPrank(anyone);
        vm.warp(block.timestamp + 10 minutes + 1 seconds);
        uint256[] memory minPrices = new uint256[](2);
        minPrices[0] = bondingCurve.getSellPriceAfterFee(1, 1, 1);
        minPrices[1] = bondingCurve.getSellPriceAfterFee(2, 1, 1);
        cred.batchSellShareCred(credIds, amounts, minPrices);
        address[] memory vote1addresses = cred.getCuratorAddresses(1, 0, 0);
        assertEq(vote1addresses[0], participant, "vote1addresses[0] is correct");
        assertEq(cred.isShareHolder(1, anyone), false, "cred 1 isnt voted by anyone");
        assertEq(cred.isShareHolder(2, anyone), false, "cred 2 isnt voted by anyone");
        assertEq(vote1addresses.length, 1, "vote1addresses length is correct");
    }

    function test_setUpMerkleTree() public {
        vm.warp(START_TIME + 1);

        bytes32 merkleRoot = 0xdc4c272ceaa7b5ba9e0f3f9972f735f14e1b4ed191e15d0d17afc62792226428;

        _createCred("BASIC", "MERKLE", merkleRoot);

        uint256 credId = cred.credIdCounter() - 1;
        bytes32 root = cred.getRoot(credId);
        assertEq(root, merkleRoot, "merkle root is correct");
    }

    function test_setUpMerkleTreeWithValue() public {
        vm.warp(START_TIME + 1);

        bytes32 merkleRoot = 0xdc4c272ceaa7b5ba9e0f3f9972f735f14e1b4ed191e15d0d17afc62792226428;
        _createCred("ADVANCED", "MERKLE", merkleRoot);

        uint256 credId = cred.credIdCounter() - 1;
        assertEq(cred.getRoot(credId), merkleRoot, "merkle root is correct");
    }

    function testBuyMaxSupply() public {
        uint256 credId = 1;
        uint256 amount = 1;

        bytes32 merkleRoot = 0xdc4c272ceaa7b5ba9e0f3f9972f735f14e1b4ed191e15d0d17afc62792226428;
        _createCred("ADVANCED", "MERKLE", merkleRoot);

        assertEq(cred.getShareNumber(credId, participant), amount);

        uint256 buyAmount = 998;
        vm.deal(anyone, 10_809 ether);

        uint256 price = bondingCurve.getBuyPriceAfterFee(credId, amount, buyAmount);
        vm.startPrank(anyone);
        cred.buyShareCred{ value: price }(credId, buyAmount, 0);
        vm.stopPrank();
        assertEq(cred.getShareNumber(credId, anyone), buyAmount);
        assertEq(cred.credInfo(credId).currentSupply, amount + buyAmount);
    }

    function testBuyAndSellOneByOneUpTo999() public {
        uint256 credId = 1;
        bytes32 merkleRoot = 0xdc4c272ceaa7b5ba9e0f3f9972f735f14e1b4ed191e15d0d17afc62792226428;

        // Create the initial cred
        _createCred("ADVANCED", "MERKLE", merkleRoot);

        address[] memory buyers = new address[](998);

        vm.warp(START_TIME + 1);
        // Buy one by one up to 998
        for (uint256 i = 0; i < 998; i++) {
            address buyer = makeAddr(string(abi.encodePacked("buyer", i)));
            buyers[i] = buyer;
            vm.deal(buyer, 11_000 ether);

            vm.startPrank(buyer);
            uint256 currentSupply = cred.credInfo(credId).currentSupply;
            uint256 buyAmount = 1;
            uint256 price = bondingCurve.getBuyPriceAfterFee(credId, currentSupply, buyAmount);

            cred.buyShareCred{ value: price }(credId, buyAmount, 0);

            assertEq(cred.getShareNumber(credId, buyer), buyAmount);
            assertEq(cred.credInfo(credId).currentSupply, currentSupply + buyAmount);
            vm.stopPrank();
        }

        assertEq(cred.credInfo(credId).currentSupply, 999); // 1 initial + 998 purchases

        vm.warp(block.timestamp + 10 minutes + 1 seconds);
        // Sell one by one from 999 to 1
        for (uint256 i = 0; i < 998; i++) {
            address seller = buyers[997 - i]; // Sell in reverse order

            vm.startPrank(seller);
            uint256 currentSupply = cred.credInfo(credId).currentSupply;
            uint256 sellAmount = 1;
            uint256 sellPrice = bondingCurve.getSellPriceAfterFee(credId, currentSupply, sellAmount);

            uint256 balanceBefore = seller.balance;

            cred.sellShareCred(credId, sellAmount, 0);
            uint256 balanceAfter = seller.balance;

            assertEq(cred.getShareNumber(credId, seller), 0);
            assertEq(cred.credInfo(credId).currentSupply, currentSupply - sellAmount);
            assertEq(balanceAfter - balanceBefore, sellPrice, "Seller should receive correct amount");
            vm.stopPrank();
        }

        // Final assertions
        assertEq(cred.credInfo(credId).currentSupply, 1); // Only initial purchase remains
    }
}
