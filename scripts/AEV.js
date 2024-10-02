const hre = require("hardhat");

async function deploy() {
  const AEV = await hre.ethers.getContractFactory("AEV");
  const aev = await AEV.deploy(
    "AEV",
    "AEV",
    1_000_000_000_000_000_000_000_000n
  );
  await aev.waitForDeployment();
  console.log("AEV deployed at:", aev.target);
}

deploy()
  .then(() => console.log("Deployment completed!"))
  .catch((error) => console.error("Error deploying contract:", error));
