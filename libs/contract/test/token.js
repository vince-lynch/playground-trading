var utils = require('ethers').utils;
const { solidity } = require("ethereum-waffle");
const chai = require("chai");
chai.use(solidity);
const { expect } = chai;

const createStock = require("./utils/create-stock.js");



describe("Token contract", function () {

  let Contract;
  let contract;
  let owner;
  let addr1;
  let addr2;
  let addrs;


  beforeEach(async function () {
    // Get the ContractFactory and Signers here.
    Contract = await ethers.getContractFactory("Box");
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();

    // To deploy our contract, we just have to call Token.deploy() and await
    // for it to be deployed(), which happens once its transaction has been
    // mined.
    contract = await Contract.deploy();
  });

  it("Initialiser of the contract is the owner of the contract", async function () {
    expect(await contract.owner()).to.equal(owner.address);
  });


  it("Check basic can write/read to/from contract", async function () {
    const storeNum = 45;
    await contract.store(storeNum)
    const exp = utils.formatEther(storeNum);

    const res = utils.formatEther(await contract.retrieve());
    expect(res).to.equal(exp);
  });

  /**
   * Feature: Warehouse manager can add stock to the inventory
   *
   * Given that the user is a warehouse manager
   * Given that the factory has produced the stock
   * When the user inputs the amount of stock in the factory
   * Then the amount of stock in the factory is updated
   */
  it("Feature: Warehouse manager can add stock to the inventory", async function () {
    createStock(addr1, contract)
  });

   /**
   * Feature: Customer can NOT alter stock in the inventory
   *
   * Given that the user is a customer
   * When the user changes the amount of stock in the factory
   * Then the amount of stock in the factory is NOT updated
   */
     it("Feature: Customer can NOT alter stock in the inventory", async function () {

      const customerWallet = addr2;

      const isManager = await contract.isManager(customerWallet.address);

      expect(isManager).to.equal(false);

      const customer = contract.connect(customerWallet);

      await expect(
        customer.newProduct("large plywood", "factory1", 1, 50)
      ).to.be.revertedWith("Not a manager or admin.");
    });

    /**
     * Feature: Customer can place an order
     *
     * Given that the user is a customer
     * Given that the warehouse has enough widgets to fulfil the customer order
     * Given that the customer has enough funds to pay for the order
     * Then the order is accepted
    */
     it("Feature: Customer can place an order", async function () {
      const product = 'large plywood';
      const [idx, productName, factory, price, available] = await createStock(addr1, contract);
      expect(productName).to.equal(product);

      const customerWallet = addr2;
      const customer = await contract.connect(customerWallet);

      const order1LessThanTotalSupply = available -1

      /**
       * Place order
       */
      await customer.newOrder(product, '150 canary wharf shipping corp, canada place, london', '24/02/2022', order1LessThanTotalSupply)

      const [ id, oProductName, address, filled, s, d, a, quantity, amountOwed ] = await customer.getOrderById(idx.toNumber());
      expect(oProductName).to.equal(product);
      expect(address).to.equal(customerWallet.address);
      expect(filled).to.equal(false);
      expect(amountOwed.toNumber()).to.equal(order1LessThanTotalSupply)

      const warehouseManager = await contract.connect(addr1);

      /**
       * Warehouse manager, try and fail to accept order
       */
      try {
        await warehouseManager.acceptOrder(id.toNumber())
      } catch (err) {
        expect(err.message).to.equal('VM Exception while processing transaction: revert Customers balance isnt large enough cant approve order')
      }

      /**
       * Send deposit for order
       */
      await customerWallet.sendTransaction({
        to: contract.address,
        value: ethers.utils.parseEther(amountOwed.toNumber().toString())
      });

      /**
       * Warehouse manager, Tries again to accept the order
       */
      await warehouseManager.acceptOrder(id.toNumber());
      /**
       * Order is accepted
       */
      const [ _a, _b, _c, isFilled ] = await customer.getOrderById(idx.toNumber());
      expect(isFilled).to.equal(true);

    });

});
