/** @type import('hardhat/config').HardhatUserConfig */
require('@nomiclabs/hardhat-ethers')
module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.8.20"
      },
      {
        version: "0.8.18"
      }
    ]
  },
  networks: {
    hardhat: {
      gasPrice: 5000000000,
      //allowUnlimitedContractSize: true
    },
    localhost: {
      gasPrice: 5000000000,
      //allowUnlimitedContractSize: true
    }
  }
};
