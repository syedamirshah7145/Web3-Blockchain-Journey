//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract SmartContract {
    address payable public owner;

    mapping (address => uint) public allowance;
    mapping (address => bool) public isAllowedToSend;

    mapping (address => bool) public guardian;
    address payable nextOwner;
    uint guardiansResetCount;
    uint public constant confirmationsFromGuardiansForReset = 3;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable{
    }

    function setAllowance(address _to,uint _amount) public {
        require(msg.sender == owner , "You are not the owner of the wallet!");
        allowance[_to] = _amount;
        isAllowedToSend[_to] = true;
    }

    function setDeny(address _to) public {
        require (msg.sender == owner, "You are not the owner aborting!");
        isAllowedToSend[_to] = false;
    }

    function transfer(address payable _to,uint _amount,bytes memory payload) public returns(bytes memory data){
        require(_amount <= address(this).balance, "You don't have enough balance!");
        if(msg.sender != owner) {
            require(isAllowedToSend[msg.sender], "You are not allowed to send balance!");
            require(allowance[msg.sender] >= _amount, "You don't have enough allowance!");
            allowance[msg.sender] -= _amount;

            (bool success,bytes memory returnData) = _to.call{value : _amount}(payload);
            require(success, "Transaction failed aborting!");
            return returnData;
        }
    }

    function proposeNewOwner(address payable newOwner) public {
        require(guardian[msg.sender], "You are no guardian, aborting");
        if(nextOwner != newOwner) {
            nextOwner = newOwner;
            guardiansResetCount = 0;
        }

        guardiansResetCount++;

        if(guardiansResetCount >= confirmationsFromGuardiansForReset) {
            owner = nextOwner;
            nextOwner = payable(address(0));
        }
    }

}