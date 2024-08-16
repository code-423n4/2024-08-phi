// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

interface IBondingCurve {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/
    /// @notice Error thrown when an invalid zero address is provided.
    error InvalidAddressZero();
    error InvalidSupply();

    /*//////////////////////////////////////////////////////////////
                                 EVENTS
    //////////////////////////////////////////////////////////////*/
    // (no events)

    /*//////////////////////////////////////////////////////////////
                            EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    /// @notice Sets the address of the cred contract.
    /// @param credContract_ The address of the cred contract.
    function setCredContract(address credContract_) external;

    /// @notice Gets the address of the cred contract.
    /// @return The address of the cred contract.
    function getCredContract() external view returns (address);

    function getPriceData(
        uint256 credId_,
        uint256 supply_,
        uint256 amount_,
        bool isSign_
    )
        external
        view
        returns (uint256 price, uint256 protcolFee, uint256 creatorFee);

    /// @notice Calculates the price for a given supply and amount.
    /// @param supply_ The current supply.
    /// @param amount_ The amount to calculate the price for.
    /// @return The calculated price.
    function getPrice(uint256 supply_, uint256 amount_) external pure returns (uint256);

    /// @notice Calculates the buy price after fees for a given supply and amount.
    /// @param supply_ The current supply.
    /// @param amount_ The amount to calculate the buy price for.
    /// @return The calculated buy price after fees.
    function getBuyPriceAfterFee(uint256 credId_, uint256 supply_, uint256 amount_) external view returns (uint256);

    /// @notice Calculates the sell price after fees for a given supply and amount.
    /// @param supply_ The current supply.
    /// @param amount_ The amount to calculate the sell price for.
    /// @return The calculated sell price after fees.
    function getSellPriceAfterFee(uint256 credId_, uint256 supply_, uint256 amount_) external view returns (uint256);
}
