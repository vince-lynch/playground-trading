pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "./../access/managers.sol";
import "./../customer/customer.sol";

abstract contract WarehouseOrders is WhitelistManagers, Customer {
  using SafeMath for uint256;

  function listOrders() public view returns (Order[] memory) {
    require(
      isAdminOrManager(),
      "Not a manager or admin."
    );
    Order[] memory lItems = new Order[](orderCount);
    for (uint256 i = 0; i < orderCount; i++) {
      Order storage lItem = orders[i];
      lItems[i] = lItem;
    }
    return lItems;
  }

  function reduceCustomerCredit(address customerWallet, uint256 amount) internal {
    require(
      isAdminOrManager(),
      "Not a manager or admin."
    );
    balance[customerWallet] = balance[customerWallet].sub(amount);
  }


  function acceptOrder(uint256 orderId) public returns (bool){
    require(
      isAdminOrManager(),
      "Not a manager or admin."
    );

    (
      uint256 idx,
      string memory productName,
      address customerAddress,
      bool filled,
      string memory shippingAddress,
      string memory desiredDeliveryDate,
      string memory actualDeliveryDate,
      uint256 quantity,
      uint256 amountOwed
    ) = getOrderById(orderId);
    require(
      amountOwed <= balance[customerAddress],
      "Customer's balance isnt large enough, can't approve order "
    );
    reduceCustomerCredit(customerAddress, amountOwed);
    updateOrderAsFilled(idx);
  }

}
