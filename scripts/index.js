const hre = require("hardhat");

async function main() {
    const accounts = await hre.ethers.provider.listAccounts();
    console.log(accounts);
    const address = '0x5FbDB2315678afecb367f032d93F642f64180aa3';
    const Identifier = await hre.ethers.getContractFactory('Identifier');
    const identifier = Identifier.attach(address);
    // const value = await identifier.sfGet(0);
    // console.log("ListStorage", value.toString());
    identifier.address.balance;
    await identifier.store("tra", 1, "1123", "vn", "tratran050101@gmail.com", "01234", '0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266');
    // console.log(await storageFactory.sfGet(0));
}

main()
    .then(() => process.exit(0))
    .catch(error => {
        console.error(error);
        process.exit(1);
    });