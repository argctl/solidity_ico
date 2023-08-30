const Repo = artifacts.require('Repo')
const gitorg = artifacts.require('../contracts/libraries/gitorg.sol')

contract('Repo', async accounts => {
  it('has repo name from deployed Repo object', async () => {
    const repo = await Repo.deployed()
    const name = await repo.name()
    assert.equal(name, 'TestRepo', 'name from migration sticks') 
  })
  it('has repo url from deployed Repo object', async () => {
    const repo = await Repo.deployed()
    const url = await repo.url()
    assert.equal(url, 'https://gitlab.com/me2211/testrepo', 'test repo has accurate url')
  })
  it('adds value to repo', async () => {
    const value = 10000
    const repo = await Repo.deployed()
    //function add() payable public {
    await repo.add({ from: accounts[2], value })
    const contribution = await repo.buyerContributions(accounts[2])
    assert.equal(value, contribution * 1, 'contribution is equal to value input')
    await repo.add({ from: accounts[2], value })
    const contribution_ = await repo.buyerContributions(accounts[2])
    assert.equal(value * 2, contribution_ * 1, 'contribution adds on buyerContribution')
  })
  it('repo sale for less than value store move owner account', async () => {
    //function sell(address _owner, address payable _seller, uint _value) public seller(_seller) {
    const repo = await Repo.deployed()
    await repo.sell(accounts[2], accounts[1], 9999, { from: accounts[1] })
    const owner = await repo.owner()
    const value = await repo.value()
    assert.equal(owner, accounts[2], 'account change for repo sale')
    assert.equal(value * 1, 10001, 'value retention on repo sale')
  })
  // function safeSell(address _owner, address payable _seller, uint _value) public seller(_seller) {
  it('safeSells at the price the buyer proposed', async () => {
   
  })
})

