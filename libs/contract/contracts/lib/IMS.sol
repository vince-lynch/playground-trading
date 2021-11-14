// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./openzeppelin/OZepDeps.sol";
import "./access/managers.sol";
import "./inventory/product-inventory.sol";
import "./customer/order.sol";

contract IMS is OZepDeps, WhitelistManagers, ProductInventory, CustomerOrder {

}
