// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import { IRewards } from "./IRewards.sol";

interface IPhiRewards is IRewards {
    /*//////////////////////////////////////////////////////////////
                                EVENTS
    //////////////////////////////////////////////////////////////*/
    event ArtistRewardUpdated(uint256 artistReward);
    event ReferralRewardUpdated(uint256 referralReward);
    event VerifierRewardUpdated(uint256 verifierReward);
    event CurateRewardUpdated(uint256 curateReward);
    event CuratorRewardsDistributorUpdated(address curatorRewardsDistributor);
    event RewardsDeposit(
        bytes credData,
        address minter,
        address indexed receiver,
        address indexed referral,
        address indexed verifier,
        bytes rewardsData
    );

    /*//////////////////////////////////////////////////////////////
                            EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    /// @notice Updates the curator rewards distributor address
    /// @param curatorRewardsDistributor_ The new curator rewards distributor address
    function updateCuratorRewardsDistributor(address curatorRewardsDistributor_) external;

    /// @notice Handles rewards and gets the value sent
    /// @param artId_ The art ID
    /// @param credId_ The credential ID
    /// @param quantity_ The quantity
    /// @param mintFee_ The minting fee
    /// @param addressesData_ The encoded addresses data (minter, receiver, referral, verifier)
    /// @param chainSync_ Whether to sync with the chain or not
    function handleRewardsAndGetValueSent(
        uint256 artId_,
        uint256 credId_,
        uint256 quantity_,
        uint256 mintFee_,
        bytes calldata addressesData_,
        bool chainSync_
    )
        external
        payable;

    /// @notice Computes the minting reward
    /// @param quantity_ The quantity
    /// @param mintFee_ The minting fee
    /// @return The computed minting reward
    function computeMintReward(uint256 quantity_, uint256 mintFee_) external view returns (uint256);
}
