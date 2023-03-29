// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "./Identifier.sol";

contract Recovery {
    address friend1;
    address friend2;
    address friend3;
    Identifier identifier;
    bool hasRequest1;
    bool hasRequest2;
    bool hasRequest3;

    constructor(Identifier _identifier) payable {
        identifier = _identifier;
    }

    function store(address _friend1, address _friend2, address _friend3) public payable {
        require(msg.sender == address(identifier), "only the associate ISC can perform this action");
        friend1 = _friend1;
        friend2 = _friend2;
        friend3 = _friend3;
    }

    function request(address friend, address newAddress) public payable {
        if (friend == friend1) {
            hasRequest1 = true;
        } else if (friend == friend2) {
            hasRequest2 = true;
        } else if (friend == friend3) {
            hasRequest3 = true;
        }
        if (hasRequest1 && hasRequest2 && hasRequest3) {
            identifier.recover(newAddress);
        }
    }

    function revoke(address friend) public payable {
        if (friend == friend1) {
            hasRequest1 = false;
        } else if (friend == friend2) {
            hasRequest2 = false;
        } else if (friend == friend3) {
            hasRequest3 = false;
        }
    }

}
