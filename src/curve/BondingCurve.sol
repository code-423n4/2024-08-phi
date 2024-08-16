// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import { Ownable2Step } from "@openzeppelin/contracts/access/Ownable2Step.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { IBondingCurve } from "../interfaces/IBondingCurve.sol";
import { ICred } from "../interfaces/ICred.sol";

import { console2 } from "forge-std/console2.sol";
/// @title bondingCurve

contract BondingCurve is Ownable2Step, IBondingCurve {
    /*//////////////////////////////////////////////////////////////
                                 STORAGE
    //////////////////////////////////////////////////////////////*/
    ICred public credContract;

    uint256 private constant TOTAL_SUPPLY_FACTOR = 1000 ether;
    uint256 private constant CURVE_FACTOR = 10;
    uint256 private constant INITIAL_PRICE_FACTOR = 9;
    uint256 private immutable RATIO_BASE = 10_000;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/
    /// @notice Initializes the contract with the given owner address.
    constructor(address owner_) Ownable(owner_) { }

    /*//////////////////////////////////////////////////////////////
                                 SETTERS
    //////////////////////////////////////////////////////////////*/
    /// @notice Sets the address of the cred contract.
    /// @param credContract_ The address of the cred contract.
    function setCredContract(address credContract_) external onlyOwner {
        credContract = ICred(credContract_);
    }

    /*//////////////////////////////////////////////////////////////
                             EXTERNAL VIEW
    //////////////////////////////////////////////////////////////*/
    /// @notice Gets the address of the cred contract.
    /// @return The address of the cred contract.
    function getCredContract() external view returns (address) {
        return address(credContract);
    }

    function getPrice(uint256 supply_, uint256 amount_) public pure returns (uint256) {
        return _curve((supply_ + amount_) * 1 ether) - _curve(supply_ * 1 ether);
    }

    function getPriceData(
        uint256 credId_,
        uint256 supply_,
        uint256 amount_,
        bool isSign_
    )
        public
        view
        returns (uint256 price, uint256 protocolFee, uint256 creatorFee)
    {
        (uint16 buyShareRoyalty, uint16 sellShareRoyalty) = credContract.getCreatorRoyalty(credId_);

        price = isSign_ ? getPrice(supply_, amount_) : getPrice(supply_ - amount_, amount_);

        protocolFee = _getProtocolFee(price);
        if (supply_ == 0) {
            creatorFee = 0;
            return (price, protocolFee, creatorFee);
        }
        uint16 royaltyRate = isSign_ ? buyShareRoyalty : sellShareRoyalty;
        creatorFee = (price * royaltyRate) / RATIO_BASE;
    }

    /// @notice Calculates the buy price for a given supply and amount.
    /// @param supply_ The current supply.
    /// @param amount_ The amount to calculate the buy price for.
    /// @return The calculated buy price.
    function getBuyPrice(uint256 supply_, uint256 amount_) public pure returns (uint256) {
        return getPrice(supply_, amount_);
    }

    /// @notice Calculates the buy price after fees for a given supply and amount.
    /// @param supply_ The current supply.
    /// @param amount_ The amount to calculate the buy price for.
    /// @return The calculated buy price after fees.
    function getBuyPriceAfterFee(uint256 credId_, uint256 supply_, uint256 amount_) public view returns (uint256) {
        uint256 price = getBuyPrice(supply_, amount_);
        uint256 protocolFee = _getProtocolFee(price);
        uint256 creatorFee = _getCreatorFee(credId_, supply_, price, true);

        return price + protocolFee + creatorFee;
    }

    /// @notice Calculates the sell price for a given supply and amount.
    /// @param supply_ The current supply.
    /// @param amount_ The amount to calculate the sell price for.
    /// @return The calculated sell price.
    function getSellPrice(uint256 supply_, uint256 amount_) public pure returns (uint256) {
        return getPrice(supply_ - amount_, amount_);
    }

    /// @notice Calculates the sell price after fees for a given supply and amount.
    /// @param supply_ The current supply.
    /// @param amount_ The amount to calculate the sell price for.
    /// @return The calculated sell price after fees.
    function getSellPriceAfterFee(uint256 credId_, uint256 supply_, uint256 amount_) public view returns (uint256) {
        uint256 price = getSellPrice(supply_, amount_);
        uint256 protocolFee = _getProtocolFee(price);
        uint256 creatorFee = _getCreatorFee(credId_, supply_, price, false);
        return price - protocolFee - creatorFee;
    }

    /*//////////////////////////////////////////////////////////////
                                 INTERNAL
    //////////////////////////////////////////////////////////////*/
    /// @dev Returns the curve of `targetAmount`
    function _curve(uint256 targetAmount_) private pure returns (uint256) {
        return (TOTAL_SUPPLY_FACTOR * CURVE_FACTOR * 1 ether) / (TOTAL_SUPPLY_FACTOR - targetAmount_)
            - CURVE_FACTOR * 1 ether - INITIAL_PRICE_FACTOR * targetAmount_ / 1000;
    }

    /// @dev Returns the protocol fee.
    function _getProtocolFee(uint256 price_) internal view returns (uint256) {
        return price_ * credContract.protocolFeePercent() / RATIO_BASE;
    }

    /// @dev Returns the creator fee.
    function _getCreatorFee(
        uint256 credId_,
        uint256 supply_,
        uint256 price_,
        bool isSign_
    )
        internal
        view
        returns (uint256 creatorFee)
    {
        if (!credContract.isExist(credId_)) {
            return 0;
        }
        if (supply_ == 0) {
            creatorFee = 0;
        }

        (uint16 buyShareRoyalty, uint16 sellShareRoyalty) = credContract.getCreatorRoyalty(credId_);

        uint16 royaltyRate = isSign_ ? buyShareRoyalty : sellShareRoyalty;
        creatorFee = (price_ * royaltyRate) / RATIO_BASE;
    }
}
