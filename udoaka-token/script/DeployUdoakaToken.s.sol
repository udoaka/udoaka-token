// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/UdoakaToken.sol";

contract DeployUdoakaToken is Script {
    function run () external {
        vm.startBroadcast();
        new UdoakaToken(
            "Udoaka Token",
            "UDK",
            1_000_000
        );
        vm.stopBroadcast();
    }
}