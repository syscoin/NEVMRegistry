const { ethers, network } = require("hardhat");
const fs = require("fs");

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log("Deploying from:", deployer.address);

  const Registry = await ethers.getContractFactory("NEVMRegistry");
  const registry = await Registry.deploy();

  // Wait until the deployment transaction is mined
  await registry.waitForDeployment();

  const registryAddress = await registry.getAddress();
  console.log("NEVMRegistry deployed to:", registryAddress);

  const deployments = {
    address: registryAddress,
    network: network.name,
  };

  fs.writeFileSync(`deployments_${network.name}.json`, JSON.stringify(deployments, null, 2));
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
