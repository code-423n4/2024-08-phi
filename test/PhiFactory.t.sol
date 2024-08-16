// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.25;

import { PRBTest } from "@prb/test/src/PRBTest.sol";
import { Test } from "forge-std/Test.sol";
import { console2 } from "forge-std/console2.sol";

import { Settings } from "./helpers/Settings.sol";
import { LibString } from "solady/utils/LibString.sol";
import { IERC1155 } from "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import { IPhiFactory } from "../src/interfaces/IPhiFactory.sol";
import { ECDSA } from "solady/utils/ECDSA.sol";
import { LibZip } from "solady/utils/LibZip.sol";
import { MerkleProofLib } from "solady/utils/MerkleProofLib.sol";
import { IPhiFactory } from "../src/interfaces/IPhiFactory.sol";
import { IPhiNFT1155Ownable } from "../src/interfaces/IPhiNFT1155Ownable.sol";
import { ICreatorRoyaltiesControl } from "../src/interfaces/ICreatorRoyaltiesControl.sol";

contract TestPhiFactory is Settings {
    string ART_ID_URL_STRING;
    string ART_ID2_URL_STRING;
    string IMAGE_URL;
    string IMAGE_URL2;
    uint256 expiresIn;
    bytes[] datasCompressed = new bytes[](2);

    function setUp() public override {
        super.setUp();

        ART_ID_URL_STRING = "333L2H5BLDwyojZtOi-7TSCqFM7ISlsDOIlAfTUs5es";
        ART_ID2_URL_STRING = "432CqFM7ISlsDOIlA-7TSCqFM7ISlsDOIlAfTUs5es";
        IMAGE_URL = "https://example.com/image.png";
        IMAGE_URL2 = "https://example.com/image2.png";

        expiresIn = START_TIME + 100;

        _createCred("BASIC", "SIGNATURE", 0x0);
        vm.warp(START_TIME + 1);
    }

    function _createCred(string memory credType, string memory verificationType, bytes32 merkleRoot) internal {
        vm.warp(START_TIME + 1);
        vm.startPrank(participant);
        uint256 credId = 1;
        uint256 supply = 0;
        uint256 amount = 1;

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

    function _createArt(string memory artIdUrl_) internal {
        bytes memory credData = abi.encode(1, owner, "SIGNATURE", 31_337, bytes32(0));
        bytes memory signCreateData = abi.encode(expiresIn, artIdUrl_, credData);
        bytes32 createMsgHash = keccak256(signCreateData);
        bytes32 createDigest = ECDSA.toEthSignedMessageHash(createMsgHash);
        (uint8 cv, bytes32 cr, bytes32 cs) = vm.sign(claimSignerPrivateKey, createDigest);
        if (cv != 27) cs = cs | bytes32(uint256(1) << 255);
        IPhiFactory.CreateConfig memory config =
            IPhiFactory.CreateConfig(artCreator, receiver, END_TIME, START_TIME, MAX_SUPPLY, MINT_FEE, false);
        phiFactory.createArt{ value: NFT_ART_CREATE_FEE }(signCreateData, abi.encodePacked(cr, cs), config);
    }

    function test_constructor() public view {
        assertEq(phiFactory.owner(), owner, "owner is correct");
        assertEq(phiFactory.protocolFeeDestination(), protocolFeeDestination, "protocolFeeDestination is correct");
    }

    function test_contractURI() public {
        // Create an art
        string memory artId = "sample-art-id";
        _createArt(artId);

        // Get the art address
        address artAddress = phiFactory.getArtAddress(1);

        // Call the contractURI function
        string memory uri = phiFactory.contractURI(artAddress);
        console2.log(uri);
        // Check if the returned URI starts with the expected prefix
        assertTrue(bytes(uri).length > 0, "contractURI should return a non-empty string");
    }

    /*//////////////////////////////////////////////////////////////
                                CLAIM
    //////////////////////////////////////////////////////////////*/
    function test_claimMerkle() public {
        _createArt(ART_ID_URL_STRING);

        bytes32 expectedRoot = 0xe70e719557c28ce2f2f3545d64c633728d70fbcfe6ae3db5fa01420573e0f34b;
        bytes memory credData = abi.encode(1, owner, "MERKLE", 31_337, expectedRoot);
        bytes memory signCreateData = abi.encode(expiresIn, ART_ID2_URL_STRING, credData);
        bytes32 createMsgHash = keccak256(signCreateData);
        bytes32 createDigest = ECDSA.toEthSignedMessageHash(createMsgHash);
        (uint8 cv, bytes32 cr, bytes32 cs) = vm.sign(claimSignerPrivateKey, createDigest);
        if (cv != 27) cs = cs | bytes32(uint256(1) << 255);
        phiFactory.createArt{ value: NFT_ART_CREATE_FEE }(
            signCreateData,
            abi.encodePacked(cr, cs),
            IPhiFactory.CreateConfig(participant, receiver, END_TIME, START_TIME, MAX_SUPPLY, MINT_FEE, false)
        );

        bytes32[] memory proof = new bytes32[](2);
        proof[0] = 0x0927f012522ebd33191e00fe62c11db25288016345e12e6b63709bb618d777d4;
        proof[1] = 0xdd05ddd79adc5569806124d3c5d8151b75bc81032a0ea21d4cd74fd964947bf5;
        address to = 0x1111111111111111111111111111111111111111;
        bytes32 value = 0x0000000000000000000000000000000003c2f7086aed236c807a1b5000000000;
        uint256 artId = 2;
        bytes memory data = abi.encode(artId, to, proof, referrer, uint256(2), value, IMAGE_URL2);

        bytes memory dataCompressed = LibZip.cdCompress(data);
        uint256 totalMintFee = phiFactory.getArtMintFee(artId, 2);

        vm.startPrank(participant, participant);

        assertEq(
            phiFactory.checkProof(
                proof,
                keccak256(bytes.concat(keccak256(abi.encode(to, value)))),
                0xe70e719557c28ce2f2f3545d64c633728d70fbcfe6ae3db5fa01420573e0f34b //expectedRoot
            ),
            true,
            "merkle proof is correct"
        );

        phiFactory.claim{ value: totalMintFee }(dataCompressed);
    }

    function test_claim_1155_with_ref() public {
        _createArt(ART_ID_URL_STRING);
        uint256 artId = 1;
        bytes32 advanced_data = bytes32("1");
        bytes memory signData =
            abi.encode(expiresIn, participant, referrer, verifier, artId, block.chainid, advanced_data);
        bytes32 msgHash = keccak256(signData);
        bytes32 digest = ECDSA.toEthSignedMessageHash(msgHash);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(claimSignerPrivateKey, digest);
        if (v != 27) s = s | bytes32(uint256(1) << 255);
        bytes memory signature = abi.encodePacked(r, s);
        bytes memory data =
            abi.encode(1, participant, referrer, verifier, expiresIn, uint256(1), advanced_data, IMAGE_URL, signature);
        bytes memory dataCompressed = LibZip.cdCompress(data);
        uint256 totalMintFee = phiFactory.getArtMintFee(1, 1);

        vm.startPrank(participant, participant);
        phiFactory.claim{ value: totalMintFee }(dataCompressed);

        // referrer payout
        address artAddress = phiFactory.getArtAddress(1);
        assertEq(IERC1155(artAddress).balanceOf(participant, 1), 1, "particpiant erc1155 balance");

        assertEq(curatorRewardsDistributor.balanceOf(1), CURATE_REWARD, "epoch fee");
    }

    function test_batchClaim_1155_with_ref() public {
        _createCred("BASIC", "SIGNATURE", 0x0);
        expiresIn = START_TIME + 100;
        vm.startPrank(artCreator);
        _createArt(ART_ID_URL_STRING);
        bytes memory credData = abi.encode(2, owner, "SIGNATURE", 31_337, bytes32(0));
        bytes memory signCreateData = abi.encode(expiresIn, ART_ID2_URL_STRING, credData);

        bytes32 createDigest = ECDSA.toEthSignedMessageHash(keccak256(signCreateData));
        (uint8 cv, bytes32 cr, bytes32 cs) = vm.sign(claimSignerPrivateKey, createDigest);
        if (cv != 27) cs = cs | bytes32(uint256(1) << 255);
        IPhiFactory.CreateConfig memory config =
            IPhiFactory.CreateConfig(participant, receiver, END_TIME, START_TIME, MAX_SUPPLY, MINT_FEE, false);
        vm.warp(START_TIME + 1);
        phiFactory.createArt{ value: NFT_ART_CREATE_FEE }(signCreateData, abi.encodePacked(cr, cs), config);

        uint256 artId = 1;
        bytes memory signData =
            abi.encode(expiresIn, participant, referrer, verifier, artId, block.chainid, bytes32("1"));
        bytes32 digest = ECDSA.toEthSignedMessageHash(keccak256(signData));
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(claimSignerPrivateKey, digest);
        if (v != 27) s = s | bytes32(uint256(1) << 255);
        bytes memory signature = abi.encodePacked(r, s);
        bytes memory data = abi.encode(
            artId, participant, referrer, verifier, expiresIn, uint256(1), bytes32("1"), IMAGE_URL, signature
        );
        datasCompressed[0] = LibZip.cdCompress(data);

        uint256 artId2 = 2;
        bytes memory signData2 =
            abi.encode(expiresIn, participant, referrer, verifier, artId2, block.chainid, bytes32("1"));
        bytes32 digest2 = ECDSA.toEthSignedMessageHash(keccak256(signData2));
        (uint8 v2, bytes32 r2, bytes32 s2) = vm.sign(claimSignerPrivateKey, digest2);
        if (v2 != 27) s2 = s2 | bytes32(uint256(1) << 255);
        bytes memory signature2 = abi.encodePacked(r2, s2);
        bytes memory data2 = abi.encode(
            artId2, participant, referrer, verifier, expiresIn, uint256(2), bytes32("1"), IMAGE_URL2, signature2
        );
        datasCompressed[1] = LibZip.cdCompress(data2);

        uint256[] memory artIds = new uint256[](2);
        artIds[0] = 1;
        artIds[1] = 2;
        uint256[] memory quantities = new uint256[](2);
        quantities[0] = 1;
        quantities[1] = 2;
        uint256 totalMintFee = phiFactory.getTotalMintFee(artIds, quantities);

        uint256[] memory mintFee = new uint256[](2);
        mintFee[0] = phiFactory.getArtMintFee(1, 1);
        mintFee[1] = phiFactory.getArtMintFee(2, 2);

        vm.warp(START_TIME + 2);
        vm.startPrank(participant, participant);
        phiFactory.batchClaim{ value: totalMintFee }(datasCompressed, mintFee);

        // referrer payout
        address artAddress = phiFactory.getArtAddress(artIds[0]);
        assertEq(IERC1155(artAddress).balanceOf(participant, 1), 1, "particpiant erc1155 balance");

        address artAddress2 = phiFactory.getArtAddress(artIds[1]);
        assertEq(IERC1155(artAddress2).balanceOf(participant, 1), 2, "particpiant erc1155 balance");

        assertEq(curatorRewardsDistributor.balanceOf(1), CURATE_REWARD, "epoch fee");
        assertEq(curatorRewardsDistributor.balanceOf(2), CURATE_REWARD * 2, "epoch fee");
        vm.startPrank(verifier);
        phiRewards.withdraw(verifier, VERIFY_REWARD * 3);
        assertEq(verifier.balance, 1 ether + VERIFY_REWARD * 3, "verify fee");
    }

    function test_createTokenId2() public {
        vm.startPrank(participant);
        string memory artId1 = "rL5L2H5BLDwyojZtOi-7TSCqFM7ISlsDOIlAfTUs5et";
        string memory artId2 = "7TSCqFM7ISlsDOIlAf-7TSCqFM7ISlsDOIlAfTUs5ts";
        _createArt(artId1);
        _createArt(artId2);

        address artAddress = phiFactory.getArtAddress(1);
        address artAddress2 = phiFactory.getArtAddress(2);

        assertEq(artAddress, artAddress2, "artAddress is correct");
    }

    function test_updateArtSettings() public {
        // Create an art for testing
        string memory artIdURL = "sample-art-id";
        _createArt(artIdURL);
        uint256 artIdNum = 1;

        // Get the current art settings
        IPhiFactory.ArtData memory originalArt = phiFactory.artData(artIdNum);

        // Prepare new settings
        string memory newUrl = "new-url";

        address newReceiver = address(0x456);
        address newRoyaltyReceiver = address(0x789);
        uint256 newMaxSupply = originalArt.maxSupply + 100;
        uint256 newMintFee = originalArt.mintFee + 1 ether;
        uint256 newStartTime = originalArt.startTime + 1 days;
        uint256 newEndTime = originalArt.endTime + 2 days;
        bool newSoulBounded = !originalArt.soulBounded;
        IPhiNFT1155Ownable.RoyaltyConfiguration memory newRoyaltyConfig = ICreatorRoyaltiesControl.RoyaltyConfiguration({
            royaltyRecipient: newRoyaltyReceiver,
            royaltyBPS: 500 // 5%
         });

        // Call the function
        vm.prank(artCreator);
        phiFactory.updateArtSettings(
            artIdNum,
            newUrl,
            newReceiver,
            newMaxSupply,
            newMintFee,
            newStartTime,
            newEndTime,
            newSoulBounded,
            newRoyaltyConfig
        );

        // Get the updated art settings
        IPhiFactory.ArtData memory updatedArt = phiFactory.artData(artIdNum);

        // Assert the changes
        assertEq(updatedArt.uri, newUrl, "uri should be updated");
        assertEq(updatedArt.receiver, newReceiver, "receiver should be updated");
        assertEq(updatedArt.maxSupply, newMaxSupply, "maxSupply should be updated");
        assertEq(updatedArt.mintFee, newMintFee, "mintFee should be updated");
        assertEq(updatedArt.startTime, newStartTime, "startTime should be updated");
        assertEq(updatedArt.endTime, newEndTime, "endTime should be updated");
        assertEq(updatedArt.soulBounded, newSoulBounded, "soulBounded should be updated");

        // Assert the royalty configuration
        IPhiNFT1155Ownable.RoyaltyConfiguration memory checkRoyaltyConfig =
            IPhiNFT1155Ownable(updatedArt.artAddress).getRoyalties(updatedArt.tokenId);
        assertEq(newRoyaltyReceiver, checkRoyaltyConfig.royaltyRecipient, "royalty receiver should be updated");
        assertEq(500, checkRoyaltyConfig.royaltyBPS, "royalty bps should be updated");
    }
}
