// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

interface ICred {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/
    error InvalidAddressZero();
    error InsufficientPayment();
    error InsufficientShares();
    error AddressNotSigned();
    error InvalidCredType();
    error InvalidVerificationType();
    error UnauthorizedCaller();
    error InvalidArrayLength();
    error InsufficientBatchPayment();
    error Reentrancy();
    error InvalidPaginationParameters();
    error MaxSupplyReached();
    error SignatureExpired();
    error InvalidAmount();
    error Unauthorized();
    error InvalidMerkleRoot();
    error CredNotClosed();
    error AlreadyClosed(uint256 credId);
    error GracePeriodNotOver(uint256 credId, uint256 lastTradeTimestamp, uint256 gracePeriodEnd);
    error EmptyBatchOperation();
    error ClearingPeriodNotOver(uint256 credId, uint256 periodEnds);
    error DuplicateCredId();
    error InvalidRoyaltyRange();
    error InvalidCredId();
    error EmptyArray();
    error IndexOutofBounds();
    error WrongCredId();
    error ShareLockPeriodNotPassed(uint256 currentBlock, uint256 unlockBlock);
    error PriceExceedsLimit();
    error PriceBelowLimit();

    /*//////////////////////////////////////////////////////////////
                                 EVENTS
    //////////////////////////////////////////////////////////////*/
    event PhiRewardsAddressSet(address phiRewardsAddress);

    /// @notice Emitted when the protocol signer address is set.
    event PhiSignerAddressSet(address phiSignerAddress);

    event Royalty(address indexed creator, uint256 indexed credId, uint256 Amount);
    /// @notice Emitted when a trade occurs.
    /// @param curator The address of the curator.
    /// @param credId The ID of the cred.
    /// @param isBuy Whether the trade is a buy (true) or sell (false).
    /// @param amount The amount of shares traded.
    /// @param ethAmount The amount of ETH involved in the trade.
    /// @param protocolEthAmount The amount of ETH paid as protocol fee.
    /// @param supply The new supply of the cred after the trade.
    event Trade(
        address indexed curator,
        uint256 indexed credId,
        bool isBuy,
        uint256 amount,
        uint256 ethAmount,
        uint256 protocolEthAmount,
        uint256 supply
    );

    /// @notice Emitted when a new cred is created.
    /// @param creator The address of the cred creator.
    /// @param credId The ID of the new cred.
    /// @param credURL The URL of the cred data.
    /// @param credType The type of the cred.
    /// @param verificationType The type of verification
    event CredCreated(
        address indexed creator, uint256 credId, string credURL, string credType, string verificationType
    );

    /// @notice Emitted when the URL of a cred is updated.
    /// @param creator The creator of the cred.
    /// @param credId The ID of the cred.
    /// @param credURL The new URL of the cred data.
    event CredUpdated(
        address indexed creator, uint256 credId, string credURL, uint16 buyShareRoyalty, uint16 sellShareRoyalty
    );

    /// @notice Emitted when an address is added to the whitelist.
    /// @param sender The address that added the new address to the whitelist.
    /// @param whitelistedAddress The address that was added to the whitelist.
    event AddedToWhitelist(address indexed sender, address indexed whitelistedAddress);

    /// @notice Emitted when an address is removed from the whitelist.
    /// @param sender The address that removed the address from the whitelist.
    /// @param unwhitelistedAddress The address that was removed from the whitelist.
    event RemovedFromWhitelist(address indexed sender, address indexed unwhitelistedAddress);

    /// @notice Emitted when the protocol fee percentage is changed.
    /// @param changer The address that changed the protocol fee percentage.
    /// @param newFee The new protocol fee percentage.
    event ProtocolFeePercentChanged(address changer, uint256 newFee);

    /// @notice Emitted when the protocol fee destination is changed.
    /// @param changer The address that changed the protocol fee destination.
    /// @param newDestination The new protocol fee destination.
    event ProtocolFeeDestinationChanged(address changer, address newDestination);

    /// @notice Emitted when a Merkle tree is set up for a cred.
    /// @param changer The address that set up the Merkle tree.
    /// @param credId The ID of the cred.
    /// @param root The root of the Merkle tree.
    event MerkleTreeSetUp(address changer, uint256 credId, bytes32 root);

    /// @notice Emitted when a cred is closed.
    /// @param credId The ID of the cred.
    event CredClosed(uint256 indexed credId);

    /// @notice Emitted when a cred is cleared.
    /// @param credId The ID of the cred.
    event CredCleared(uint256 indexed credId);

    /*//////////////////////////////////////////////////////////////
                                 STRUCTS
    //////////////////////////////////////////////////////////////*/
    /// @dev Represents a cred.
    struct PhiCred {
        address creator;
        uint256 currentSupply;
        string credURL; // description in arweave
        string credType;
        string verificationType;
        address bondingCurve;
        uint16 buyShareRoyalty;
        uint16 sellShareRoyalty;
        uint40 createdAt;
        uint40 updatedAt;
        uint256 latestActiveTimestamp;
    }

    /// @dev Represents a user's curation of a cred.
    struct CuratorData {
        address curator;
        uint256 shareAmount;
    }

    /*//////////////////////////////////////////////////////////////
                            EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    /// @notice buy a cred.
    /// @param credId The ID of the cred.
    /// @param amount The amount to buy.
    function buyShareCred(uint256 credId, uint256 amount, uint256 maxPrice) external payable;

    /// @notice buy a cred on behalf of another user.
    /// @param credId The ID of the cred.
    /// @param amount The amount to buy.
    /// @param curator The address of the user.
    function buyShareCredFor(uint256 credId, uint256 amount, address curator, uint256 maxPrice) external payable;

    /// @notice Sell a cred.
    /// @param credId The ID of the cred.
    /// @param amount The amount to sell.
    function sellShareCred(uint256 credId, uint256 amount, uint256 minPrice) external;

    // Read functions
    /// @notice Gets the creator of a cred.
    /// @param credId The ID of the cred.
    /// @return The address of the cred creator.
    function getCredCreator(uint256 credId) external view returns (address);

    /// @notice Gets information about a cred.
    /// @param credId The ID of the cred.
    /// @return The cred information.
    function credInfo(uint256 credId) external view returns (PhiCred memory);

    /// @param credId The ID of the cred.
    /// @param curator The address to check.
    /// @return The number of share the address has for the cred.
    function getShareNumber(uint256 credId, address curator) external view returns (uint256);

    /// @param credId The ID of the cred.
    /// @param start The starting index of the range.
    /// @param stop The ending index of the range.
    /// @return The addresses that have the cred.
    function getCuratorAddresses(
        uint256 credId,
        uint256 start,
        uint256 stop
    )
        external
        view
        returns (address[] memory);

    /// @notice Gets the buy price of a cred for a given amount.
    /// @param credId The ID of the cred.
    /// @param amount The amount to buy.
    /// @return The buy price.
    function getCredBuyPrice(uint256 credId, uint256 amount) external view returns (uint256);

    /// @notice Gets the buy price of a cred with fee for a given amount.
    /// @param credId The ID of the cred.
    /// @param amount The amount to buy.
    /// @return The buy price with fee.
    function getCredBuyPriceWithFee(uint256 credId, uint256 amount) external view returns (uint256);

    /// @notice Gets the sell price of a cred for a given amount.
    /// @param credId The ID of the cred.
    /// @param amount The amount to sell.
    /// @return The sell price.
    function getCredSellPrice(uint256 credId, uint256 amount) external view returns (uint256);

    /// @notice Gets the sell price of a cred with fee for a given amount.
    /// @param credId The ID of the cred.
    /// @param amount The amount to sell.
    /// @return The sell price with fee.
    function getCredSellPriceWithFee(uint256 credId, uint256 amount) external view returns (uint256);

    /// @notice Gets the total buy price for a batch of creds and amounts.
    /// @param credIds The IDs of the creds.
    /// @param amounts The amounts corresponding to each cred.
    /// @return The total buy price for the batch.
    function getBatchBuyPrice(uint256[] calldata credIds, uint256[] calldata amounts) external view returns (uint256);

    /// @notice Gets the total sell price for a batch of creds and amounts.
    /// @param credIds The IDs of the creds.
    /// @param amounts The amounts corresponding to each cred.
    /// @return The total sell price for the batch.
    function getBatchSellPrice(
        uint256[] calldata credIds,
        uint256[] calldata amounts
    )
        external
        view
        returns (uint256);

    /// @notice Checks if a cred exists.
    /// @param credId The ID of the cred.
    /// @return Whether the cred exists.
    function isExist(uint256 credId) external view returns (bool);

    /// @param credId The ID of the cred.
    /// @param curator_ The address to check.
    /// @return Whether the address has the cred.
    function isShareHolder(uint256 credId, address curator_) external view returns (bool);

    /// @notice Gets the protocol fee percentage.
    /// @return The protocol fee percentage.
    function protocolFeePercent() external view returns (uint256);

    /// @notice Gets the protocol fee destination.
    /// @return The protocol fee destination.
    function protocolFeeDestination() external view returns (address);

    /// @notice Gets the creator royalty percentages.
    /// @param credId The ID of the cred.
    /// @return The buy and sell royalty.
    function getCreatorRoyalty(uint256 credId) external view returns (uint16, uint16);
}
