import { ethers, upgrades } from "hardhat";

// 0x8171E22FC4F288D5DF58B0efE4b2c0250f447c1e
// async function main() {
//   const Token = await ethers.getContractFactory("Token");

//   const token = await upgrades.deployProxy(Token, [
//     "0x78D851386840d7F70A68F2fBa538f54EBE2A5d8E",
//     "0xDb6928EdfEE6E5E07EAAb2221D3956B1e8379ED7", // diamond
//     "0x999999999939ba65abb254339eec0b2a0dac80e9", // gcklay
//   ]);

//   await token.waitForDeployment();

//   console.log("token deployed to:", await token.getAddress());
// }

async function main() {
  // 0x8171E22FC4F288D5DF58B0efE4b2c0250f447c1e
  const Token = await ethers.getContractFactory("Token");

  const token = await upgrades.upgradeProxy(
    "0x8171E22FC4F288D5DF58B0efE4b2c0250f447c1e",
    Token,
    {}
  );

  await token.waitForDeployment();

  console.log("token deployed to:", await token.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
