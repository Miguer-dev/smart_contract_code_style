// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

import {Script} from "forge-std/Script.sol";
import {MockContract} from "../test/mocks/MockContract.sol";

contract HelperConfig is Script {
    NetworkConfig public activeNetworkConfig;

    uint32 public constant CHAINID_GOERLI = 5;
    uint32 public constant CHAINID_SEPOLIA = 11155111;
    uint8 public constant CHAINID_ETHEREUM = 1;
    uint16 public constant CHAINID_GANACHE = 5777;

    struct NetworkConfig {
        address adressNeeded1;
        address adressNeeded2;
        uint256 deployerKey;
    }

    constructor() {
        if (block.chainid == CHAINID_GOERLI) activeNetworkConfig = getGoerliEthConfig();
        else if (block.chainid == CHAINID_SEPOLIA) activeNetworkConfig = getSepoliaEthConfig();
        else if (block.chainid == CHAINID_ETHEREUM) activeNetworkConfig = getMainEthConfig();
        else if (block.chainid == CHAINID_GANACHE) activeNetworkConfig = getOrCreateGanacheChainEthConfig();
        else activeNetworkConfig = getOrCreateAnvilChainEthConfig();
    }

    function getGoerliEthConfig() public pure returns (NetworkConfig memory) {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");
        NetworkConfig memory goerliConfig = NetworkConfig(address(0),address(0),deployerKey);
        return goerliConfig;
    }

    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");
        NetworkConfig memory sepoliaConfig = NetworkConfig(address(0),address(0),deployerKey);
        return sepoliaConfig;
    }

    function getMainEthConfig() public pure returns (NetworkConfig memory) {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");
        NetworkConfig memory mainConfig = NetworkConfig(address(0),address(0),deployerKey);
        return mainConfig;
    }

    function getOrCreateGanacheChainEthConfig() public returns (NetworkConfig memory) {
        if (activeNetworkConfig.adressNeeded1 != address(0)) return activeNetworkConfig;
        uint256 deployerKey = vm.envUint("GANACHE_PRIVATE_KEY");        

        vm.startBroadcast();
        MockContract mockContract = new MockContract();
        vm.stopBroadcast();

        NetworkConfig memory testConfig = NetworkConfig(address(mockContract),address(0),deployerKey);
        return testConfig;
    }

    function getOrCreateAnvilChainEthConfig() public returns (NetworkConfig memory) {
        if (activeNetworkConfig.adressNeeded1 != address(0)) return activeNetworkConfig;
        uint256 deployerKey = vm.envUint("ANVIL_PRIVATE_KEY");        

        vm.startBroadcast();
        MockContract mockContract = new MockContract();
        vm.stopBroadcast();

        NetworkConfig memory testConfig = NetworkConfig(address(mockContract),address(0),deployerKey);
        return testConfig;
    }
}
