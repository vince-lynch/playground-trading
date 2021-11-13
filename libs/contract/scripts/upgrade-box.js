// scripts/upgrade-box.js
const { ethers, upgrades } = require("hardhat");

// scripts/deploy.js
async function main() {
  const Box = await ethers.getContractFactory("Box");
  console.log("Deploying Box...");
  const box = await upgrades.deployProxy(Box);
  console.log("Box deployed to:", box.address);
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
