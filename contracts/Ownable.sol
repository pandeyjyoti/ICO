// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract Ownable {
    address public _owner;

    constructor() {
        _owner = msg.sender;
    }

    modifier Onlyowner() {
        require(isOwner(), "NOT OWNER");
        _;
    }

    function isOwner() public view returns (bool) {
        return (msg.sender == _owner);
    }
}
