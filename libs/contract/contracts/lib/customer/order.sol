pragma solidity ^0.8.0;
import "./../inventory/product-inventory.sol";

abstract contract CustomerOrder is ProductInventory {
  struct Order {
    string productName;
    address customerAddress;
    bool filled;
    string shippingAddress;
    string desiredDeliveryDate;
    string actualDeliveryDate;
    uint256 quantity;
  }
  Order[] private orders;
  uint private orderCount = 0;

  function newOrder(
    string memory _productName,
    string memory _shippingAddress,
    string memory _desiredDeliveryDate,
    uint256 _quantity
  ) public {
    require(productIdExists(_productName));
    require(quantityReasonable(_productName, _quantity));
    Order memory order = Order(_productName, msg.sender, false, _shippingAddress, _desiredDeliveryDate, 'Date Not Allocated', _quantity);
    orders.push(order);
    orderCount++;
  }
}
