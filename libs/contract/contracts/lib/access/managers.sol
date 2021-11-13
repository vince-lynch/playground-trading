pragma solidity ^0.8.0;
import "./../upgradeable/Ownable.sol";

contract WhitelistManagers is Ownable {
  // Warehouse managers
  mapping (address => bool) managers;


  function isManager(address _member) public view returns(bool) {
    return managers[_member];
  }

  function removeManager(address _member) public onlyOwner {
    require(
      isManager(_member),
      "Not member of managers."
    );
    managers[_member] = false;
  }

  function addManager(address _member) public onlyOwner {
    require(!isManager(_member),"Address is manager already.");
    managers[_member] = true;
  }
}
