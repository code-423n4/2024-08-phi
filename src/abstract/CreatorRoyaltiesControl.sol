// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import { ICreatorRoyaltiesControl } from "../interfaces/ICreatorRoyaltiesControl.sol";
import { IERC2981 } from "@openzeppelin/contracts/interfaces/IERC2981.sol";

/// @title CreatorRoyaltiesControl
/// @notice Contract for managing the royalties of an ERC1155 contract
abstract contract CreatorRoyaltiesControl is ICreatorRoyaltiesControl {
    mapping(uint256 _tokenId => RoyaltyConfiguration _configuration) public royalties;
    uint256 private constant ROYALTY_BPS_TO_PERCENT = 10_000;
    address private royaltyRecipient;
    bool private initilaized;

    error InvalidRoyaltyRecipient();

    function initializeRoyalties(address _royaltyRecipient) internal {
        if (_royaltyRecipient == address(0)) revert InvalidRoyaltyRecipient();
        if (initilaized) revert AlreadyInitialized();
        royaltyRecipient = _royaltyRecipient;
        initilaized = true;
    }

    /// @notice The royalty information for a given token.
    /// @param tokenId The token ID to get the royalty information for.
    /// @return The royalty configuration for the token.
    function getRoyalties(uint256 tokenId) public view returns (RoyaltyConfiguration memory) {
        if (!initilaized) revert NotInitialized();
        RoyaltyConfiguration memory config = royalties[tokenId];
        if (config.royaltyRecipient != address(0)) {
            return config;
        }
        // Return default configuration
        return RoyaltyConfiguration({ royaltyBPS: 500, royaltyRecipient: royaltyRecipient });
    }

    /// @notice Returns the royalty information for a given token.
    /// @param tokenId The token ID to get the royalty information for.
    /// @param salePrice The sale price of the NFT asset specified by tokenId
    /// @return receiver The address of the royalty recipient
    /// @return royaltyAmount The royalty amount to be paid
    function royaltyInfo(
        uint256 tokenId,
        uint256 salePrice
    )
        public
        view
        returns (address receiver, uint256 royaltyAmount)
    {
        RoyaltyConfiguration memory config = getRoyalties(tokenId);
        royaltyAmount = (config.royaltyBPS * salePrice) / ROYALTY_BPS_TO_PERCENT;
        receiver = config.royaltyRecipient;
    }

    /// @notice Updates the royalties for a given token
    /// @param tokenId The token ID to update royalties for
    /// @param configuration The new royalty configuration
    function _updateRoyalties(uint256 tokenId, RoyaltyConfiguration memory configuration) internal {
        if (configuration.royaltyRecipient == address(0) && configuration.royaltyBPS > 0) {
            revert InvalidRoyaltyRecipient();
        }

        royalties[tokenId] = configuration;

        emit UpdatedRoyalties(tokenId, msg.sender, configuration);
    }

    /// @notice Checks if the contract supports a given interface
    /// @param interfaceId The interface identifier
    /// @return true if the contract supports the interface, false otherwise
    function supportsInterface(bytes4 interfaceId) public view virtual returns (bool) {
        return interfaceId == type(IERC2981).interfaceId;
    }
}
