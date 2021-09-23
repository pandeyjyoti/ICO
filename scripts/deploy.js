async function main() {
  const [deployer] = await ethers.getSigners();

  console.log('Deploying contracts with the account:', deployer.address);

  console.log('Account balance:', (await deployer.getBalance()).toString());

  const MyToken = await ethers.getContractFactory('MyToken');
  const myToken = await MyToken.deploy(100000000);

  // const [deployer1] = await ethers.getSigners();
  const Sale = await ethers.getContractFactory('MyTokenSale');
  const sale = await Sale.deploy(30000, deployer.address, myToken.address);

  // console.log('Token address:', myToken.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
