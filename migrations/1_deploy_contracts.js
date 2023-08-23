//const Linkerfinder = artifacts.require('Linkerfinder')
const gitarg = artifacts.require('gitarg')

module.exports = function (deployer, network, accounts){
  //deployer.deploy(Ad, accounts[0], "https://linkerfinder.com", false, 10000)
  //deployer.deploy(Linkerfinder, accounts, 10000, 3)
  deployer.deploy(gitarg)
} 

