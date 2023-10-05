import { ethers } from "hardhat";

async function main() {
  // const drop = await ethers.deployContract("Drop");

  // await drop.deployed();

  // console.log(`Drop Contract deployed to: ${drop.address}`);

  const Merkle = await ethers.deployContract("Merkle", [
    "0xa5a6af6C7Eb4F39Ac3E247887FdaF86f0E649794",
  ]);

  await Merkle.deployed();

  console.log(`Merkle Contract deployed to: ${Merkle.address}`);
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
