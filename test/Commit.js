const assert = require('node:assert')
let gitorg
let _Commit
let _Repo
let _arg
describe('Commit', accounts => {
  it('can create a commit independent of repo', async () => {
  //constructor(address _wallet, address _repo, string memory _message, string memory _author, string memory _date) {
    //await deployer.deploy(Repo, 'TestRepo', 'https://gitlab.com/me2211/testrepo', accounts[1], arg.address, array.address)
    const [owner, buyer, spender, holder, trader, user] = await ethers.getSigners()
    const handshakes = [buyer, spender, holder, trader, user].map(({ address }) => address)
    const org = await ethers.deployContract('gitorg')
    gitorg = org.address
    const arg = await ethers.deployContract('gitarg')
    _arg = arg.address
    const eta = await ethers.deployContract('giteta', [arg.address])
    const array = await ethers.deployContract('gitarray', [handshakes, owner.address, arg.address, eta.address], { libraries: { gitorg } })
    const repo = await ethers.deployContract('Repo', ['TestRepo', 'https://gitlab.com/me2211/testrepo', buyer.address, arg.address, array.address], { libraries: { gitorg } })
    _Repo = repo.address
    // REVIEW - should change repo.address to repo type check? - standards review
    const commit = await ethers.deployContract('Commit', [buyer.address, repo.address, 'commit some code', 'David J Kamer', 'Wed Aug 30 19:39:21 2023 -0400'])
    _Commit = commit.address
    console.log('length: ', commit.address.length)
    assert.equal(commit.address.length, 42, 'commit address exists for new commit')
  })
  it('can set code hash', async () => {
    const Repo = await ethers.getContractFactory('Repo', { libraries: { gitorg } })
    const repo = await Repo.attach(_Repo)
    const Commit = await ethers.getContractFactory('Commit')
    const commit = await Commit.attach(_Commit)
    //function setCodeHash(bytes memory _hash) public returns (uint) {
    const hash = '5128102a5cdb583423882b64b91688193bbf049d'
    const bytes = Buffer.from(hash, 'hex')
    const hash_ = bytes.toString('hex')
    console.log({ hash, hash_ })
    assert.equal(hash, hash_, 'bytes is accurate after conversion')
    console.log({ bytes })
    await commit.setCodeHash(bytes)
    // TODO - test if the hash is set 
  })
  it('can get data', async () => {
    //const commit = await Commit.deployed()
    const [owner] = await ethers.getSigners()
    const Repo = await ethers.getContractFactory('Repo', { libraries: { gitorg } })
    const repo = await Repo.attach(_Repo)
    const _wallet = owner.address
    const _repoAddress = repo.address
    const _message = 'commit some code'
    const _author = 'David J Kamer'
    const _date = 'Wed Aug 30 19:39:21 2023 -0400'
    const Commit = await ethers.getContractFactory('Commit')
    const commit = await Commit.deploy(_wallet, _repoAddress, _message, _author, _date)
    await commit.deployed()
    const data = await commit.getData()
    /*
  {
    data: [
      '0x94C9A8da2BA31F56beED7119Cf7CB58d3f139DBc',
      'test message',
      'David J Kamer',
      '20230830',
      wallet: '0x94C9A8da2BA31F56beED7119Cf7CB58d3f139DBc',
      message: 'test message',
      author: 'David J Kamer',
      date: '20230830'
    ]
  }
  */
    const { wallet, message, author, date } = data
    assert.equal(_wallet, wallet, 'wallets match')
    assert.equal(_message, message, 'messages match')
    assert.equal(_author, author, 'authors match') 
    assert.equal(_date, date, 'dates match')
  })
  it('commit creator address is public', async () => {
    const Commit = await ethers.getContractFactory('Commit')
    const commit = await Commit.attach(_Commit)
    const creator = await commit.creator()
    assert.equal(creator.length, 42, 'the creator address is not empty')
  })
  it('private vars have not changed', async () => {
    const Commit = await ethers.getContractFactory('Commit')
    const commit = await Commit.attach(_Commit)
    //uint private hashTime;
    //bytes private hash;
    //Data private data;
    try {
      await commit.hashTime()
    } catch(e) {
      assert.equal(e.toString().split('\n')[0], 'TypeError: commit.hashTime is not a function', 'hashTime var is private')
    }
    try {
      await commit.hash()
    } catch(e) {
      assert.equal(e.toString().split('\n')[0], 'TypeError: commit.hash is not a function', 'hash var is private')
    }
    try {
      await commit.data()
    } catch(e) {
      assert.equal(e.toString().split('\n')[0], 'TypeError: commit.data is not a function', 'data var is private')
    }
  })
  it('approves balance for account 0 for commit', async () => {
    const [owner, buyer] = await ethers.getSigners()
    const _allowance = 200
    const Commit = await ethers.getContractFactory('Commit')
    const commit = await Commit.attach(_Commit)  
    const gitarg = await ethers.getContractFactory('gitarg')
    const arg = await gitarg.attach(_arg)
    await arg.transfer(commit.address, _allowance)//99
    const balance = await arg.balanceOf(commit.address)
    console.log({ balance })
    //function approve(address _spender, uint256 _value) public returns (bool success)
    //function approve(address _gitarg, address _wallet) public auth
    await commit.approve(arg.address, commit.address)
    const allowance = await arg.allowance(commit.address, commit.address)
    console.log({ allowance: allowance * 1 })
    assert.equal(allowance, _allowance, "the allowance set through the commit matches the balance")
    await commit.approve(arg.address, owner.address)
    const allowance_ = await arg.allowance(commit.address, owner.address)
    assert.equal(allowance_, _allowance, "the allowance for accounts 0 is the value of the commit")
    const allowance__ = await arg.allowance(commit.address, buyer.address)
    assert.equal(allowance__, 0, "the allowance for accounts 1 is 0 absent approval")
    await commit.approve(arg.address, buyer.address)
    const allowance___ = await arg.allowance(commit.address, buyer.address)
    assert.equal(allowance___, _allowance, "the allowance is updated for account 1 in addition")
  })
})
