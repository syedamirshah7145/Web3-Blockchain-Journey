//SPDX-License-Identifier: MIT

pragma solidity ^0.8.14;

contract SendMoney {
    uint public balanceReceived;

    function deposit() public payable {
        balanceReceived += msg.value;
    }

    function getContractBalance() public view returns(uint) {
        return address(this).balance;
    }

    function withdrawAll() public {
        address payable to = payable(msg.sender);
        to.transfer(getContractBalance());
    }

    function withdraw(address payable receiver) public {
        receiver.transfer(getContractBalance());
    } 
}