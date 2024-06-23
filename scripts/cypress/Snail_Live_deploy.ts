// scripts/deploy.js


async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    const SnailToken = await ethers.getContractFactory("Snail");

    // create2 Deploy

    const salt = "0xdbe2b933bb7d57444cdba9c71b5ceb79b60dc455ad691d856e6e4025cf542caa"
    const initCodeHash = "0x20901ebc44b4ca077fc14251dd1316221f764b8eb90517842938ed889339e38b";
    console.log("SnailToken.bytecode:", SnailToken.bytecode);
    const create2Address = ethers.getCreate2Address(
        deployer.address,
        salt,
        initCodeHash
    );

    console.log("create2Address:", create2Address);

    const snail = await upgrades.deployProxy(SnailToken, [deployer.address]
        );

    await snail.waitForDeployment();

    console.log("Snail deployed to:", snail.address);
    
}

main()
  .then(() => process.exit(0))
  .catch(error => {
    console.error(error);
    process.exit(1);
  });
