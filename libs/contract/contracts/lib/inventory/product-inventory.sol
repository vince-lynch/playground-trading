pragma solidity ^0.8.0;
import "./../access/managers.sol";

contract ProductInventory is WhitelistManagers {

    struct Product {
      uint256 id;
      string name;
      string category;
      uint256 price;
      uint256 avail;
    }
    Product[] public items;

    string[] public productNames;
    uint256[] public productIds;
    uint public productCount = 0;

    function listProducts() public view returns(Product[] memory){
      Product[] memory lItems = new Product[](productCount);
      for (uint i = 0; i < productCount; i++) {
          Product storage lItem = items[i];
          lItems[i] = lItem;
      }
      return lItems;
   }


    function newProduct(uint256 _id, string memory _n, string memory _cat, uint256 _price, uint256 _avail) public {
      Product memory item = Product(_id, _n, _cat, _price, _avail);
      items.push(item);
      productCount++;
    }

    function lookupInventoryForProduct(uint256 _id) public view returns (
      uint256 id,
      string memory name,
      string memory category,
      uint256 price,
      uint256 avail
    ){
      Product storage item = items[_id];
      return (item.id, item.name, item.category, item.price, item.avail);
    }

    //Updates a stock item in the stock struc
    function updateInventoryForProduct(uint256 _id, string memory _n, string memory _cat, uint256 _p, uint256 _avail) public returns (
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
      Product storage i = items[_id];
      return (i.id, i.name, i.category, i.price, i.avail);
    }
}
