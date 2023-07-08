//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract contractOne {
    receive() external payable {
        deposit();
    }

    mapping (address => uint) public addresses;

    function deposit() public payable {
        addresses[msg.sender] += msg.value;
    }
}

contract ContractTwo {
    receive() external payable {

    }

    function depositToOther(address _address) public {
        (bool success,) = _address.call{value:100,gas:240000}("");
        require(success);
    } 
}