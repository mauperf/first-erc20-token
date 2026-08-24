// SPDX-License-Identifier:MIT 

pragma solidity 0.8.36;

import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {Test} from "forge-std/Test.sol";
import {FirstERC20} from "../src/FirstERC20.sol";


contract TestFirstERC20 is Test {

    FirstERC20 token;
    address deployer = vm.addr(1);
    address user = vm.addr(2);

    function setUp() external {
        vm.startPrank(deployer);
        token = new FirstERC20("Mauro Token", "MTOKEN");
        vm.stopPrank();
    }

    function testRevertMint_NotOwner() public {
        uint256 _amount = 1;

        vm.prank(user);
        vm.expectRevert(abi.encodeWithSelector(Ownable.OwnableUnauthorizedAccount.selector, user));
        token.mint(user, _amount);
    }

    function testRevertMint_AmountIsZero() public {
        uint256 _amount = 0;

        vm.prank(deployer);
        vm.expectRevert("Amount must be greater than zero");
        token.mint(user, _amount);
    }

    function testMint() public {
        uint256 _amount = 10 * 10 ** token.decimals();
        uint256 _balanceBefore = IERC20(token).balanceOf(user);

        vm.prank(deployer);
        token.mint(user, _amount);

        uint256 _balanceAfter = IERC20(token).balanceOf(user);
        assert(_balanceBefore + _amount == _balanceAfter);
    }
}
