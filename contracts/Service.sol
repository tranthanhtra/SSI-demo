// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Identifier.sol";

contract Service {
    address admin;
    address owner;
    mapping(string => Identifier) private accounts;

    modifier onlyOwner {
        require(msg.sender == owner, "only owner can perform this action");
        _;
    }

    constructor(address _owner){
        owner = _owner;
        admin = msg.sender;
    }

    function createISC(string memory _name, uint64 _dateOfBirth, string memory _socialID, string memory _nationality, string memory _email, string memory _phoneNumber, address _owner) public onlyOwner returns (address) {
        PersonalRecord memory record = PersonalRecord(_name, _dateOfBirth, _socialID, _nationality, _email, _phoneNumber);
        Identifier newISC = new Identifier(_owner);
        newISC.store(record);
        accounts[_socialID] = newISC;
        return address(newISC);
    }
}
