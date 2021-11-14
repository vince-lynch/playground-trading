require("@nomiclabs/hardhat-waffle");
require("@nomiclabs/hardhat-ethers");

const { ALCHEMY_API_KEY, PRIVATE_KEY, MNEMONIC } = require('./secrets.json');

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.8.0",
  networks: {
    dev: {
      url: 'http://0.0.0.0:8545',
      gas: 5000000,
      gasPrice: 5e9,
      networkId: '*'
    }
  }
};
