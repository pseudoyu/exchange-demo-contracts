// SPDX-License-Identifier: MIT
// solhint-disable comprehensive-interface,check-send-result,multiple-sends
pragma solidity ^0.8.18;

import {CommonTest} from "./helpers/CommonTest.sol";
import {Exchange} from "../src/Exchange.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

contract ExchangeTest is CommonTest {
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event Transfer(address indexed from, address indexed to, uint256 value);

    function setUp() public {
        _setUp();
    }

    function testSetupState() public {
        assertEq(token1.name(), "OpenBuildToken");
        assertEq(token1.symbol(), "OBT");

        assertEq(token2.name(), "SolidityBootcampToken");
        assertEq(token2.symbol(), "SBT");
    }

    function testSwap() public {
        assertEq(token1.balanceOf(address(alice)), 10000000000000000);
        assertEq(token2.balanceOf(address(bob)), 10000000000000000);

        vm.prank(alice);
        token1.approve(address(exchange), 100);

        vm.prank(bob);
        token2.approve(address(exchange), 200);

        expectEmit(CheckAll);
        emit Transfer(address(alice), address(bob), 100);
        emit Transfer(address(bob), address(bob), 200);
        vm.prank(alice);
        exchange.swap();

        assertEq(token1.balanceOf(address(alice)), 9999999999999900);
        assertEq(token1.balanceOf(address(bob)), 100);
        assertEq(token2.balanceOf(address(bob)), 9999999999999800);
        assertEq(token2.balanceOf(address(alice)), 200);
    }
}
