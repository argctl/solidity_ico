//const Linkerfinder = artifacts.require('Linkerfinder')
const gitarg = artifacts.require('gitarg')
const giteta = artifacts.require('giteta')
const Repo = artifacts.require('Repo')

module.exports = function (deployer, network, accounts){
  //deployer.deploy(Ad, accounts[0], "https://linkerfinder.com", false, 10000)
  //deployer.deploy(Linkerfinder, accounts, 10000, 3)
  deployer.deploy(gitarg)
  deployer.deploy(giteta, accounts[0])
  //constructor(string memory _name, string memory _url, address _owner) payable {
  deployer.deploy(Repo, 'TestRepo', 'https://gitlab.com/me2211/testrepo', accounts[1])
} 

