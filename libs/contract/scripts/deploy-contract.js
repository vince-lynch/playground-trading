// scripts/deploy-contract.js
const { ethers } = require("hardhat");

async function main() {
  // ethers is avaialble in the global scope
  const [deployer] = await ethers.getSigners();
  console.log(
    "Deploying the contracts with the account:",
    await deployer.getAddress()
  );

  console.log("Account balance:", (await deployer.getBalance()).toString());

  const Contract = await ethers.getContractFactory("Box");
  const contract = await Contract.deploy();
  await contract.deployed();
  console.log("contract deployed to:", contract.address);
}

main();
