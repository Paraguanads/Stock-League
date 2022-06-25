// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// When running the script with `npx hardhat run <script>` you'll find the Hardhat
// Runtime Environment's members available in the global scope.
import hre from "hardhat";
async function main() {
    // Hardhat always runs the compile task when running scripts with its command
    // line interface.
    //
    // If this script is run directly using `node` you may want to call compile
    // manually to make sure everything is compiled
    // await hre.run('compile');
    const [owner] = await hre.ethers.getSigners();
    console.log(owner.address);

    /*const Settings = await hre.ethers.getContractFactory("CoinLeagueSettingsMaticV2");
    const settings = await Settings.deploy();

    await settings.deployed();
    console.log("Settings deployed to:", settings.address);*/
    // We get the contract to deploy
    const Factory = await hre.ethers.getContractFactory("CoinLeagueV3Factory");
    const factory = await Factory.deploy('0xA4b9857198b6f5aCb82d076310224E3A4BfCb1c4', owner.address);

    await factory.deployed();

    console.log("Factory deployed to:", factory.address);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
