const giteta = artifacts.require('giteta')
const gitarg = artifacts.require('gitarg')
const gitarray = artifacts.require('gitarray')
const gitorg = artifacts.require('gitorg')
const Commit = artifacts.require('Commit')
const Repo = artifacts.require('Repo')
const { wait } = require('./utils')

let comm = ''
let _eta = ''
let _repo = ''

contract('giteta', async accounts => {
  it('arg address matches', async () => {
    const arg = await gitarg.deployed()
    const eta = await giteta.new(arg.address)
    await wait(4000)
    const _arg = await eta.Gitarg.call()
    assert.equal(arg.address, _arg, "addresses match from deployed contract and giteta instance")
  })
  it('commit creates commit object/contract', async () => {
    const arg = await gitarg.deployed()
    const repo = await Repo.deployed()
    const commit = await Commit.deployed()
    //const eta = await giteta.deployed()
    const eta = await giteta.new(arg.address)
    _eta = eta.address
    // App.js
    await arg.approve(eta.address, 200000, { from: accounts[1] })
    await arg.transfer(accounts[1], 2000)
    //Error: VM Exception while processing transaction: revert
    const receipt = await eta.commit(
      repo.address,
      'import gitarray',
      'David Kamer <me@davidkamer.com>',
      'Wed Aug 30 19:39:21 2023 -0400',
      1000, {
        from: accounts[1]
      })
    const address = receipt.logs[0].args.commit
    comm = address
    const balance = await arg.balanceOf.call(address)
    assert.equal(balance, 999, "balance is moved to commit")
  })
  it('up function adds value', async () => {
    const arg = await gitarg.deployed()
    const eta = await giteta.at(_eta)
    const repo = await Repo.deployed()
    const com = await Commit.at(comm)
    await arg.transfer(accounts[1], 3000)
    await wait(3000)
    const creator = await com.creator()
    const data = await com.getData.call({ from: accounts[1] })
    assert.equal(comm, com.address, "commit is same as at address")
    assert.equal(data.author, 'David Kamer <me@davidkamer.com>', "commit data is populated")
    await eta.up(com.address, false, { from: accounts[1] })
    await wait(4000)
    const value = await eta.value.call(com.address)
    assert.isAtLeast(value * 1, 1000, "The value is at least 1000 after the up function call") 
  })
  it('value query for commit queries balance of arg token', async () => {
    const arg = await gitarg.deployed()
    const eta = await giteta.at(_eta)
    const com = await Commit.at(comm)
    //function value(address _commit) public view returns (uint) {
    const value = await eta.value.call(comm)
    const value_ = await arg.balanceOf(comm)
    assert.deepEqual(value, value_, "values equal")
  })
  it('queries for by time range', async () => {
    const org = await gitorg.deployed()
    const arg = await gitarg.deployed()
    const eta = await giteta.at(_eta)
    const array = await gitarray.deployed()
    //constructor(string memory _name, string memory _url, address _owner, address _gitarg, address _gitarray) payable {
    const repo = await Repo.new('test', 'gitarray.com/test', accounts[2], arg.address, array.address)
    _repo = repo.address
    await wait(2000)
    //function commit(address _repo, string memory message, string memory author, string memory date, uint escrow) public returns (uint) {
    // c596516628aad5c55a3fb250cff6a1b48715906a
    //function approve(address _spender, uint256 _value) public returns (bool success) {
    await arg.approve(eta.address, 500)
    const receipts = []
    receipts.push(await eta.commit(repo.address,
      'commit deployment on repo',
      'David Kamer <me@davidkamer.com>',
      'Fri Sep 8 00:12:49 2023 -0400', 99))
    await wait(15000)
    // 25a24ccb76625e55f9df4c3c55cce4586b6c1813
    receipts.push(await eta.commit(repo.address,
      'commit tests',
      'David Kamer <me@davidkamer.com>',
      'Fri Sep 8 21:04:48 2023 -0400', 99))
    await wait(5000)
    const timestamp_ = await org.timestamp.call()
    // d816d9edf0f53facf0ac1715e27dbc8439371fea
    receipts.push(await eta.commit(repo.address,
      'lol',
      'David Kamer <me@davidkamer.com>',
      'Fri Sep 8 21:14:38 2023 -0400', 100))
    await wait(5000)
    // 3efd8936f3f92b80634ac023051652218410b07a
    receipts.push(await eta.commit(repo.address,
      'balance requires issue',
      'David Kamer <me@davidkamer.com>',
      'Sat Sep 9 15:39:26 2023 -0400', 100))
    const timestamp = await org.timestamp.call()
    //function query(address _repo, uint start, uint end) public view returns (Time[] memory) {
    const times = await eta.query(repo.address, timestamp_, timestamp)
    const commits = receipts.flatMap(({ logs }) => logs.flatMap(({ args: { commit } }) => (commit)))
    assert.equal(times.logs.length , 6, 'query returns the correct number of results')
    commits.shift()
    assert.equal(commits.length, 3, 'the commits.length value is correct for compare')
    commits.push(undefined)
    times.logs.forEach(({ args }) => {
      const { commit, value } = args
      const bool = commits.includes(commit)
      assert.equal(bool, true, 'the commits are in the commit list')
      if (!Number.isNaN(value * 1)) {
        assert.isAtLeast(value * 1, timestamp_ * 1, 'the timestamp is above min threshold')
        assert.isAtMost(value * 1, timestamp * 1, 'the timestamp is bellow max threshold')
      }
    })
  })
  it("timetravels (doesn't)", async () => {
    const arg = await gitarg.deployed()
    const eta = await giteta.at(_eta)
    const array = await gitarray.deployed()
    const repo = await Repo.new('test', 'gitarray.com/test', accounts[2], arg.address, array.address)
    const balance = await arg.balanceOf.call(accounts[1])
    //function commit(address _repo, string memory message, string memory author, string memory date, uint escrow) public returns (uint) {
    const com_ = await eta.commit(repo.address, 'direct functions', 'David Kamer <me@davidkamer.com>', 'Fri Sep 8 00:09:57 2023 -0400', 5, { from: accounts[1] })
    const com__ = com_.logs[0].args.commit
    const balance_ = await arg.balanceOf.call(com__)
    await wait(10000)
    const receipt = await eta.up(com__, true, { from: accounts[1] })
    const value_ = await eta.value.call(com__)
    assert.isAtLeast(value_ * 1, 6, "The value is at least 6 with balancing after the up function is called")
    assert.isAtMost(value_ * 1, 10, "The value balances to less than 5 + 7 (12)")
  })
  it("queries based on repo address", async () => {
    const eta = await giteta.at(_eta)
    //function query(address repo) public view returns (Time[] memory) {
    const commits = await eta.query.call(_repo)
    assert.equal(commits.length, 4, "the length equals the submitted commits")
  })
  it("queries based on address and value", async () => {
    const eta = await giteta.at(_eta)
    //function query(uint _value, address _repo) public view returns (Time[] memory) {
    const _commits = await eta.query.call(99, _repo)
    const commits = _commits.filter(commit => commit.timestamp !== '0')
    assert.equal(commits.length, 2, "returns based on value")
  })
  it("Down function transfers to the repo", async () => {
    //function down(address payable _repo, address payable _commit, uint bounty) public payable returns (uint) {
    const arg = await gitarg.deployed()
    const eta = await giteta.at(_eta)
    //const _arg = await eta.gitargWallet()
    const repo = await Repo.at(_repo)
    const commits = await eta.query.call(99, _repo)
    //const _commit = commits.pop()
    const _commit = commits[commits.length - 1]
    console.log({ commits })
    console.log({ _commit })
    //function down(address payable _repo, address payable _commit, uint bounty) public payable returns (uint) {
    //await eta.down(_repo, _commit.commit, 49)
    const balance = await arg.balanceOf(_commit.commit)
    console.log({ balance })
    //assert.equal(balance, 50, "That the transfer of token out of commit")
    //const balance_ = await arg.balanceOf(_repo)
    //assert.equal(balance, 49, "That the transfer of token into the repo is accurate (no gas for inner token)")
    //const commits_ = await eta.query.call(50, _repo)
  })
})
