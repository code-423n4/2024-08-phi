// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

import { EIP712 } from "solady/utils/EIP712.sol";
import { IRewards } from "../interfaces/IRewards.sol";
import { SignatureCheckerLib } from "solady/utils/SignatureCheckerLib.sol";
import { SafeTransferLib } from "solady/utils/SafeTransferLib.sol";

/// @title RewardControl
/// @notice Abstract contract for managing rewards
abstract contract RewardControl is IRewards, EIP712 {
    /*//////////////////////////////////////////////////////////////
                                 USING
    //////////////////////////////////////////////////////////////*/
    using SafeTransferLib for address;

    /*//////////////////////////////////////////////////////////////
                                STORAGE
    //////////////////////////////////////////////////////////////*/
    uint256 private constant FULL_BALANCE = 0;

    /// @dev The EIP-712 typehash for gasless withdraws
    bytes32 public constant WITHDRAW_TYPEHASH =
        keccak256("Withdraw(address from,address to,uint256 amount,uint256 nonce,uint256 deadline)");

    /// @dev An account's nonce for gasless withdraws
    mapping(address account => uint256 nonce) public nonces;

    /// @dev An account's balance
    mapping(address account => uint256 balance) public balanceOf;

    /*//////////////////////////////////////////////////////////////
                             UPDATE FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    /// @notice Deposits ETH for a recipient, with an optional comment
    /// @param to Address to deposit to
    /// @param reason System reason for deposit (used for indexing)
    /// @param comment Optional comment as reason for deposit
    function deposit(address to, bytes4 reason, string calldata comment) external payable {
        if (to == address(0)) revert InvalidAddressZero();

        unchecked {
            balanceOf[to] += msg.value;
        }

        emit Deposit(msg.sender, to, reason, msg.value, comment);
    }

    /// @notice Deposits ETH for multiple recipients, with an optional comment
    /// @param recipients Recipients to send the amounts to, array aligns with amounts
    /// @param amounts Amounts to send to each recipient, array aligns with recipients
    /// @param reasons Optional bytes4 hashes for indexing
    /// @param comment Optional comment to include with deposit
    function depositBatch(
        address[] calldata recipients,
        uint256[] calldata amounts,
        bytes4[] calldata reasons,
        string calldata comment
    )
        external
        payable
    {
        uint256 numRecipients = recipients.length;

        if (numRecipients != amounts.length || numRecipients != reasons.length) {
            revert ArrayLengthMismatch();
        }

        uint256 expectedTotalValue;
        for (uint256 i = 0; i < numRecipients; i++) {
            expectedTotalValue += amounts[i];
        }

        if (msg.value != expectedTotalValue) {
            revert InvalidDeposit();
        }

        for (uint256 i = 0; i < numRecipients; i++) {
            address recipient = recipients[i];
            uint256 amount = amounts[i];

            if (recipient == address(0)) {
                revert InvalidAddressZero();
            }

            balanceOf[recipient] += amount;

            emit Deposit(msg.sender, recipient, reasons[i], amount, comment);
        }
    }

    function withdraw(address to, uint256 amount) external {
        _withdraw(msg.sender, to, amount);
    }

    function withdrawFor(address from, uint256 amount) external {
        _withdraw(from, from, amount);
    }

    function withdrawWithSig(address from, address to, uint256 amount, uint256 deadline, bytes calldata sig) external {
        if (block.timestamp > deadline) revert DeadlineExpired();
        if (!_verifySignature(from, to, amount, nonces[from], deadline, sig)) revert InvalidSignature();

        unchecked {
            ++nonces[from];
        }

        _withdraw(from, to, amount);
    }

    /*//////////////////////////////////////////////////////////////
                              VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    /// @notice Returns the total amount of ETH held in the contract
    function totalSupply() external view returns (uint256) {
        return address(this).balance;
    }

    /*//////////////////////////////////////////////////////////////
                            INTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    function _withdraw(address from, address to, uint256 amount) internal {
        if (to == address(0)) revert InvalidAddressZero();

        uint256 balance = balanceOf[from];
        if (amount == FULL_BALANCE) {
            amount = balance;
        }

        if (amount > balance) revert InvalidAmount();

        unchecked {
            balanceOf[from] = balance - amount;
        }

        emit Withdraw(from, to, amount);

        to.safeTransferETH(amount);
    }

    function _domainNameAndVersion() internal pure override returns (string memory name, string memory version) {
        return ("PHI Rewards", "1");
    }

    /// @dev Verifies EIP-712 `Mint` signature
    function _verifySignature(
        address from,
        address to,
        uint256 amount,
        uint256 nonce,
        uint256 deadline,
        bytes calldata sig
    )
        internal
        view
        returns (bool)
    {
        bytes32 structHash = keccak256(abi.encode(WITHDRAW_TYPEHASH, from, to, amount, nonce, deadline));
        bytes32 digest = _hashTypedData(structHash);
        return SignatureCheckerLib.isValidSignatureNowCalldata(from, digest, sig);
    }

    /// @dev EIP-712 helper
    function hashTypedData(bytes32 structHash) public view returns (bytes32) {
        return _hashTypedData(structHash);
    }
}
