// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Identifier {
    string private name;
    uint64 private dateOfBirth;
    string private socialID;
    string private nationality;
    string private email;
    string private phoneNumber;
    address private owner = address(0);

    function store(string memory _name, uint64 _dateOfBirth, string memory _socialID, string memory _nationality, string memory _email, string memory _phoneNumber, address _owner) public returns (bool) {
        owner = _owner;
        name = _name;
        dateOfBirth = _dateOfBirth;
        socialID = _socialID;
        nationality = _nationality;
        email = _email;
        phoneNumber = _phoneNumber;
        return (true);
    }

    function verifySingleSignOn(bytes memory signature, bytes32 hash) public view returns (string memory) {
        return verify(signature, hash) ? email : "";
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
