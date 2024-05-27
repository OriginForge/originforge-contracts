import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-ethers";
import "dotenv/config";
import "./tasks";
import "@openzeppelin/hardhat-upgrades";
import "hardhat-deploy";

const config: HardhatUserConfig = {
  solidity: {
    compilers: [
      {
        version: "0.5.16",
        settings: {
          optimizer: { enabled: true, runs: 200 },
        },
      },
      {
        version: "0.6.6",
        settings: {
          optimizer: { enabled: true, runs: 200 },
        },
      },
      {
        version: "0.8.0",
        settings: {
          optimizer: { enabled: true, runs: 200 },
        },
      },
      {
        version: "0.8.18",
        settings: {
          optimizer: { enabled: true, runs: 200 },
        },
      },
      {
        version: "0.8.20",
        settings: {
          optimizer: { enabled: true, runs: 200 },
        },
      },
      {
        version: "0.8.22",
        settings: {
          optimizer: { enabled: true, runs: 200 },
        },
      },
      {
        version: "0.8.20",
        settings: {
          optimizer: { enabled: true, runs: 200 },
        },
      },
      {
        version: "0.5.6",
        settings: {
          optimizer: { enabled: true, runs: 200 },
        },
      },
      {
        version: "0.8.12",
        settings: {
          optimizer: { enabled: true, runs: 200 },
        },
      },
      {
        version: "0.8.17",
        settings: {
          optimizer: { enabled: true, runs: 200 },
        },
      },
    ],
    settings: {
      outputSelection: {
        "*": {
          "*": ["storageLayout"],
        },
      },
    },
  },
  networks: {
    klaytn: {
      chainId: 8217,
      url: "https://en.ciccommunity.com:8551",
      accounts: [process.env.PRIVATE_KEY as string],
    },
    baobab: {
      chainId: 1001,
      url: process.env.KLAYTN_NODE_TEST_ENDPOINT as string,
      accounts: [process.env.PRIVATE_KEY as string],
    },
  },
  namedAccounts: {
    deployer: 0,
    cypress: {
      default: 0,
    },
    baobab: {
      default: 1,
    },
  },
  etherscan: {
    apiKey: {
      klaytn: "unnecessary",
      baobab: "unnecessary",
    },
    customChains: [
      {
        network: "klaytn",
        chainId: 8217,
        urls: {
          apiURL: "https://api-cypress.klaytnscope.com/api",
          browserURL: "https://klaytnscope.com",
        },
      },
      {
        network: "baobab",
        chainId: 1001,
        urls: {
          apiURL: "https://api-baobab.klaytnscope.com/api",
          browserURL: "https://baobab.klaytnscope.com",
        },
      },
    ],
  },
  sourcify: {
    enabled: false,
  },
};

export default config;
