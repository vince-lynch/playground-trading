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

    mapping(string => uint256) private productMap; // Note this must be private if you’re going to use `string` as the key. Otherwise, use bytes32

    //mapping(address => mapping(address => uint256)) private _allowances;

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

    function lookupStockItem(uint256 _id) public view returns (
      uint256 id,
      string memory name,
      string memory category,
      uint256 price,
      uint256 avail
    ){
      Item storage item = items[_id];
      return (item.id, item.name, item.category, item.price, item.avail);
    }

    //Updates a stock item in the stock struc
    function update_stock(uint256 _id, string memory _n, string memory _cat, uint256 _p, uint256 _avail) public returns (
      uint256 id,
      string memory name,
      string memory category,
      uint256 price,
      uint256 avail
    ){
      items[_id].id = _id;
      items[_id].name = _n;
      items[_id].category = _cat;
      items[_id].price = _p;
      items[_id].avail = _avail;
      Item storage i = items[_id];
      return (i.id, i.name, i.category, i.price, i.avail);
    }

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
