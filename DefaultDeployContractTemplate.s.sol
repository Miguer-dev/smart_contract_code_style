// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

import {Script} from "forge-std/Script.sol";
import {MainContract} from "../src/MainContract.sol";

contract DeployContract is Script {
    function run() external returns (BasicNft) {
        vm.startBroadcast();
        MainContract mainContract = new MainContract();
        vm.stopBroadcast();

        return mainContract;
    }
}
