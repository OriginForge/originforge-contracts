import { ethers, upgrades } from "hardhat";

async function main() {
  const Item = await ethers.getContractFactory("Item");
  const item = await upgrades.deployProxy(Item, [
    "0x18668169351566e0130d9Bf658E5cc590Af56E01",
    "0x18668169351566e0130d9Bf658E5cc590Af56E01",
    "0x18668169351566e0130d9Bf658E5cc590Af56E01",
    "0x18668169351566e0130d9Bf658E5cc590Af56E01",
  ]);

  await item.waitForDeployment();

  console.log("item deployed to:", await item.getAddress());
}
// async function main() {
//   const Item = await ethers.getContractFactory("Item");

//   const item = await upgrades.upgradeProxy(
//     "0x76387eE15A1d9D48E7a964f1A15C79A00f962345",
//     Item
//   );

//   await item.waitForDeployment();

//   console.log("item deployed to:", await item.getAddress());
// }

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
