// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IContributeRewards {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/
    error InvalidProof();
    error TokensAlreadyClaimed(uint256 index);
    error CredDoesNotExist(uint256 credId);
    error Unauthorized(address caller);
    error TransferFailed();
    error ClaimPeriodEnded();
    error ExceedsTotalRewardAmount();
    error SweepFailed();
    error RewardAlreadyClosed();
    error RewardClosed();
    error NotMinted();
    error Reentrancy();

    /*//////////////////////////////////////////////////////////////
                                 EVENTS
    //////////////////////////////////////////////////////////////*/
    event Claim(uint256 indexed credId, uint256 indexed rewardId, address indexed claimant, uint256 amount);
    event RewardInfoSet(
        address indexed setter,
        uint256 indexed credId,
        uint256 indexed rewardId,
        uint256 claimPeriodEnds,
        bytes32 merkleRoot,
        address rewardToken,
        uint256 totalRewardAmount
    );
    event RewardClosedAndSwept(
        uint256 indexed credId, uint256 indexed rewardId, address indexed sweeper, uint256 amount
    );

    /*//////////////////////////////////////////////////////////////
                                 STRUCTS
    //////////////////////////////////////////////////////////////*/
    struct RewardInfo {
        uint256 claimPeriodEnds;
        bytes32 merkleRoot;
        IERC20 rewardToken;
        uint256 totalRewardAmount;
        uint256 claimedAmount;
        address rewardSetter;
        bool isCheckMinted;
        bool isOpen;
    }

    /*//////////////////////////////////////////////////////////////
                                FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    function setRewardInfo(
        uint256 credId,
        uint256 claimPeriodEnds,
        bytes32 merkleRoot,
        address rewardToken,
        uint256 totalRewardAmount,
        bool isCheckMinted
    )
        external;

    function claimReward(uint256 credId, uint256 rewardId, uint256 amount, bytes32[] calldata merkleProof) external;

    function closeAndSweep(uint256 credId, uint256 rewardId) external;

    function getRewardInfo(
        uint256 credId,
        uint256 rewardId
    )
        external
        view
        returns (
            uint256 claimPeriodEnds,
            bytes32 merkleRoot,
            address rewardToken,
            uint256 totalRewardAmount,
            uint256 claimedAmount,
            address rewardSetter,
            bool isOpen
        );

    function isClaimed(uint256 credId, uint256 rewardId, uint256 index) external view returns (bool);
}
