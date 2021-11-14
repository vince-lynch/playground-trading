var utils = require('ethers').utils;
const { solidity } = require("ethereum-waffle");
const chai = require("chai");
chai.use(solidity);
const { expect } = chai;


const orderIsFilled = async (account, contract, orderIdx) => {
  const customerWallet = account;
  const customer = await contract.connect(customerWallet);

  const [ _a, _b, _c, isFilled ] = await customer.getOrderById(orderIdx);
  expect(isFilled).to.equal(true);
}

module.exports = orderIsFilled;
