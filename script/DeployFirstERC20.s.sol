// SPDX-License-Identifier: MIT

pragma solidity 0.8.36;

import {Script} from "forge-std/Script.sol";
import {console} from "forge-std/console.sol";
import {FirstERC20} from "../src/FirstERC20.sol";

contract DeployFirstERC20 is Script {
    function run() external {
        uint256 _pk = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(_pk);
        string memory _name = "Mauro Token";
        string memory _symbol = "MTOKEN";
        FirstERC20 token = new FirstERC20(_name, _symbol);

        console.log("The address of the token is: ", address(token));
        vm.stopBroadcast();
    }
}