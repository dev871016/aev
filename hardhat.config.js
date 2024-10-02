require("@nomicfoundation/hardhat-toolbox");

const dotenv = require("dotenv");

dotenv.config();

module.exports = {
  solidity: "0.8.24",
  networks: {
    sepolia: {
      url: process.env.SEPOLIA_RPC,
      accounts: [process.env.PRIVATE_KEY],
    },
    haqqtest: {
      url: "https://rpc.eth.testedge2.haqq.network",
      accounts: [process.env.PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: {
      sepolia: process.env.ETHERSCAN_API_KEY,
      haqqtest: process.env.ETHERSCAN_API_KEY,
    },
    customChains: [
      {
        network: "haqqtest",
        chainId: 54211,
        urls: {
          apiURL: "https://explorer.testedge2.haqq.network/api",
          browserURL: "https://explorer.testedge2.haqq.network",
        },
      },
    ],
  },
};
