require("@nomicfoundation/hardhat-toolbox");
const fs = require('fs');
const mnemonic = fs.readFileSync(".secret").toString().trim();
const infuraProjectId = fs.readFileSync(".infura").toString().trim();
const apiKey = fs.readFileSync(".etherscan").toString().trim();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks: {
    sepolia: {
      url: `https://sepolia.infura.io/v3/${infuraProjectId}`,
      accounts: {
        mnemonic,
        path: "m/44'/60'/0'/0",
        initialIndex: 0,
        count: 10,
      }
    }
  },
  etherscan: {
    apiKey: {
      sepolia: apiKey,
    }
  },
};
