// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import { UpgradeCred } from "../script/UpgradeCred.s.sol";
import { Test, console } from "forge-std/Test.sol";
import { StdCheats } from "forge-std/StdCheats.sol";
import { ERC1967Proxy } from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import { Settings } from "./helpers/Settings.sol";
import { Cred } from "../src/Cred.sol";
import { CredV2 } from "./helpers/CredV2.sol";
import { StdCheats } from "forge-std/StdCheats.sol";
import { console2 } from "forge-std/console2.sol";

contract DeployAndUpgradeTest is StdCheats, Settings {
    function setUp() public override {
        super.setUp();
    }

    function testPhiFactory() public {
        uint256 expectedValue = 1;
        assertEq(expectedValue, phiFactory.version());
    }

    // function testDeploymentIsV1() public {
    //     address proxyAddress = deployBox.deployBox();
    //     uint256 expectedValue = 7;
    //     vm.expectRevert();
    //     BoxV2(proxyAddress).setValue(expectedValue);
    // }

    function testUpgradeWorks() public {
        cred = new Cred();
        ERC1967Proxy credProxy = new ERC1967Proxy(address(cred), "");
        Cred(payable(address(credProxy))).initialize(owner, owner, owner, 500, address(0),address(0));

        CredV2 cred2 = new CredV2();

        vm.prank(owner);
        Cred(payable(address(credProxy))).upgradeToAndCall(
            address(cred2), abi.encodeWithSelector(CredV2.initializeV2.selector)
        );
        uint256 expectedValue = 2;
        assertEq(expectedValue, CredV2(payable(credProxy)).version());
    }
}
