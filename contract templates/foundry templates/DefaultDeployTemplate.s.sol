// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

import {Script} from "forge-std/Script.sol";
import {MainContract} from "../src/MainContract.sol";

contract DeployContract is Script {

    function run() external returns (MainContract) {
        vm.startBroadcast();
        MainContract mainContract = new MainContract();
        vm.stopBroadcast();

        return mainContract;
    }
}

--------------------------------------------------------------------------------------

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {MainContract} from "../src/MainContract.sol";
import {HelperConfig} from "./HelperConfig.s.sol";

contract DeployContract is Script {

    function run() external returns (MainContract, HelperConfig) {
        HelperConfig config = new HelperConfig();
        (address parameter1, address parameter2, uint256 deployerKey) = config.activeNetworkConfig();       

        vm.startBroadcast(deployerKey);
        MainContract mainContract = new MainContract(parameter1,parameter2);       
        vm.stopBroadcast();
        return (mainContract,config);
    }
}
