import { ethers, upgrades } from "hardhat";

// 0x490dAb577A710dD1CA1308D013181CBeCE93AE17
// async function main() {
//   const Token = await ethers.getContractFactory("Token");

//   const token = await upgrades.deployProxy(Token, [
//     "0x78D851386840d7F70A68F2fBa538f54EBE2A5d8E",
//     "0xDb6928EdfEE6E5E07EAAb2221D3956B1e8379ED7", // diamond
//     "0x999999999939ba65abb254339eec0b2a0dac80e9", // gcklay
//     "0xf50782A24afCb26ACb85d086Cf892bFfFB5731B5", // swapscanner
//   ]);

//   await token.waitForDeployment();

//   console.log("token deployed to:", await token.getAddress());
// }

async function main() {
  // 0x490dAb577A710dD1CA1308D013181CBeCE93AE17
  const Token = await ethers.getContractFactory("Token");

  const token = await upgrades.upgradeProxy(
    "0x490dAb577A710dD1CA1308D013181CBeCE93AE17",
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
