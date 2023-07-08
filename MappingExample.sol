//SPDX-License-Identifier: MIT

pragma solidity 0.8.14;

contract StructExample {

    struct Transaction {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numDeposits;
        mapping (uint => Transaction) deposits;
        uint numWithdraws;
        mapping (uint => Transaction) withdraws;
    }

    mapping (address => Balance) public  balances;

    function depositMoney() public payable {
        balances[msg.sender].totalBalance += msg.value;
        Transaction memory deposit = Transaction(msg.value,block.timestamp);
        balances[msg.sender].deposits[balances[msg.sender].numDeposits] = deposit;
        balances[msg.sender].numDeposits++;
    }

    function getDeposit(address from,uint number) public view returns (Transaction memory){
        return balances[from].deposits[number];
    }

    function withdrawMoney(address payable to,uint amount) public {
        balances[msg.sender].totalBalance -= amount;

        Transaction memory withdraw = Transaction(amount,block.timestamp);

        balances[msg.sender].withdraws[balances[msg.sender].numWithdraws] = withdraw;
        balances[msg.sender].numWithdraws++;

        to.transfer(amount);

    }



}