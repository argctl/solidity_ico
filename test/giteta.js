const assert = require('node:assert')
const { wait } = require('./utils')

let comm = ''
let _eta = ''
let _repo = ''
let _repoOwner
let _arg = ''
let _array = ''
let _org = ''

describe('giteta', async accounts => {
  it('arg address matches', async () => {
    const arg = await ethers.deployContract('gitarg')
    // REVIEW: 6d42465dc243ae8c7121b10b88b485678a1ca220
    const eta = await ethers.deployContract('giteta', [arg.address])
    await wait(4000)
    const _arg = await eta.Gitarg()
    assert.equal(arg.address, _arg, "addresses match from deployed contract and giteta instance")
  })
  it('commit creates commit object/contract', async () => {
    const [owner, buyer, ...rest] = await ethers.getSigners()
    const arg = await ethers.deployContract('gitarg')
    _arg = arg.address
    //await deployer.deploy(Repo, 'TestRepo', 'https://gitlab.com/me2211/testrepo', accounts[1], arg.address, array.address)
    //await deployer.deploy(gitarray, accounts.slice(1), accounts[0], arg.address, eta.address)
    //await deployer.deploy(Commit, accounts[0], repo.address, 'test message', 'David J Kamer', '20230830')
    //const eta = await giteta.deployed()
    const gitorg = await ethers.deployContract('gitorg')
    _org = gitorg.address
    const eta = await ethers.deployContract('giteta', [arg.address])
    const array = await ethers.deployContract('gitarray', [[buyer, ...rest].map(({ address }) => address), owner.address, arg.address, eta.address], { libraries: { gitorg: gitorg.address } }) 
    const repo = await ethers.deployContract('Repo', ['TestRepo', 'https://gitlab.com/me2211/testrepo', buyer.address, arg.address, array.address], { libraries: { gitorg: gitorg.address } })
    const commit = await ethers.deployContract('Commit', [owner.address, repo.address, 'test message', 'David J Kamer', '20230830'],
      { gasLimit: 5000000 })
    _eta = eta.address
    // App.js
    await arg.connect(buyer).approve(eta.address, 200000)
    await arg.transfer(buyer.address, 2000)
    _array = array.address
    //Error: VM Exception while processing transaction: revert
    const receipt = await eta.connect(buyer).commit(
      repo.address,
      'import gitarray',
      'David Kamer <me@davidkamer.com>',
      'Wed Aug 30 19:39:21 2023 -0400',
      1000)
    const address = (await receipt.wait()).events[1].args[0]
    // TODO - place address in commit object to validate it is a commit object
    comm = address
    const Commit = await ethers.getContractFactory('Commit')
    const c = await Commit.attach(comm) 
    assert.equal(c.address, comm, "is commit object")
    //const balance = await arg.balanceOf(buyer.address)
    //assert.equal(balance, 999, "balance is moved to commit")
  })
  it('up function adds value', async () => {
    const [owner, buyer] = await ethers.getSigners()
    //const eta = await giteta.at(_eta)
    const giteta = await ethers.getContractFactory('giteta')
    const eta = await giteta.attach(_eta)
    const Commit = await ethers.getContractFactory('Commit')
    const com = await Commit.attach(comm)
    //const com = await Commit.at(comm)
    await wait(3000)
    const creator = await com.creator()
    const data = await com.connect(buyer).getData()
    assert.equal(comm, com.address, "commit is same as at address")
    assert.equal(data.author, 'David Kamer <me@davidkamer.com>', "commit data is populated")
    await eta.connect(buyer).up(com.address, false)
    await wait(4000)
    const value = await eta.value(com.address)
    assert.equal(value * 1 >= 1000, true, "The value is at least 1000 after the up function call") 
  })
  it('value query for commit queries balance of arg token', async () => {
    const gitarg = await ethers.getContractFactory('gitarg')
    const arg = gitarg.attach(_arg)
    const giteta = await ethers.getContractFactory('giteta')
    const eta = giteta.attach(_eta)
    const Commit = await ethers.getContractFactory('Commit')
    const com = await Commit.attach(comm)
    //function value(address _commit) public view returns (uint) {
    const value = await eta.value(comm)
    const value_ = await arg.balanceOf(comm)
    assert.equal(value * 1, value_ * 1, "values equal")
  })
  it('queries for by time range', async () => {
    const [owner, buyer, spender] = await ethers.getSigners()
    const org = await ethers.deployContract('gitorg')
    const gitarg = await ethers.getContractFactory('gitarg')
    const arg = await gitarg.attach(_arg)
    const giteta = await ethers.getContractFactory('giteta')
    const eta = await giteta.attach(_eta)
    //constructor(string memory _name, string memory _url, address _owner, address _gitarg, address _gitarray) payable {
    const repo = await ethers.deployContract('Repo', ['test', 'gitarray.com/test', spender.address, arg.address, _array], { libraries: { gitorg: org.address }})
    _repoOwner = owner
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
    const timestamp_ = await org.timestamp()
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
    const timestamp = await org.timestamp()
    //function query(address _repo, uint start, uint end) public view returns (Time[] memory) {
    const receipt = await eta['query(address,uint256,uint256)'](repo.address, timestamp_ * 1, timestamp *1)
    //console.log({ receipt: await receipt.wait().events.map(({ events }) => events.args) })
    //const times = (await receipt.wait()).events.reduce((acc, { args }) => (args.commit ? [...acc, args.commit] : acc), [])
    const times = (await receipt.wait()).events.map(({ args }) => args)
    const commits = await Promise.all(receipts.map(async ({ wait }) => {
      return (await wait()).events[1].args[0]
    }))
    assert.equal(times.length , 6, 'query returns the correct number of results')
    commits.shift()
    assert.equal(commits.length, 3, 'the commits.length value is correct for compare')
    commits.push(undefined)
    times.forEach(({ value, commit }) => {
      const bool = commits.includes(commit)
      assert.equal(bool, true, 'the commits are in the commit list')
      if (!Number.isNaN(value * 1)) {
        assert.equal(value * 1 >= timestamp_ * 1, true, 'the timestamp is above min threshold')
        assert.equal(value * 1 <= timestamp * 1, true, 'the timestamp is bellow max threshold')
      }
    })
  })
  it("timetravels (doesn't)", async () => {
    const [owner, buyer, spender] = await ethers.getSigners()
    const gitarg = await ethers.getContractFactory('gitarg')
    const arg = await gitarg.attach(_arg)
    const giteta = await ethers.getContractFactory('giteta')
    const eta = await giteta.attach(_eta)
    const gitarray = await ethers.getContractFactory('gitarray', { libraries: { gitorg: _org } })
    const array = await gitarray.attach(_array)
    const repo = await ethers.deployContract('Repo', ['test', 'gitarray.com/test', spender.address, arg.address, _array], { libraries: { gitorg: _org } })
    const balance = await arg.balanceOf(buyer.address)
    //function commit(address _repo, string memory message, string memory author, string memory date, uint escrow) public returns (uint) {
    const com_ = await eta.connect(buyer).commit(repo.address, 'direct functions', 'David Kamer <me@davidkamer.com>', 'Fri Sep 8 00:09:57 2023 -0400', 5)
    //const com__ = com_.logs[0].args.commit
    const com__ = (await com_.wait()).events[1].args.commit
    const balance_ = await arg.balanceOf(com__)
    await wait(10000)
    const receipt = await eta.connect(buyer).up(com__, true)
    const value_ = await eta.value(com__)
    assert.equal(value_ * 1 >= 6, true, "The value is at least 6 with balancing after the up function is called")
    assert.equal(value_ * 1 <= 10, true, "The value balances to less than 5 + 7 (12)")
  })
  it("queries based on repo address", async () => {
    const giteta = await ethers.getContractFactory('giteta')
    const eta = await giteta.attach(_eta)
    //function query(address repo) public view returns (Time[] memory) {
    const commits = await eta['query(address)'](_repo)
    assert.equal(commits.length, 4, "the length equals the submitted commits")
  })
  it("queries based on address and value", async () => {
    const giteta = await ethers.getContractFactory('giteta')
    const eta = await giteta.attach(_eta)
    //function query(uint _value, address _repo) public view returns (Time[] memory) {
    const _commits = await eta['query(uint256,address)'](99, _repo)
    console.log({ _commits })
    const commits = _commits.filter(commit => commit.timestamp * 1 !== 0)
    assert.equal(commits.length, 2, "returns based on value")
  })
  it("Down function transfers to the repo", async () => {
    //function down(address payable _repo, address payable _commit, uint bounty) public payable returns (uint)
    const [owner, buyer, spender] = await ethers.getSigners()
    const gitarg = await ethers.getContractFactory('gitarg')
    const arg = await gitarg.attach(_arg)
    const giteta = await ethers.getContractFactory('giteta')
    const eta = await giteta.attach(_eta)
    //const _arg = await eta.gitargWallet()
    const Repo = await ethers.getContractFactory('Repo', { libraries: { gitorg: _org } })
    const repo = await Repo.attach(_repo)
    const commits = await eta['query(uint256,address)'](99, _repo)
    //const _commit = commits.pop()
    const _commit = commits[commits.length - 1]
    const _owner = await repo.owner()
    assert.equal(_owner, spender.address, "Repo owner address from creation equals _owner address from repo call")
    //assert.equal(owner_, owner.address, "owner unchanged")
    //function down(address payable _repo, address payable _commit, uint bounty) public payable returns (uint) {
    await eta.connect(spender).down(_repo, _commit.commit, 49)
    const balance = await arg.balanceOf(_commit.commit)
    assert.equal(balance, 50, "That the transfer of token out of commit")
    const balance_ = await arg.balanceOf(_repo)
    assert.equal(balance_, 49, "That the transfer of token into the repo is accurate (no gas for inner token)")
  })
  it("drain commit from approved down call", async () => {
    const gitarg = await ethers.getContractFactory('gitarg')
    const arg = await gitarg.attach(_arg)
    const giteta = await ethers.getContractFactory('giteta')
    const eta = await giteta.attach(_eta)
    const Repo = await ethers.getContractFactory('Repo', { libraries: { gitorg: _org } })
    const repo = await Repo.attach(_repo)
    const commit = (await eta['query(uint256,address)'](50, _repo)).filter(({ timestamp }) => timestamp * 1 !== 0)[0]
    const balance_ = await arg.balanceOf(commit.commit)
    assert.equal(balance_, 50, "balance is 50 on commit")
    await eta['drain(address)'](commit.commit)
    const balance = await arg.balanceOf(_eta)
    assert.equal(balance, 50, "balance of the eta contract is equal to the amount in the commit")
  })
  it("drain commit set from start and end timestamp", async () => {
    const gitarg = await ethers.getContractFactory('gitarg')
    const arg = await gitarg.attach(_arg)
    const giteta = await ethers.getContractFactory('giteta')
    const eta = await giteta.attach(_eta)
    const gitorg = await ethers.getContractFactory('gitorg')
    const org = await gitorg.attach(_org)
    const Repo = await ethers.getContractFactory('Repo', { libraries: { gitorg: _org } })
    const repo = await Repo.attach(_repo)
    const timestamp = await org.timestamp.call()
    console.log({ timestamp })
    //function drain(uint start, uint end, address _repo) public payable returns (uint) {
    //const timestamp = await gitorg.timestamp()
    //const commits = (await eta.query.call(_repo, timestamp - 10, timestamp).filter(({ timestamp }) => timestamp !== '0')[0]
    //console.log({ commits })
  })
})
