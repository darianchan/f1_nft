require("@nomiclabs/hardhat-waffle");
//require("@nomiclabs/hardhat-etherscan")
require("dotenv").config();

const API_URL = "https://eth-rinkeby.alchemyapi.io/v2/HxjGSnh4Ap-GC8Hmglhof_LiZV7YMh-r"
const API_KEY = "HxjGSnh4Ap-GC8Hmglhof_LiZV7YMh-r"
const PRIVATE_KEY = "54c790c83fc83ef85898705a55063259616a3e42298ded11b9384df2172cbe9a"

task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

task("deploy", "Deploy the smart contracts", async(taskArgs, hre) => {

  const accounts = await hre.ethers.getSigners();
  const F1_NFT = await hre.ethers.getContractFactory("F1_NFT");
  const f1_NFT = await F1_NFT.deploy(5, 10);

  await f1_NFT.deployed();

  console.log("Deployed");
  console.log("Address: ", f1_NFT.address);
  // await hre.run("verify:verify", {
  //   address: f1_NFT.address,
  //   constructorArguments: [
  //     5, 
  //     10
  //   ]
  // })
  await f1_NFT.addToWhiteList(['0x3e6a2B9D58314D81234465eE778CF2794dA4E430'])
  // await f1_NFT.mainSaleMint(1);
  console.log("minted...")
})

module.exports = {
  solidity: "0.8.9"
  //  defaultNetwork: "rinkeby",
  //  networks: {
  //      hardhat: {
  //        chainId: 1337
  //      },
  //      rinkeby: {
  //        url: API_URL,
  //        accounts: [`0x${PRIVATE_KEY}`]
  //      }
  //  },
  //  etherscan: {
  //    apiKey: API_KEY,
  //  }
};