// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "hardhat/console.sol";

contract Credential {
    mapping(bytes32 => string) private credentials;
    address ISCAddress;

    constructor(address _ISCAddress){
        ISCAddress = _ISCAddress;
    }

    function addCredential(bytes32 hash, string memory zip) public returns (bool) {
        require(msg.sender == ISCAddress, "Only the owner can perform this action");
        console.log(bytes(credentials[hash]).length);
        if (bytes(credentials[hash]).length != 0) return false;
        credentials[hash] = zip;
        console.log(zip);
        return true;
    }

    function revokeCredential(bytes32 hash) public returns (bool) {
        require(msg.sender == ISCAddress, "Only the owner can perform this action");
        if (bytes(credentials[hash]).length == 0) return false;
        delete credentials[hash];
        return true;
    }

    function credentialActive(bytes32 hash) public view returns (bool) {
        require(msg.sender == ISCAddress, "Only the owner can perform this action");
        return (bytes(credentials[hash]).length != 0);
    }

    function getCredential(bytes32 hash) public view returns (string memory) {
        return credentials[hash];
    }
}
