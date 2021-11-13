// contracts/BoxV2.sol
// SPDX-License-Identifier: MIT
pragma solidity >= 0.4.22 <0.9.0;
import "./lib/BEP20.sol";

contract BoxV2 is BEP20 {
    uint256 private value;
    bool private initialized;

    // Emitted when the stored value changes
    event ValueChanged(uint256 newValue);

    // Stores a new value in the contract
    function store(uint256 newValue) public {
        value = newValue;
        emit ValueChanged(newValue);
    }

    // Reads the last stored value
    function retrieve() public view returns (uint256) {
        return value;
    }

    // Increments the stored value by 1
    function increment() public {
        value = value + 1;
        emit ValueChanged(value);
    }

    function vince() public view returns(string memory) {
      return "Yes its vince";
    }


}
