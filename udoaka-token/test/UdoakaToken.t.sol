// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/UdoakaToken.sol";

contract UdoakaTokenTest is Test{
    UdoakaToken token;
    address owner = address(this);
    address ella = address(0x1);
    address babe = address(0x2);

    uint256 constant INITIAL_SUPPLY = 1_000_000;

    function setUp() public{
        token = new UdoakaToken(
            "UdoakaToken",
            "UDK",
            INITIAL_SUPPLY 
        );
    }
    /* DEPLOYMENT */
    function testInitialSupplyMintedToOwner() public {
        uint256 expectedSupply = INITIAL_SUPPLY * 10 ** token.decimals();
        assertEq(token.totalSupply(), expectedSupply);
        assertEq(token.balanceOf(owner), expectedSupply);
    }
    /* TRANSFERS *
    function testTransferBetweenWallets () public {
        uint256 amount = 1_000 * 10 ** token.decimals();
        token.transfer(ella, amount);

        assertEq(token.balanceOf(ella), amount):
        assertEq(
            token.balanceOf(owner),
            token.totalSupply() - amount
        );
    }
    /* MINTING */

    function testOwnerCanMint() public {
        uint256 amount = 500 * 10 ** token.decimals();
        token.mint(ella, amount);
        assertEq(token.balanceOf(ella), amount);
    }
    function testNonOwnerCannotMint() public {
        vm.prank(ella);
        vm.expectRevert();
        token.mint(ella, 100);
    }
    /* PAUSING */

    function testPauseBlocksTransfer() public {
        token.pause();
        vm.expectRevert();
        token.transfer(ella, 200);
    }
    function testUnpauswAllowsTransfer() public {
        token.pause();
        token.unpause();
        token.transfer(ella , 100);
        assertEq(token.balanceOf(ella), 100);
    }
    
    /* BURNING */

    function testBurnReducesTotalSupply() public {
        uint256 burnAmount = 1_000 * 10 ** token.decimals();
        uint256 supplyBefore = token.totalSupply();

        token.burn(burnAmount);
        assertEq(
            token.totalSupply(),
            supplyBefore - burnAmount
        );
    }
}