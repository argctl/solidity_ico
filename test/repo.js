const assert = require('node:assert')
const { wait } = require('./utils')

let _repo
let gitorg

describe('Repo', async () => {
  it('has repo name from deployed Repo object', async () => {
    //await deployer.deploy(Repo, 'TestRepo', 'https://gitlab.com/me2211/testrepo', accounts[1], arg.address, array.address)
    const [owner, buyer, spender, holder, trader] = await ethers.getSigners()
    const org = await ethers.deployContract('gitorg')
    gitorg = org.address
    const arg = await ethers.deployContract('gitarg')
    //const eta = await deployer.deploy(giteta, arg.address)
    const eta = await ethers.deployContract('giteta', [arg.address])
    //await deployer.deploy(gitarray, accounts.slice(1), accounts[0], arg.address, eta.address)
    const array = await ethers.deployContract('gitarray', [[buyer, spender, holder, trader].map(({ address }) => address), owner.address, arg.address, eta.address], { libraries: { gitorg } })
    const repo = await ethers.deployContract('Repo', ['TestRepo', 'https://gitlab.com/me2211/testrepo', owner.address, arg.address, array.address], { libraries: { gitorg } })
    _repo = repo.address
    const name = await repo.name()
    assert.equal(name, 'TestRepo', 'name from migration sticks') 
  })
  it('has repo url from deployed Repo object', async () => {
    const Repo = await ethers.getContractFactory('Repo', { libraries: { gitorg } })
    const repo = await Repo.attach(_repo)
    const url = await repo.url()
    assert.equal(url, 'https://gitlab.com/me2211/testrepo', 'test repo has accurate url')
  })
  it('adds value to repo', async () => {
    const value = 10000
    const [owner, buyer, spender] = await ethers.getSigners()
    const Repo = await ethers.getContractFactory('Repo', { libraries: { gitorg } })
    const repo = await Repo.attach(_repo)
    //function add() payable public {
    await repo.connect(spender).add({ value })
    const contribution = await repo._buyerContributions(spender.address)
    assert.equal(value, contribution * 1, 'contribution is equal to value input')
    await repo.connect(spender).add({ value })
    const contribution_ = await repo._buyerContributions(spender.address)
    assert.equal(value * 2, contribution_ * 1, 'contribution adds on buyerContribution')
  })
  /*
  it('sell for less than value store move owner account', async () => {
    //function sell(address _owner, address payable _seller, uint _value) public seller(_seller) {
    const repo = await Repo.deployed()
    await repo.sell(accounts[2], accounts[1], 9999, { from: accounts[1] })
    const owner = await repo.owner()
    const value = await repo.value()
    assert.equal(owner, accounts[2], 'account change for repo sale')
    assert.equal(value * 1, 10001, 'value retention on repo sale')
  })
  it('safeSell(s) at the price the buyer proposed', async () => {
    const value = 1000000
    const repo = await Repo.deployed();
    await repo.add({ from: accounts[3], value })
  // function safeSell(address _owner, address payable _seller, uint _value) public seller(_seller) {
    await wait(2000)
    await wait(10000)
    await repo.safeSell(accounts[3], accounts[2], value, { from: accounts[2] })
    const owner_ = await repo.owner()
    assert.equal(owner_, accounts[3], 'owner change based on safeSell')
  })
  it('_sell does not work', async () => {
    const value = 1000000
    const repo = await Repo.deployed()
    try {
      await repo._sell(accounts[4], accounts[3], { from: accounts[3] })
    } catch (e) {
      assert.equal(e.toString().split('\n')[0], 'TypeError: repo._sell is not a function', 'accessing internal function throws an error')
    }
  })
  it('highSell(s) at the highest offer price', async () => {
    const values = [10000, 1000, 100, 10, 1]
    const repo = await Repo.deployed()
    //await repo.add({ from: accounts[5], values[4] })
    //await repo.add({ from: accounts[6], values[3] })
    //await repo.add({ from: accounts[7], values[2] })
    for (let i = values.length - 1; i >= 0; i--) {
      await repo.add({ from: accounts[9 - i], value: values[i] })
    }
    //function highSell(address payable _seller) public seller(_seller) {
    await wait(4000)
    await repo.highSell(accounts[3], { from: accounts[3] })
    await wait(4000)
    const buyer = accounts[accounts.length - 1]
    const owner = await repo.owner()
    assert.equal(buyer, owner, 'buyer and owner match')
  })
  */
  it('stamp(s), hashes functions', async () => {
    const Repo = await ethers.getContractFactory('Repo', { libraries: { gitorg } })
    const repo = await Repo.attach(_repo)
    //function stamp(string memory _hash) public {
    const _hash = '1f8fb8d143a0873188c4ed36e843b911bf433e2c'
    //const org = await gitorg.deployed()
    const receipt = await repo.stamp(_hash)
    console.log({ receipt })
    const timestamp = (await receipt.wait()).events[0].args['timestamp'] * 1
    await wait(2000)
    //function verification(uint iteration) public view created returns (bytes32) {
    const receipt_ = await repo['verification(uint256)'](1)
    const hash_ = (await receipt_.wait()).events[0].args['hash']
    const receipt__ = await repo._stamp(_hash, timestamp)
    const hash__ = (await receipt__.wait()).events[0].args['hash']
    // issue with call and computation in non-solidity call
    assert.equal(hash_, hash__, 'hashes match')
  })
  it('allow adds user to allow list', async () => {
    const [owner, buyer, spender, holder, trader] = await ethers.getSigners()
    const Repo = await ethers.getContractFactory('Repo', { libraries: { gitorg } })
    const repo = await Repo.attach(_repo)
    assert.equal(await repo.owner(), owner.address, "owner matches default creation signer/account")
    await repo.connect(owner).allow(trader.address)
    const allowed = (await repo.allowed(trader.address)) * 1
    assert.equal(allowed > 1, true, 'allowed timestamp is above 1')
  })
  it('disallow adds user to disallow list', async () => {
    const [owner, buyer, spender, holder, trader] = await ethers.getSigners()
    const Repo = await ethers.getContractFactory('Repo', { libraries: { gitorg } })
    const repo = await Repo.attach(_repo)
    assert.equal(await repo.owner(), owner.address, "repo owner matches default creation signer/account")
    await repo.connect(owner).revoke(trader.address, false)
    let error
    try {
      const res = await repo.connect(trader)['verification(uint256)'](1)
    } catch (e) {
      error = e.toString()
    }
    assert.equal(
      error.split('\n')[0],
      "Error: VM Exception while processing transaction: reverted with reason string 'the sender's timestamp was revoked more recently'",
      "the sender's timestamp was revoked more recently")
  })
  it('allows verification with the gitarray address', async () => {
    //function verification(address payable _gitarray, uint iteration) public auth returns (bytes32) {
    const [owner, buyer] = await ethers.getSigners()
    const Repo = await ethers.getContractFactory('Repo', { libraries: { gitorg } })
    const repo = await Repo.attach(_repo)
    //gitarray address is not creator from deployer because of migration arch
    //const array = await gitarray.deployed()
    const receipt = await repo["verification(address,uint256)"](owner.address, 1)
    const receipt_ = await repo["verification(uint256)"](1)
    const hash_ = (await receipt.wait()).events[0].args.hash
    const hash__ = (await receipt.wait()).events[0].args.hash
    assert.equal(hash_, hash__, 'hashes match from creator address verify')
    let error
    try {
      await repo['verification(address,uint256)'](buyer.address, 1) 
    } catch (e) {
      error = e.toString()
    }
    assert.equal(
      error.split('\n'),
      "Error: VM Exception while processing transaction: reverted with reason string 'verification address is not creator'",
      'Error given when verification is on wrong creator address')
  })
  it('restricts private access vars', async () => {
    const [owner, buyer, spender] = await ethers.getSigners()
    const Repo = await ethers.getContractFactory('Repo', { libraries: { gitorg } })
    const repo = await Repo.attach(_repo)
    //bytes32[] private hash;
    //address private array;
    //address private arg;
    //mapping(address => uint) private buyerContributions;
    //address[] private buyers;

    try {
      await repo.hash(0)
    } catch (e) {
      assert.equal(e.toString().split('\n')[0], 'TypeError: repo.hash is not a function', 'var hash is private')
    }
    try {
      await repo.array()
    } catch (e) {
      assert.equal(e.toString().split('\n')[0], 'TypeError: repo.array is not a function', 'var array is private')
    }
    try {
      await repo.arg()
    } catch (e) {
      assert.equal(e.toString().split('\n')[0], 'TypeError: repo.arg is not a function', 'var arg is private')
    }
    try {
      await repo.buyerContributions(spender)
    } catch (e) {
      assert.equal(e.toString().split('\n')[0], 'TypeError: repo.buyerContributions is not a function', 'var buyerContributions is private')
    }
    try {
      await repo.buyers(0)
    } catch (e) {
      assert.equal(e.toString().split('\n')[0], 'TypeError: repo.buyers is not a function', 'var buyers is private')
    }
  })
})

