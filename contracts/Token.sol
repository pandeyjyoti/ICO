// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.7;

import "hardhat/console.sol";

// import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20 {
    constructor(uint256 initialSupply) public ERC20("Dedh-So Token", "DST") {
        _mint(msg.sender, initialSupply);
    }
}
