// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.23 <0.9.0;

import { console2 } from "forge-std/console2.sol";

import { ERC1967Proxy } from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import { LibClone } from "solady/utils/LibClone.sol";
import { Cred } from "../src/Cred.sol";
import { PhiNFT1155 } from "../src/art/PhiNFT1155.sol";
import { BondingCurve } from "../src/curve/BondingCurve.sol";
import { FixedPriceBondingCurve } from "../src/lib/FixedPriceBondingCurve.sol";
import { PhiRewards } from "../src/reward/PhiRewards.sol";
import { CuratorRewardsDistributor } from "../src/reward/CuratorRewardsDistributor.sol";
import { PhiFactory } from "../src/PhiFactory.sol";
import { BaseScript } from "./Base.s.sol";

// https://github.com/Cyfrin/foundry-upgrades-f23/blob/main/script/DeployBox.s.sol
/// @dev See the Solidity Scripting tutorial: https://book.getfoundry.sh/tutorials/solidity-scripting
contract Deploy is BaseScript {
    using LibClone for address;

    address public deployer;
    Cred public cred;
    PhiFactory public phiFactory;
    PhiNFT1155 public phiNFT1155;
    BondingCurve public bondingCurve;
    FixedPriceBondingCurve public fixedPriceBondingCurve;
    PhiRewards public phiRewards;
    CuratorRewardsDistributor public curatorRewardsDistributor;

    address public oji3 = 0x5cD18dA4C84758319C8E1c228b48725f5e4a3506;
    address public signer = 0x29C76e6aD8f28BB1004902578Fb108c507Be341b;

    function setUp() public virtual {
        string memory mnemonic = vm.envString("MNEMONIC");
        (deployer,) = deriveRememberKey(mnemonic, 0);
    }

    function run() public broadcast {
        console2.log("Chain Info: %s", block.chainid);
        phiNFT1155 = new PhiNFT1155();

        phiRewards = new PhiRewards(deployer);
        console2.log("PhiRewards deployed at address: %s", address(phiRewards));

        phiFactory = new PhiFactory();
        ERC1967Proxy phiFactoryProxy = new ERC1967Proxy(address(phiFactory), "");
        PhiFactory(payable(address(phiFactoryProxy))).initialize(
            signer, oji3, address(phiNFT1155), address(phiRewards), oji3, 0.0002 ether, 0
        );
        console2.log("PhiFactory deployed at address: %s", address(phiFactoryProxy));
    }
}
