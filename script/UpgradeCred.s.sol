// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import { Cred } from "../src/Cred.sol";
import { CredV2 } from "../test/helpers/CredV2.sol";
import { DevOpsTools } from "foundry-devops/DevOpsTools.sol";
import { BaseScript } from "./Base.s.sol";

contract UpgradeCred is BaseScript {
    function run() external returns (address) {
        address mostRecentlyDeployedProxy = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);

        vm.startBroadcast();
        CredV2 newCred = new CredV2();
        vm.stopBroadcast();
        address proxy = upgradeCred(mostRecentlyDeployedProxy, address(newCred));
        return proxy;
    }

    function upgradeCred(address proxyAddress, address newCred) public returns (address) {
        Cred credProxy = Cred(payable(proxyAddress));
        credProxy.upgradeToAndCall(address(newCred), abi.encodeWithSelector(CredV2.initializeV2.selector));
        return address(credProxy);
    }
}
