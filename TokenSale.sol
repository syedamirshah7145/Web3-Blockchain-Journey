// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

abstract contract ERC20 {
    function transferFrom(address _from,address _to,uint256 _amount) public virtual returns(bool);
    function decimals() public virtual view returns(uint8);
}

contract TokenSale {
    address public tokenOwner;
    ERC20 public token;
    uint public tokenPriceInWei = 1 ether;

    constructor(address _token) {
        tokenOwner = msg.sender;
        token = ERC20(_token);
    }

    function purchaseACoffee() public payable{
        require(msg.value >= tokenPriceInWei, "Amount is not enough!");
        uint tokensToTransfer = msg.value/tokenPriceInWei;
        uint remainder = msg.value-tokensToTransfer*tokenPriceInWei;
        token.transferFrom(tokenOwner,msg.sender,tokensToTransfer * 10** token.decimals());
        payable(msg.sender).transfer(remainder);
    }

}