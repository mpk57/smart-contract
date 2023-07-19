require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
module.exports = {
  solidity: "0.8.9",
  networks: {
    nosrun: {
      url: "https://l2-node.regtest.trustless.computer",
      // accounts: [`${process.env.PRIVATE_KEY}`],
      chainId: 42070,
      //https://nos-explorer.regtest.trustless.computer
    },
  },
  paths: {
    sources: "./contracts",
    tests: "./test",
    cache: "./cache",
    artifacts: "./artifacts",
  },
};
