// scripts/deploy.js
const { ethers, upgrades } = require("hardhat");



// address : 0x98ded81db4426cebdbfc1715bf3d098e5433a79a
// async function main() {
//     const [deployer] = await ethers.getSigners();
//     console.log("Deploying contracts with the account:", deployer.address);

//     const SnailToken = await ethers.getContractFactory("Snail");

//     // create2 Deploy

//     const salt = "0xdbe2b933bb7d57444cdba9c71b5ceb79b60dc455ad691d856e6e4025cf542caa"
//     const initCodeHash = "0x20901ebc44b4ca077fc14251dd1316221f764b8eb90517842938ed889339e38b";
//     console.log("SnailToken.bytecode:", SnailToken.bytecode);
//     const create2Address = ethers.getCreate2Address(
//         deployer.address,
//         salt,
//         initCodeHash
//     );

//     console.log("create2Address:", create2Address);

//     const snail = await upgrades.deployProxy(SnailToken, [deployer.address]
//         );

//     await snail.waitForDeployment();

//     console.log("Snail deployed to:", snail.address);
    
// }

async function snail() {
    const SnailToken = await ethers.getContractFactory("Snail");

    const snail = await upgrades.upgradeProxy( "0x98ded81db4426cebdbfc1715bf3d098e5433a79a",SnailToken,{});

    await snail.waitForDeployment();

    console.log("Snail deployed to:");
}

snail()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
