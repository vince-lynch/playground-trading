var utils = require("ethers").utils;
const { solidity } = require("ethereum-waffle");
const chai = require("chai");
chai.use(solidity);
const { expect } = chai;

const placeOrder = async (account, contract, product = "large plywood", quantity) => {
  const customerWallet = account;
  const customer = await contract.connect(customerWallet);

  /**
   * Place order
   */
  await customer.newOrder(
    product,
    "150 canary wharf shipping corp, canada place, london",
    "24/02/2022",
    quantity
  );
  const orderDetails = await customer.getOrderById(0);

  const [ id, oProductName, address, filled, s, d, a, units, amountOwed ] = orderDetails;
  expect(oProductName).to.equal(product);
  expect(address).to.equal(customerWallet.address);
  expect(filled).to.equal(false);
  expect(units.toNumber()).to.equal(quantity)

  return {
    id,
    productName: oProductName,
    address,
    filled,
    shippingAddress: s,
    desiredArrivalDate: d,
    actualArrivalData: a,
    units,
    amountOwed
  };
};

module.exports = placeOrder;
