import { ethers, upgrades } from "hardhat";

// async function main() {
//   // 0xda5861BDc9795b782beE9Da28bF2f941a95d2b10
//   const Land = await ethers.getContractFactory("Land");

//   const land = await upgrades.deployProxy(Land, [
//     "0x78D851386840d7F70A68F2fBa538f54EBE2A5d8E",
//     "0x78D851386840d7F70A68F2fBa538f54EBE2A5d8E",
//     "0x78D851386840d7F70A68F2fBa538f54EBE2A5d8E",
//     "0x78D851386840d7F70A68F2fBa538f54EBE2A5d8E",
//   ]);

//   await land.waitForDeployment();

//   console.log("land deployed to:", await land.getAddress());
// }
async function main() {
  // 0xda5861BDc9795b782beE9Da28bF2f941a95d2b10
  const Land = await ethers.getContractFactory("Land");

  const land = await upgrades.upgradeProxy(
    "0xda5861BDc9795b782beE9Da28bF2f941a95d2b10",
    Land,
    {}
  );

  await land.waitForDeployment();

  console.log("land deployed to:", await land.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
