// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Recovery.sol";

    struct PersonalRecord {
        string name;
        uint64 dateOfBirth;
        string socialID;
        string nationality;
        string email;
        string phoneNumber;
    }

contract Identifier {
    PersonalRecord private personalRecord;

    address private owner = address(0);
    address providerDID;
    Recovery recovery;

    modifier onlyOwner {
        require(msg.sender == owner, "only owner can perform this action");
        _;
    }

    modifier onlyProvider {
        require(msg.sender == providerDID, "only provider can perform this action");
        _;
    }
    constructor(address _owner) {
        owner = _owner;
        providerDID = msg.sender;
        Recovery RSC = new Recovery(address(this));
        recovery = RSC;
    }

    function getRSCAddress() public view returns (address) {
        return address(recovery);
    }

    function storeRecovery(address _friend1, address _friend2, address _friend3) public onlyProvider {
        recovery.store(_friend1, _friend2, _friend3);
    }

    function store(PersonalRecord memory record) public onlyProvider returns (bool) {
        personalRecord = record;
        return (true);
    }

    function recover(address newAddress) public returns (bool) {
        if (msg.sender == address(recovery)) {
            owner = newAddress;
            return true;
        } else {
            return false;
        }
    }

    function verifySingleSignOn(bytes memory signature, bytes32 hash) public view returns (string memory) {
        return verify(signature, hash) ? personalRecord.email : "";
    }

    function verify(bytes memory signature, bytes32 hash) public view returns (bool) {
        uint8 v;
        bytes32 r;
        bytes32 s;

        (v, r, s) = splitSignature(signature);
        //        bytes32 senderHash = keccak256(abi.encodePacked(target));

        return (owner == address(ecrecover(hash, v, r, s)));
    }

    function splitSignature(bytes memory sig)
    public
    pure
    returns (uint8, bytes32, bytes32)
    {
        require(sig.length == 65);

        bytes32 r;
        bytes32 s;
        uint8 v;

        assembly {
        // first 32 bytes, after the length prefix
            r := mload(add(sig, 32))
        // second 32 bytes
            s := mload(add(sig, 64))
        // final byte (first byte of the next 32 bytes)
            v := byte(0, mload(add(sig, 96)))
        }

        return (v, r, s);
    }
}
