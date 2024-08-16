// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import { Ownable2Step } from "@openzeppelin/contracts/access/Ownable2Step.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { IBondingCurve } from "../interfaces/IBondingCurve.sol";
import { ICred } from "../interfaces/ICred.sol";

/// JUST FOR TESTING CONTRACTS
/// NO NEED TO CHECK THIS CONTRACT
contract FixedPriceBondingCurve is Ownable2Step, IBondingCurve {
    ICred public credContract;
    uint256 public constant MAX_SUPPLY = 999;
    uint256 public constant FIXED_PRICE = 0.00001 ether;
    uint256 private immutable RATIO_BASE = 10_000;

    constructor(address owner_) Ownable(owner_) { }

    function setCredContract(address credContract_) external onlyOwner {
        if (credContract_ == address(0)) revert InvalidAddressZero();
        credContract = ICred(credContract_);
    }

    function getCredContract() external view returns (address) {
        return address(credContract);
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
        if (supply_ + amount_ > MAX_SUPPLY) revert InvalidSupply();
        price = FIXED_PRICE * amount_;
        protocolFee = _getProtocolFee(price);
        (uint16 buyShareRoyalty, uint16 sellShareRoyalty) = credContract.getCreatorRoyalty(credId_);
        uint16 royaltyRate = isSign_ ? buyShareRoyalty : sellShareRoyalty;
        creatorFee = (price * royaltyRate) / RATIO_BASE;
    }

    function getPrice(uint256 supply_, uint256 amount_) public pure returns (uint256) {
        if (supply_ + amount_ > MAX_SUPPLY) revert InvalidSupply();
        return FIXED_PRICE * amount_;
    }

    function getBuyPriceAfterFee(uint256 credId_, uint256 supply_, uint256 amount_) public view returns (uint256) {
        (uint256 price, uint256 protocolFee, uint256 creatorFee) = getPriceData(credId_, supply_, amount_, true);
        return price + protocolFee + creatorFee;
    }

    function getSellPriceAfterFee(uint256 credId_, uint256 supply_, uint256 amount_) public view returns (uint256) {
        (uint256 price, uint256 protocolFee, uint256 creatorFee) = getPriceData(credId_, supply_, amount_, false);
        return price - protocolFee - creatorFee;
    }

    function _getProtocolFee(uint256 price_) internal view returns (uint256) {
        return price_ * credContract.protocolFeePercent() / RATIO_BASE;
    }
}
