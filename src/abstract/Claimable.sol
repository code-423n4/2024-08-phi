// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import { IPhiFactory } from "../interfaces/IPhiFactory.sol";

abstract contract Claimable {
    /*//////////////////////////////////////////////////////////////
                                  ERRORS
    //////////////////////////////////////////////////////////////*/
    error InvalidMerkleClaimData();

    /*//////////////////////////////////////////////////////////////
                            INTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    function getPhiFactoryContract() public view virtual returns (IPhiFactory);
    function getFactoryArtId(uint256 tokenId) public view virtual returns (uint256);

    /*//////////////////////////////////////////////////////////////
                            EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    /// @notice Processes a Signature claim.
    function signatureClaim() external payable {
        (
            bytes32 r_,
            bytes32 vs_,
            address ref_,
            address verifier_,
            address minter_,
            uint256 tokenId_,
            uint256 quantity_,
            uint256 expiresIn_,
            string memory imageURI_,
            bytes32 data_
        ) = abi.decode(
            msg.data[4:], (bytes32, bytes32, address, address, address, uint256, uint256, uint256, string, bytes32)
        );
        uint256 artId = getFactoryArtId(tokenId_);
        bytes memory claimData_ = abi.encode(expiresIn_, minter_, ref_, verifier_, artId, block.chainid, data_);
        bytes memory signature = abi.encodePacked(r_, vs_);

        IPhiFactory phiFactoryContract = getPhiFactoryContract();
        IPhiFactory.MintArgs memory mintArgs_ = IPhiFactory.MintArgs(tokenId_, quantity_, imageURI_);
        phiFactoryContract.signatureClaim{ value: msg.value }(signature, claimData_, mintArgs_);
    }

    /// @notice Processes a merkle claim.
    function merkleClaim() external payable {
        (
            address minter,
            bytes32[] memory proof,
            address ref,
            uint256 tokenId,
            uint256 quantity,
            bytes32 leafPart,
            string memory imageURI
        ) = _decodeMerkleClaimData();

        uint256 artId = getFactoryArtId(tokenId);
        IPhiFactory phiFactory = getPhiFactoryContract();

        bytes memory claimData = abi.encode(minter, ref, artId);

        IPhiFactory.MintArgs memory mintArgs = IPhiFactory.MintArgs(tokenId, quantity, imageURI);
        phiFactory.merkleClaim{ value: msg.value }(proof, claimData, mintArgs, leafPart);
    }

    function _decodeMerkleClaimData()
        private
        pure
        returns (
            address minter,
            bytes32[] memory proof,
            address ref,
            uint256 tokenId,
            uint256 quantity,
            bytes32 leafPart,
            string memory imageURI
        )
    {
        if (msg.data.length < 260) revert InvalidMerkleClaimData();

        (minter, proof, ref, tokenId, quantity, leafPart, imageURI) =
            abi.decode(msg.data[4:], (address, bytes32[], address, uint256, uint256, bytes32, string));
    }
}
