// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

import {Script} from "forge-std/Script.sol";
import {MockContract} from "../test/mocks/MockContract.sol";

contract HelperConfig is Script {
    NetworkConfig public activeNetworkConfig;

    uint32 public constant CHAINID_GOERLI = 5;
    uint32 public constant CHAINID_SEPOLIA = 11155111;
    uint8 public constant CHAINID_ETHEREUM = 1;

    struct NetworkConfig {
        address adressNeeded1;
        address adressNeeded2;
    }

    constructor() {
        if (block.chainid == CHAINID_GOERLI) activeNetworkConfig = getGoerliEthConfig();
        else if (block.chainid == CHAINID_SEPOLIA) activeNetworkConfig = getSepoliaEthConfig();
        else if (block.chainid == CHAINID_ETHEREUM) activeNetworkConfig = getMainEthConfig();
        else activeNetworkConfig = getOrCreateTestChainEthConfig();
    }

    function getGoerliEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory goerliConfig = NetworkConfig(0x00000000000000000000000000000000000,0x00000000000000000000000000000000000);
        return goerliConfig;
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaConfig = NetworkConfig(0x00000000000000000000000000000000000,0x00000000000000000000000000000000000);
        return sepoliaConfig;
    }

    function getMainEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory mainConfig = NetworkConfig(0x00000000000000000000000000000000000,0x00000000000000000000000000000000000);
        return mainConfig;
    }

    function getOrCreateTestChainEthConfig() public returns (NetworkConfig memory) {
        if (activeNetworkConfig.priceFeed != address(0)) return activeNetworkConfig;

        vm.startBroadcast();
        MockContract mockContract = new MockContract();
        vm.stopBroadcast();

        NetworkConfig memory testConfig = NetworkConfig(address(mockContract));
        return testConfig;
    }
}
