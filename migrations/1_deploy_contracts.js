//const Linkerfinder = artifacts.require('Linkerfinder')
const gitarg = artifacts.require('gitarg')
const giteta = artifacts.require('giteta')
const Repo = artifacts.require('Repo')
const Commit = artifacts.require('Commit')
const Handshakes = artifacts.require('Handshakes')
const gitarray = artifacts.require('gitarray')
const gitorg = artifacts.require('gitorg')
const gas = artifacts.require('gas')
const _type = artifacts.require('_type')
const _uint = artifacts.require('_uint')
const _int = artifacts.require('_int')
const _string = artifacts.require('_string')
const _address = artifacts.require('_address')
const argctl = artifacts.require('argctl')
const gitar = artifacts.require('gitar')
const ratig = artifacts.require('ratig')
const rig = artifacts.require('rig')

const { wait } = require('../test/utils')

module.exports = async function (deployer, network, accounts){
  //deployer.deploy(Ad, accounts[0], "https://linkerfinder.com", false, 10000)
  //deployer.deploy(Linkerfinder, accounts, 10000, 3)
  //console.log({ deployer })
  await deployer.deploy(gitorg)
  await deployer.deploy(gas)
  const arg = await deployer.deploy(gitarg)
  //await wait(4000)
  //const arg = await gitarg.deployed()
  console.log('arg address: ', arg.address)
  const eta = await deployer.deploy(giteta, arg.address)
  //constructor(address[] memory _handshakes, address _owner, uint _threshold, bool _corp) {
  const handshakes = await deployer.deploy(Handshakes, accounts.slice(1), accounts[0], 3, true)
  //constructor(address[] memory _handshakes, address _owner, address _gitarg) {
  await deployer.link(gitorg, gitarray)
  //constructor(address[] memory _handshakes, address _owner, address _gitarg, address _giteta) {
  await deployer.deploy(gitarray, accounts.slice(1), accounts[0], arg.address, eta.address)
  const array = await gitarray.deployed()
  //constructor(string memory _name, string memory _url, address _owner, address _gitarg, address _gitarray) payable {
  await deployer.link(gitorg, Repo)
  await deployer.deploy(Repo, 'TestRepo', 'https://gitlab.com/me2211/testrepo', accounts[1], arg.address, array.address)
  const repo = await Repo.deployed()
  //constructor(address _wallet, address _repo, string memory _message, string memory _author, string memory _date) {
  await deployer.deploy(Commit, accounts[0], repo.address, 'test message', 'David J Kamer', '20230830')
  await deployer.deploy(_type)
  await deployer.deploy(_uint, 100)
  await deployer.deploy(_int, 100)
  await deployer.deploy(_string, "duck")
  await deployer.deploy(_address, accounts[0])
  //constructor (address handshakes_, address gitorg_, address gitarg_) {
  const org = await gitorg.deployed()
  await deployer.link(gitorg, argctl)
  //constructor (address handshakes_, address gitorg_, address gitarg_, address gitarray) {
  //constructor (address handshakes_, address gitorg_, address gitarg_, address _gitarray, address _giteta) {
  const ctl = await deployer.deploy(argctl, handshakes.address, org.address, arg.address, array.address, eta.address)
  //const ctl = await deployer.deploy(argctl, handshakes.address, org.address, arg.address, array.address)
  //function add(address handshake) public own stop returns (uint) {
  await handshakes.add(ctl.address, { from: accounts[1] })
  //constructor (address gitarg_, uint _price, uint threshold, uint ratio) {
  const tar = await deployer.deploy(gitar, arg.address, 100000, 10000000000, 2, { from: accounts[0] })
  //constructor (address _gitarg, address _gitar) {
  await deployer.deploy(ratig, arg.address, tar.address)
  await deployer.link(gas, rig)
  await deployer.deploy(rig, 90, 130, gitar.address)
} 

