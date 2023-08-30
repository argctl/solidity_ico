//const Linkerfinder = artifacts.require('Linkerfinder')
const gitarg = artifacts.require('gitarg')
const giteta = artifacts.require('giteta')
const Repo = artifacts.require('Repo')
const Handshakes = artifacts.require('Handshakes')
const gitarray = artifacts.require('gitarray')
const gitorg = artifacts.require('gitorg')

const { wait } = require('../test/utils')

module.exports = async function (deployer, network, accounts){
  //deployer.deploy(Ad, accounts[0], "https://linkerfinder.com", false, 10000)
  //deployer.deploy(Linkerfinder, accounts, 10000, 3)
  //console.log({ deployer })
  await deployer.deploy(gitorg)
  await deployer.deploy(gitarg)
  await wait(4000)
  const arg = await gitarg.deployed()//.then(async arg => {
  await deployer.deploy(giteta, accounts[0])
    //arg.name().then(console.log) 
  //constructor(address[] memory _handshakes, address _owner, uint _threshold, bool _corp) {
  await deployer.deploy(Handshakes, accounts.slice(1), accounts[0], 3, true)
  //constructor(address[] memory _handshakes, address _owner, address _gitarg) {
  await deployer.link(gitorg, gitarray)
  await deployer.deploy(gitarray, accounts.slice(1), accounts[0], arg.address)
  const array = await gitarray.deployed()
  //constructor(string memory _name, string memory _url, address _owner, address _gitarg, address _gitarray) payable {
  await deployer.link(gitorg, Repo)
  await deployer.deploy(Repo, 'TestRepo', 'https://gitlab.com/me2211/testrepo', accounts[1], arg.address, array.address)

  //})
  //const arg = await gitarg.deployed()
} 

