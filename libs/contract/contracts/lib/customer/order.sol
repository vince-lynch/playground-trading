pragma solidity ^0.8.0;
import "./../inventory/product-inventory.sol";

contract CustomerOrder is ProductInventory {
  struct Order {
    uint256 productId;
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
    uint256 _productId,
    string memory _shippingAddress,
    string memory _desiredDeliveryDate,
    uint256 _quantity
  ) public {
    require(productIdExists(_productId));
    require(quantityReasonable(_productId, _quantity));
    Order memory order = Order(_productId, msg.sender, false, _shippingAddress, _desiredDeliveryDate, 'Date Not Allocated', _quantity);
    orders.push(order);
    orderCount++;
  }
}
