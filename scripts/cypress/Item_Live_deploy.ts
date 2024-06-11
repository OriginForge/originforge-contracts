import { ethers, upgrades } from "hardhat";

// 0x943e0f6aabF4934a3f72E324623676780f147226
async function main() {
  const Item = await ethers.getContractFactory("Item");

  const item = await upgrades.deployProxy(Item, [
    "0x78D851386840d7F70A68F2fBa538f54EBE2A5d8E",
    "0x78D851386840d7F70A68F2fBa538f54EBE2A5d8E",
    "0x78D851386840d7F70A68F2fBa538f54EBE2A5d8E",
    "0x78D851386840d7F70A68F2fBa538f54EBE2A5d8E",
  ]);

  await item.waitForDeployment();

  console.log("item deployed to:", await item.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
