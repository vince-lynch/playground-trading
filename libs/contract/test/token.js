var utils = require('ethers').utils;
const { expect } = require("chai");

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
    await contract.addManager(addr1.address);

    const isManager = await contract.isManager(addr1.address);

    expect(isManager).to.equal(true);

    const warehouseManager = contract.connect(addr1);

    const markPrice = 1;
    const quantity = 50;

    await warehouseManager.newProduct("large plywood", "factory1", markPrice, quantity);

    const [idx, name, category, price, available] = await warehouseManager.lookupInventoryForProduct("large plywood");
    expect(utils.formatEther(idx)).to.equal(utils.formatEther(0));
    expect(name).to.equal("large plywood");
    expect(category).to.equal("factory1");
    expect(utils.formatEther(price)).to.equal(utils.formatEther(markPrice));
    expect(utils.formatEther(available)).to.equal(utils.formatEther(quantity));
  });

});
