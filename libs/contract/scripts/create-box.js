// scripts/create-box.js
const { ethers, upgrades } = require("hardhat");

async function main() {
  const Box = await ethers.getContractFactory("Box");
  const box = await upgrades.deployProxy(Box);
  await box.deployed();
  console.log("Box deployed to:", box.address);
}

main();
