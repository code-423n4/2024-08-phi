// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.25;

import { console2 } from "forge-std/console2.sol";
import { PRBTest } from "@prb/test/src/PRBTest.sol";
import { Test } from "forge-std/Test.sol";
import { TestUtils } from "./TestUtils.sol";
import { CuratorRewardsDistributor } from "../../src/reward/CuratorRewardsDistributor.sol";
import { PhiFactory } from "../../src/PhiFactory.sol";
import { PhiRewards } from "../../src/reward/PhiRewards.sol";
import { BondingCurve } from "../../src/curve/BondingCurve.sol";
import { ContributeRewards } from "../../src/lib/ContributeRewards.sol";
import { Cred } from "../../src/Cred.sol";
import { IPhiNFT1155 } from "../../src/interfaces/IPhiNFT1155.sol";
import { PhiNFT1155 } from "../../src/art/PhiNFT1155.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { LibClone } from "solady/utils/LibClone.sol";

contract MockERC20 is IERC20 {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;

    function mint(address account, uint256 amount) external {
        _balances[account] += amount;
        _totalSupply += amount;
    }

    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) external returns (bool) {
        _balances[msg.sender] -= amount;
        _balances[recipient] += amount;
        return true;
    }

    function allowance(address owner, address spender) external view returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) external returns (bool) {
        _allowances[msg.sender][spender] = amount;
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool) {
        _allowances[sender][msg.sender] -= amount;
        _balances[sender] -= amount;
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }
}

contract Settings is Test, TestUtils {
    uint256 claimSignerPrivateKey;
    uint256 MAX_SUPPLY;

    uint256 END_TIME;
    uint256 START_TIME;

    uint256 NFT_ART_CREATE_FEE;
    uint256 MINT_FEE;
    uint256 PROTOCOL_FEE;
    uint256 CREDENTIAL_CREATE_FEE;

    uint256 internal constant ARTIST_REWARD = 0.0001 ether;
    uint256 internal constant REFERRAL_REWARD = 0.00005 ether;
    uint256 internal constant VERIFY_REWARD = 0.00005 ether;
    uint256 internal constant CURATE_REWARD = 0.00005 ether;

    address protocolFeeDestination;

    address artCreator;
    address participant;
    address referrer;
    address verifier;
    address anyone;
    address owner;
    address receiver;
    address user1;
    address user2;

    address scoreSignerAddress;

    uint256 internal constant ETH_SUPPLY = 120_200_000 ether;

    PhiFactory phiFactory;
    PhiRewards phiRewards;

    BondingCurve bondingCurve;
    Cred cred;
    ContributeRewards contributeRewards;
    CuratorRewardsDistributor curatorRewardsDistributor;
    MockERC20 mockToken;

    using LibClone for address;

    function setUp() public virtual {
        MAX_SUPPLY = 300;

        START_TIME = 1_000_000;
        END_TIME = 1_000_000_000;

        NFT_ART_CREATE_FEE = 0.0002 ether;
        MINT_FEE = 0.01 ether;
        PROTOCOL_FEE = 0.0002 ether;

        protocolFeeDestination = makeAddr("protocolFeeDestination");

        artCreator = makeAddr(("artCreator"));
        participant = makeAddr(("participant"));
        referrer = makeAddr(("referrer"));
        verifier = makeAddr(("verifier"));
        anyone = makeAddr(("anyone"));
        owner = makeAddr(("owner"));
        receiver = makeAddr(("receiver"));
        user1 = makeAddr(("user1"));
        user2 = makeAddr(("user2"));

        vm.deal(owner, 1 ether);
        vm.deal(participant, 1 ether);
        vm.deal(artCreator, 1 ether);
        vm.deal(anyone, 1 ether);
        vm.deal(referrer, 1 ether);
        vm.deal(verifier, 1 ether);

        vm.prank(owner);
        address payable phiFactoryAddress =
            payable(address(new PhiFactory()).cloneDeterministic(keccak256(abi.encodePacked(msg.sender, "SALT"))));
        phiFactory = PhiFactory(phiFactoryAddress);

        // claimSignerPrivateKey = uint256(vm.envUint("TEST_CLAIM_SIGNER_PRIVATE_KEY"));
        claimSignerPrivateKey = 0x4af1bceebf7f3634ec3cff8a2c38e51178d5d4ce585c52d6043e5e2cc3418bb0;
        phiRewards = PhiRewards(new PhiRewards(owner));

        phiFactory.initialize(
            vm.addr(claimSignerPrivateKey),
            protocolFeeDestination,
            payable(address(new PhiNFT1155())),
            payable(address(phiRewards)),
            owner,
            PROTOCOL_FEE,
            NFT_ART_CREATE_FEE
        );

        assertEq(phiFactory.artCreateFee(), NFT_ART_CREATE_FEE, "create fee activetad");

        bondingCurve = new BondingCurve(owner);

        address payable credAddress =
            payable(address(new Cred()).cloneDeterministic(keccak256(abi.encodePacked(msg.sender, "SALT"))));
        cred = Cred(credAddress);
        cred.initialize(
            vm.addr(claimSignerPrivateKey),
            owner,
            protocolFeeDestination,
            500,
            address(bondingCurve),
            address(phiRewards)
        );

        // Deploy CuratorRewardsDistributor
        curatorRewardsDistributor = new CuratorRewardsDistributor(address(phiRewards), address(cred));
        vm.prank(owner);
        phiRewards.updateCuratorRewardsDistributor(address(curatorRewardsDistributor));

        contributeRewards = new ContributeRewards(address(cred), address(phiFactory));
        mockToken = new MockERC20();
        uint256 INITIAL_BALANCE = 1_000_000 ether;
        // Mint some tokens for testing
        mockToken.mint(owner, INITIAL_BALANCE);
        mockToken.mint(user1, INITIAL_BALANCE);
        mockToken.mint(user2, INITIAL_BALANCE);

        vm.startPrank(owner);
        bondingCurve.setCredContract(address(cred));
        vm.stopPrank();
    }
}
