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


main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
