// SPDX-License-Identifier: MIT
// solhint-disable comprehensive-interface
pragma solidity 0.8.18;

import {OpenBuildToken} from "../../src/mocks/OpenBuildToken.sol";
import {SolidityBootcampToken} from "../../src/mocks/SolidityBootcampToken.sol";
import {Exchange} from "../../src/Exchange.sol";
import {Utils} from "./Utils.sol";

contract CommonTest is Utils {
    OpenBuildToken public token1;
    SolidityBootcampToken public token2;
    Exchange public exchange;

    address public constant admin = address(0x999999999999999999999999999999);

    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");

    uint256 public constant alicePrivateKey = 0x1111;
    uint256 public constant bobPrivateKey = 0x2222;
    uint256 public constant carolPrivateKey = 0x3333;
    uint256 public constant dickPrivateKey = 0x4444;
    uint256 public constant erikPrivateKey = 0x5555;

    address public alice = vm.addr(alicePrivateKey);
    address public bob = vm.addr(bobPrivateKey);
    address public carol = vm.addr(carolPrivateKey);
    address public dick = vm.addr(dickPrivateKey);
    address public erik = vm.addr(erikPrivateKey);

    function _setUp() internal {
        _deployContracts();
    }

    function _deployContracts() internal {
        // deploy token
        vm.prank(alice);
        token1 = new OpenBuildToken();

        vm.prank(bob);
        token2 = new SolidityBootcampToken();
        exchange = new Exchange(address(token1), alice, 100, address(token2), bob, 200);
    }
}
