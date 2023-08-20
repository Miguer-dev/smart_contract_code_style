// SPDX-License-Identifier: MIT

pragma solidity >=0.8.0 <0.9.0;

import {Test, console} from "forge-std/Test.sol";
import {MainContract} from "../../src/MainContract.sol";
import {DeployMainContract} from "../../script/DeployMainContract.s.sol";

contract DefaultTestContractTemplate is Test {
    MainContract mainContract;   
    DeployMainContract deployMainContract;

    address TEST_USER = makeAddr("user");
    uint256 constant SEND_VALUE = 0.1 ether;
    uint256 constant STARTTING_BALANCE = 10 ether;
    uint8 constant GAS_PRICE = 1;

    function setUp() external {
        deployMainContract = new DeployMainContract();
        mainContract = deployMainContract.run();

        vm.deal(TEST_USER, STARTTING_BALANCE);
    }

    //////////////////////////////
    ///         logic1         ///
    //////////////////////////////

    //////////////////////////////
    ///         logic2         ///
    //////////////////////////////

    //////////////////////////////
    ///         logic3         ///
    //////////////////////////////

    /*
    *vm.prank(TEST_USER);
    *hoax(TEST_USER, 1 ether);
    *
    *vm.warp(block.timestamp + 1);
    *vm.roll(block.number + 1);
    *
    *assert();
    *
    *vm.expectRevert(MainContract.MainContract__ErrorName.selector);
    * //expect NotRevert not exist in foundry, only need to execute the function, if the function revert the test fail.
    *
    *vm.expectEmit(true, false, false, false, address(mainContract));
    *emit EventName();
    */    
  
}
