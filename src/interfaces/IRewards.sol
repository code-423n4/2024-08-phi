// SPDX-License-Identifier: MIT
pragma solidity 0.8.25;

/// @title IRewards
/// @notice The interface for deposits and withdrawals
interface IRewards {
    /*//////////////////////////////////////////////////////////////
                                 ERRORS
    //////////////////////////////////////////////////////////////*/
    /// @notice Thrown when trying to send to the zero address
    error InvalidAddressZero();

    /// @notice Thrown when function argument array lengths mismatch
    error ArrayLengthMismatch();

    /// @notice Thrown when an invalid deposit is made
    error InvalidDeposit();

    /// @notice Thrown when an invalid signature is provided for a deposit
    error InvalidSignature();

    /// @notice Thrown when an invalid withdrawal is attempted
    error InvalidWithdraw();

    /// @notice Thrown when the signature for a withdrawal has expired
    error SignatureDeadlineExpired();

    /// @notice Thrown when a low-level ETH transfer fails
    error TransferFailed();

    error InvalidAmount();

    error DeadlineExpired();

    /*//////////////////////////////////////////////////////////////
                                 EVENTS
    //////////////////////////////////////////////////////////////*/
    /// @notice Emitted when a deposit is made
    /// @param from The address making the deposit
    /// @param to The address receiving the deposit
    /// @param reason Optional bytes4 reason for indexing
    /// @param amount Amount of the deposit
    /// @param comment Optional user comment
    event Deposit(address indexed from, address indexed to, bytes4 indexed reason, uint256 amount, string comment);

    /// @notice Emitted when a withdrawal is made
    /// @param from The address making the withdrawal
    /// @param to The address receiving the withdrawal
    /// @param amount Amount of the withdrawal
    event Withdraw(address indexed from, address indexed to, uint256 amount);

    /*//////////////////////////////////////////////////////////////
                             EXTERNAL FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    /// @notice Deposits ETH for a recipient, with an optional comment
    /// @param to Address to deposit to
    /// @param reason System reason for deposit (used for indexing)
    /// @param comment Optional comment as reason for deposit
    function deposit(address to, bytes4 reason, string calldata comment) external payable;

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
        payable;

    /// @notice Withdraws protocol rewards
    /// @param to Address to withdraw to
    /// @param amount Amount to withdraw
    function withdraw(address to, uint256 amount) external;

    /// @notice Withdraws rewards on behalf of an address
    /// @param to Address to withdraw for
    /// @param amount Amount to withdraw (0 for total balance)
    function withdrawFor(address to, uint256 amount) external;

    /// @notice Executes a withdrawal of protocol rewards via signature
    /// @param from Address to withdraw from
    /// @param to Address to withdraw to
    /// @param amount Amount to withdraw
    /// @param deadline Deadline for the signature to be valid
    /// @param sig Signature for the withdrawal
    function withdrawWithSig(address from, address to, uint256 amount, uint256 deadline, bytes calldata sig) external;

    /*//////////////////////////////////////////////////////////////
                             VIEW FUNCTIONS
    //////////////////////////////////////////////////////////////*/
    /// @notice Returns the total amount of ETH held in the contract
    function totalSupply() external view returns (uint256);
}
