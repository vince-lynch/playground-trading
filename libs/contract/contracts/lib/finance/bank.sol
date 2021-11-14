pragma solidity ^0.8;

import "@openzeppelin/contracts/access/Ownable.sol";

abstract contract Bank is Ownable {

  function getContractAddress()  public view returns (address){
    address contractAddresss = address(this);
    return contractAddresss;
  }

  function getBankBalance() public view returns (uint256){
    return payable(address(this)).balance;
  }

  function bankWithdraw() public onlyOwner {
    payable(msg.sender).transfer(this.getBankBalance());
  }
}
