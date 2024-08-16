// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import { Logo } from "../lib/Logo.sol";
import { MerkleProof } from "../lib/MerkleProof.sol";
import { Ownable2Step } from "@openzeppelin/contracts/access/Ownable2Step.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { BitMaps } from "@openzeppelin/contracts/utils/structs/BitMaps.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import { SafeTransferLib } from "solady/utils/SafeTransferLib.sol";
import { IContributeRewards } from "../interfaces/IContributeRewards.sol";
import { ICred } from "../interfaces/ICred.sol";
import { IPhiFactory } from "../interfaces/IPhiFactory.sol";

import { console2 } from "forge-std/console2.sol";

contract ContributeRewards is Logo, Ownable2Step, IContributeRewards {
    /*//////////////////////////////////////////////////////////////
                                 USING
    //////////////////////////////////////////////////////////////*/
    using BitMaps for BitMaps.BitMap;
    using SafeTransferLib for address;
    using SafeERC20 for IERC20;

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/
    ICred public credContract;
    IPhiFactory public factoryContract;

    uint256 private locked;

    mapping(uint256 credId => mapping(uint256 id => RewardInfo)) public rewardInfos;
    mapping(uint256 credId => uint256 id) public rewardCount;
    mapping(uint256 credId => mapping(uint256 id => BitMaps.BitMap)) private claimed;

    /*//////////////////////////////////////////////////////////////
                              CONSTRUCTOR
    //////////////////////////////////////////////////////////////*/
    constructor(address _credContract, address _factoryContract) Ownable(msg.sender) {
        credContract = ICred(_credContract);
        factoryContract = IPhiFactory(_factoryContract);
    }

    /*//////////////////////////////////////////////////////////////
                               MODIFIERS
    //////////////////////////////////////////////////////////////*/
    modifier nonReentrant() virtual {
        if (locked != 1) revert Reentrancy();
        locked = 2;
        _;
        locked = 1;
    }

    /*//////////////////////////////////////////////////////////////
                             SETTER FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    function setContracts(address _credContract, address _factoryContract) external onlyOwner {
        credContract = ICred(_credContract);
        factoryContract = IPhiFactory(_factoryContract);
    }

    /*//////////////////////////////////////////////////////////////
                             EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    function setRewardInfo(
        uint256 credId,
        uint256 claimPeriodEnds,
        bytes32 merkleRoot,
        address rewardToken,
        uint256 totalRewardAmount,
        bool isCheckMinted
    )
        external
    {
        if (!credContract.isExist(credId)) revert CredDoesNotExist(credId);

        uint256 rewardId = rewardCount[credId];
        RewardInfo storage info = rewardInfos[credId][rewardId];
        info.claimPeriodEnds = claimPeriodEnds;
        info.merkleRoot = merkleRoot;
        info.rewardToken = IERC20(rewardToken);
        info.totalRewardAmount = totalRewardAmount;
        info.rewardSetter = msg.sender;
        info.isCheckMinted = isCheckMinted;
        info.isOpen = true;

        rewardCount[credId]++;
        IERC20(rewardToken).safeTransferFrom(msg.sender, address(this), totalRewardAmount);

        emit RewardInfoSet(msg.sender, credId, rewardId, claimPeriodEnds, merkleRoot, rewardToken, totalRewardAmount);
    }

    function claimReward(uint256 credId, uint256 rewardId, uint256 amount, bytes32[] calldata merkleProof) external {
        RewardInfo storage info = rewardInfos[credId][rewardId];
        if (!info.isOpen) revert RewardClosed();
        if (block.timestamp > info.claimPeriodEnds) revert ClaimPeriodEnded();

        if (info.isCheckMinted) {
            if (!factoryContract.isCredMinted(block.chainid, credId, msg.sender)) revert NotMinted();
        }

        bytes32 leaf = keccak256(abi.encodePacked(msg.sender, amount));
        (bool valid, uint256 index) = MerkleProof.verify(merkleProof, info.merkleRoot, leaf);
        if (!valid) revert InvalidProof();
        if (isClaimed(credId, rewardId, index)) revert TokensAlreadyClaimed(index);

        claimed[credId][rewardId].set(index);
        info.claimedAmount += amount;
        if (info.claimedAmount > info.totalRewardAmount) revert ExceedsTotalRewardAmount();

        emit Claim(credId, rewardId, msg.sender, amount);

        IERC20(info.rewardToken).safeTransfer(msg.sender, amount);
    }

    function closeAndSweep(uint256 credId, uint256 rewardId) external {
        RewardInfo storage info = rewardInfos[credId][rewardId];
        if (msg.sender != info.rewardSetter) revert Unauthorized(msg.sender);
        if (!info.isOpen) revert RewardAlreadyClosed();

        info.isOpen = false;

        uint256 remainingAmount = info.totalRewardAmount - info.claimedAmount;
        if (remainingAmount > 0) {
            IERC20(info.rewardToken).safeTransfer(msg.sender, remainingAmount);
        }

        emit RewardClosedAndSwept(credId, rewardId, msg.sender, remainingAmount);
    }

    /*//////////////////////////////////////////////////////////////
                             EXTERNAL VIEW
    //////////////////////////////////////////////////////////////*/
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
        )
    {
        RewardInfo memory info = rewardInfos[credId][rewardId];
        return (
            info.claimPeriodEnds,
            info.merkleRoot,
            address(info.rewardToken),
            info.totalRewardAmount,
            info.claimedAmount,
            info.rewardSetter,
            info.isOpen
        );
    }

    function isClaimed(uint256 credId, uint256 rewardId, uint256 index) public view returns (bool) {
        return claimed[credId][rewardId].get(index);
    }
}
