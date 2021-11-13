// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./openzeppelin/Ownable.sol";
import "./openzeppelin/Context.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "./access/managers.sol";
import "./inventory/product-inventory.sol";
import "./customer/order.sol";

contract IMS is Context, Ownable, WhitelistManagers, ProductInventory, CustomerOrder {
    using SafeMath for uint256;

    string private _name;
    string private _symbol;
    uint8 private _decimals;
    bool private _mintable;
    uint256 private _amount;

    event StockChanged(string message);

    /**
     * @dev sets initials supply and the owner
     */
    function _initialize(
        string memory name,
        string memory symbol,
        uint8 decimals,
        uint256 amount,
        bool mintable
    ) internal {
        _amount = amount;
        _name = name;
        _symbol = symbol;
        _decimals = decimals;
        _mintable = mintable;
    }
}
