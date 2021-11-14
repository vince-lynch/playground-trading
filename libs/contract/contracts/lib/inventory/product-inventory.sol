pragma solidity ^0.8.0;
import "./../access/managers.sol";

contract ProductInventory is WhitelistManagers {

    string[] public ProductTypes;

    struct Product {
      uint256 idx;
      string name;
      string category;
      uint256 price;
      uint256 avail;
    }
    uint public productCount = 0;

    // Map the name of the product to the product
    mapping(string=>Product) public Products;
    // Map the id or the product to the product
    mapping(uint256=>Product) public ProductIds;

    function listProducts() public view returns(Product[] memory){
      Product[] memory lItems = new Product[](productCount);
      for (uint i = 0; i < productCount; i++) {
          Product storage lItem = ProductIds[i];
          lItems[i] = lItem;
      }
      return lItems;
   }

    function newProduct(string memory _n, string memory _cat, uint256 _price, uint256 _avail) public{
      // Restricted to managers
      require(isAdminOrManager());
      Product memory product = Product(productCount, _n, _cat, _price, _avail);
      // Map the name of the product to the product
      Products[product.name] = product;
      // Map the id or the product to the product
      ProductIds[productCount] = product;
      productCount++;
    }

    function deleteProduct(string memory _productName) public {
      // Restricted to managers
      require(isAdminOrManager());
      // Delete product from list of products
      delete Products[_productName];
      // Delete product from list of Idx
      delete ProductIds[productCount];
      productCount--;
    }

    function lookupInventoryForProduct(string memory _productName) public view returns (
      uint256 idx,
      string memory name,
      string memory category,
      uint256 price,
      uint256 avail
    ){
      Product storage item = Products[_productName];
      return (item.idx, item.name, item.category, item.price, item.avail);
    }

    //Updates a stock item in the stock struc
    function updateInventoryForProduct(string memory _productName, string memory _cat, uint256 _p, uint256 _avail) public returns (
      string memory name,
      string memory category,
      uint256 price,
      uint256 avail
    ){
      // Restricted to managers
      require(isAdminOrManager());
      Product storage product = Products[_productName];
      product.category = _cat;
      product.price = _p;
      product.avail = _avail;
      return (product.name, product.category, product.price, product.avail);
    }

    function productIdExists(string memory _n)  public view returns(bool) {
      require(Products[_n].idx >= 0, "Product ID does not exist");
      return true;
    }

    function quantityReasonable(string memory _n, uint256 _quantity) public view returns(bool) {
      require(Products[_n].avail >= _quantity, "You've ordered more than is in stock");
      return true;
    }
}
