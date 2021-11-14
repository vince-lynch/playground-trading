var utils = require('ethers').utils;
const { solidity } = require("ethereum-waffle");
const chai = require("chai");
chai.use(solidity);
const { expect } = chai;


const createStock = async (account, contract, product = "large plywood") => {
  await contract.addManager(account.address);

  const isManager = await contract.isManager(account.address);

  expect(isManager).to.equal(true);

  const warehouseManager = contract.connect(account);

  const markPrice = 1;
  const quantity = 5;

  await warehouseManager.newProduct(product, "factory1", markPrice, quantity);

  const productInventory = await warehouseManager.lookupInventoryForProduct("large plywood");
  const [idx, name, category, price, available] = productInventory;
  expect(utils.formatEther(idx)).to.equal(utils.formatEther(0));
  expect(name).to.equal(product);
  expect(category).to.equal("factory1");
  expect(utils.formatEther(price)).to.equal(utils.formatEther(markPrice));
  expect(utils.formatEther(available)).to.equal(utils.formatEther(quantity));

  return productInventory;
}

module.exports = createStock;
