// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./upgradeable/Ownable.sol";
import "./upgradeable/Context.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "./IIMS.sol";
import "./access/managers.sol";

contract IMS is Context, Ownable, WhitelistManagers {
    using SafeMath for uint256;

    struct Item {
      uint256 id;
      string name;
      string category;
      uint256 price;
      uint256 avail;
    }
    Item[] public items;

    string[] public productNames;
    uint256[] public productIds;
    uint public productCount = 0;

    function products() public view returns(Item[] memory){
      Item[] memory lItems = new Item[](productCount);
      for (uint i = 0; i < productCount; i++) {
          Item storage lItem = items[i];
          lItems[i] = lItem;
      }
      return lItems;
   }

    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    uint8 private _decimals;
    bool private _mintable;
    uint256 private _amount;

    event StockChanged(string message);

    function newStockItem(uint256 _id, string memory _n, string memory _cat, uint256 _price, uint256 _avail) public {
      Item memory item = Item(_id, _n, _cat, _price, _avail);
      items.push(item);
      productCount++;
    }

    function lookupStockItem(uint256 _itemIdx) public view returns (
      uint256 id,
      string memory name,
      string memory category,
      uint256 price,
      uint256 avail
      ){
      Item storage item = items[_itemIdx];
      return (item.id, item.name, item.category, item.price, item.avail);
    }

    // Updates a stock item in the stock struc
    // function update_stock(uint256 id, string name, string category, uint256 price, uint256 avail) public {
    //   stock[id].id = id;
    //   stock[id].name = name;
    //   stock[id].category = category;
    //   stock[id].price = price;
    //   stock[id].avail = avail;
    //   emit StockChanged('Stock changed'); // @TODO Need to concat string with details to emit
    // }

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
