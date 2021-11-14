pragma solidity ^0.8.0;
import "./../inventory/product-inventory.sol";
import "./credit.sol";

abstract contract CustomerOrder is CustomerCredit, ProductInventory {
  struct Order {
    uint256 idx;
    string productName;
    address customerAddress;
    bool filled;
    string shippingAddress;
    string desiredDeliveryDate;
    string actualDeliveryDate;
    uint256 quantity;
    uint256 amountOwed;
  }
  Order[] internal orders;
  uint internal orderCount = 0;

  function newOrder(
    string memory _productName,
    string memory _shippingAddress,
    string memory _desiredDeliveryDate,
    uint256 _quantity
  ) public {
    require(productIdExists(_productName));
    require(quantityReasonable(_productName, _quantity));

    uint256 price = Products[_productName].price;
    uint256 _amountOwed = _quantity * price;

    Order memory order = Order(orderCount, _productName, msg.sender, false, _shippingAddress, _desiredDeliveryDate, 'Date Not Allocated', _quantity, _amountOwed);
    orders.push(order);
    orderCount++;
  }

  function getOrderById(uint256 orderId) public view returns (
    uint256 idx,
    string memory productName,
    address customerAddress,
    bool filled,
    string memory shippingAddress,
    string memory desiredDeliveryDate,
    string memory actualDeliveryDate,
    uint256 quantity,
    uint256 amountOwed
  ){
    Order memory order = orders[orderId];
    return (order.idx, order.productName, order.customerAddress, order.filled, order.shippingAddress, order.desiredDeliveryDate, order.actualDeliveryDate, order.quantity, order.amountOwed);
  }

  function updateOrderAsFilled(uint256 orderId) internal returns (
    uint256 idx,
    string memory productName,
    address customerAddress,
    bool filled,
    string memory shippingAddress,
    string memory desiredDeliveryDate,
    string memory actualDeliveryDate,
    uint256 quantity,
    uint256 amountOwed
  ){
    orders[orderId].filled = true;
    orders[orderId].actualDeliveryDate = 'delivery date is set';
    Order memory order = orders[orderId];
    return (order.idx, order.productName, order.customerAddress, order.filled, order.shippingAddress, order.desiredDeliveryDate, order.actualDeliveryDate, order.quantity, order.amountOwed);
  }

}
