const { ethers } = require("hardhat");

async function main() {
  // deploy the coveredCall contract
  const f1_nftFactory = await ethers.getContractFactory("F1_NFT")
  const f1_nft = await f1_nftFactory.deploy(5, 10)
  console.log("test nft deployed to:", f1_nft.address);
  
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

