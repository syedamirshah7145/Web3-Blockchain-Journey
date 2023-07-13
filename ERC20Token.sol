// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract CoffeeSale is ERC20, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    event purchaseOneCoffee(address indexed receiver, address indexed spender);

    constructor() ERC20("CoffeeSale", "CFE") {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(MINTER_ROLE, msg.sender);
    }

    function mint(address to, uint256 amount) public onlyRole(MINTER_ROLE) {
        _mint(to, amount * 10 ** decimals());
    }

    function buyOneCoffee() public {
        _burn(_msgSender(), 1);
        emit purchaseOneCoffee(_msgSender(),_msgSender());
    }

    function buyOneCoffeeFrom(address _account) public {
        _spendAllowance(_account, _msgSender(), 1 * 10 ** decimals());
        _burn(_account, 1 * 10 ** decimals());
        emit purchaseOneCoffee(_msgSender(),_account);
    }
}