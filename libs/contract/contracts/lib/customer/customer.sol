pragma solidity ^0.8.0;

import "./credit.sol";
import "./order.sol";

abstract contract Customer is CustomerCredit, CustomerOrder {

}
