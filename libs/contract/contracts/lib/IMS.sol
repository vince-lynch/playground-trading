// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./upgradeable/Ownable.sol";
import "./upgradeable/Context.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "./IIMS.sol";
import "./access/managers.sol";
import "./inventory/product-inventory.sol";

contract IMS is Context, Ownable, WhitelistManagers, ProductInventory {
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
