require("@nomicfoundation/hardhat-verify");
require('@nomicfoundation/hardhat-toolbox');

const MNEMONIC = "cup aisle bright dice when flame left assume laptop lock cry brown";

module.exports = {
  solidity: {
    version: "0.8.17",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  sourcify: {
    enabled: true
  },
  networks: {
    tanenbaum: {
      url: "https://rpc.tanenbaum.io",
      accounts: { mnemonic: MNEMONIC },
      chainId: 5700,
      gas: 8000000,
      gasPrice: 120000000,
    },
    mainnet: {
      url: "https://rpc.syscoin.org",
      accounts: { mnemonic: MNEMONIC },
      chainId: 57,
      gas: 1000000,
      gasPrice: 1000000,
    },
    development: {
      url: "http://localhost:8545",
      accounts: { mnemonic: MNEMONIC },
      chainId: 1337,
      gas: 4700000,
      gasPrice: 1,
    },
  },
};
