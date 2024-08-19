// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

interface ICuratorRewardsDistributor {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/
    error InvalidAddressZero();
    error NoBalanceToDistribute();
    error NoSharesToDistribute();
    error InvalidTokenAmounts(uint256 gotAmounts);
    error InvalidValue(uint256 gotValue, uint256 expectedValue);
    error UnauthorizedCaller(address caller);
    error Reentrancy();
    error InvalidRoyalty(uint256 royalty);
    error InvalidCredId();

    /*//////////////////////////////////////////////////////////////
                                 EVENTS
    //////////////////////////////////////////////////////////////*/
    event Deposit(uint256 indexed credId, uint256 amount);
    event RewardsDistributed(
        uint256 indexed credId, address indexed sender, uint256 royaltyfee, uint256 distributeAmount, uint256 total
    );
    event RewardsSweeped(uint256 indexed credId, address indexed sender, uint256 total);
    event PhiRewardsContractUpdated(address newPhiRewardsContract);
    event RoyaltyUpdated(uint256 newRoyalty);

    /*//////////////////////////////////////////////////////////////
                            EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    function balanceOf(uint256 credId) external view returns (uint256);
    /// @notice Deposits an amount of ETH into the contract.
    /// @param credId The ID of the cred.
    /// @param amount The amount of ETH to deposit.
    function deposit(uint256 credId, uint256 amount) external payable;
    /// @notice Distributes the rewards to the addresses.
    /// @param credId The ID of the cred.
    function distribute(uint256 credId) external;
}
