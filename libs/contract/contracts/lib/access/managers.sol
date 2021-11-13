pragma solidity ^0.8.0;
import "./../openzeppelin/Ownable.sol";

contract WhitelistManagers is Ownable {
  // Warehouse managers
  mapping (address => bool) managers;

  function isAdminOrManager() public view returns(bool) {
    bool isAllowed = owner() == msg.sender || isManager(msg.sender);
    require(
      isAllowed,
      "Not a manager or admin."
    );
    return true;
  }

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
