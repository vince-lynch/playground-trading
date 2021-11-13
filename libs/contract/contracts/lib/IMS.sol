// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./upgradeable/OwnableUpgradeable.sol";
import "./upgradeable/ContextUpgradeable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./upgradeable/Initializable.sol";

import "./IIMS.sol";

contract IMS is Initializable, ContextUpgradeable, IIMS, OwnableUpgradeable {
    using SafeMath for uint256;

    struct _stock {
      uint256 id;
      string name;
      string category;
      uint256 price;
      uint256 avail;
      uint256 amount;
    }
    mapping(uint256=>_stock) public stock;

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    bool private _mintable;
    uint256 private _amount;

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

    function initializeToken(string memory name, string memory symbol, uint8 decimals, uint256 amount, bool mintable) public onlyOwner {
      _initialize(name, symbol, decimals, amount, mintable);
    }

    function myInitializer() initializer public {
      __Ownable_init();
    }
}
