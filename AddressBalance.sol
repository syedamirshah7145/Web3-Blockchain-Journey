//SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

contract AddressBalance {
    address public myAddress;

    function setMyAddress(address _myAddress) public {
        myAddress = _myAddress;
    }

    function getAddressBalance() public view returns(uint) {
        return myAddress.balance;
    }
}