// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

async function main() {
    const Service = await hre.ethers.getContractFactory("Service");
    const service = await Service.deploy("0x0000000000000000000000000000000000000000");
    await service.deployed();

    console.log('Service deployed to:', service.address);
    const Identifier = await hre.ethers.getContractFactory("Identifier");
    const identifier = await Identifier.deploy("0x0000000000000000000000000000000000000000");
    await identifier.deployed();

    console.log('Identifier deployed to:', identifier.address);
    const Recovery = await hre.ethers.getContractFactory("Recovery");
    const recovery = await Recovery.deploy(identifier.address);
    await recovery.deployed();

    console.log('Recovery deployed to:', recovery.address);

}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });
