// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./openzeppelin/Ownable.sol";
import "./openzeppelin/Context.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "./access/managers.sol";
import "./inventory/product-inventory.sol";
import "./customer/order.sol";

contract IMS is Context, Ownable, WhitelistManagers, ProductInventory, CustomerOrder {
    using SafeMath for uint256;

}
