pragma solidity ^0.8.0;
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

abstract contract CustomerCredit {

  using SafeMath for uint256;

  mapping(address => uint) balance;
  address[] customers;

  function addCredit() payable public {
    balance[msg.sender] = balance[msg.sender].add(msg.value);
  }

  function getBalance() public view returns (uint){
    return balance[msg.sender];
  }

  // fallback payment
  fallback () external payable {
    addCredit();
  }
}
