import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import fs from "fs";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { getNamedAccounts, deployments, getChainId } = hre;

  const { diamond } = deployments;

  const { deployer, diamondAdmin } = await getNamedAccounts();

  await diamond.deploy("originforge", {
    from: deployer,
    owner: diamondAdmin,
    facets: ["AdminFacet"],
  });


    const networkName = deployments.getNetworkName();
    if (networkName == "baobab") {
      const abi = JSON.parse(
        fs.readFileSync("./deployments/baobab/originforge.json", "utf8")
      ).abi;

      fs.writeFileSync("./testOriginForgeAbi.abi", JSON.stringify(abi));
    } else {
      const abi = JSON.parse(
        fs.readFileSync("./deployments/klaytn/originforge.json", "utf8")
      ).abi;

      fs.writeFileSync("./LiveOriginForgeAbi.abi", JSON.stringify(abi));
    }
};

export default func;
    
    