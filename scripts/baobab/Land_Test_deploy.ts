import { ethers, upgrades } from "hardhat";

async function main() {
  const Land = await ethers.getContractFactory("Land");

  const land = await upgrades.deployProxy(Land, [
    "0x18668169351566e0130d9Bf658E5cc590Af56E01",
    "0x18668169351566e0130d9Bf658E5cc590Af56E01",
    "0x18668169351566e0130d9Bf658E5cc590Af56E01",
    "0x18668169351566e0130d9Bf658E5cc590Af56E01",
  ]);

  await land.waitForDeployment();

  console.log("land deployed to:", await land.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
