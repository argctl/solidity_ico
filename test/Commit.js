describe('Commit', accounts => {
  it('can create a commit independent of repo', async () => {
  //constructor(address _wallet, address _repo, string memory _message, string memory _author, string memory _date) {
    const repo = await Repo.deployed()
    // REVIEW - should change repo.address to repo type check? - standards review
    const commit = new Commit(accounts[0], repo.address, 'commit some code', 'David J Kamer', 'Wed Aug 30 19:39:21 2023 -0400')
    console.log('length: ', commit.address.length)
    assert.equal(commit.address.length, 42, 'commit address exists for new commit')
  })
  it('can set code hash', async () => {
    const repo = await Repo.deployed()
    const commit = await Commit.deployed()
    //function setCodeHash(bytes memory _hash) public returns (uint) {
    const hash = '5128102a5cdb583423882b64b91688193bbf049d'
    const bytes = web3.utils.hexToBytes(web3.utils.asciiToHex(hash))
    const hash_ = web3.utils.hexToAscii(web3.utils.bytesToHex(bytes))
    console.log({ hash, hash_ })
    assert.equal(hash, hash_, 'bytes is accurate after conversion')
    console.log({ bytes })
    await commit.setCodeHash(bytes)
  })
  it('can get data', async () => {
    //const commit = await Commit.deployed()
    const repo = await Repo.deployed()
    const _wallet = accounts[0]
    const _repoAddress = repo.address
    const _message = 'commit some code'
    const _author = 'David J Kamer'
    const _date = 'Wed Aug 30 19:39:21 2023 -0400'
    const commit = await Commit.new(_wallet, _repoAddress, _message, _author, _date)
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
    const commit = await Commit.deployed() 
    const creator = await commit.creator()
    assert.equal(creator.length, 42, 'the creator address is not empty')
  })
  it('private vars have not changed', async () => {
    const commit = await Commit.deployed()
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
    const _allowance = 200
    const commit = await Commit.deployed()  
    const arg = await gitarg.deployed()
    await arg.transfer(commit.address, _allowance)//99
    const balance = await arg.balanceOf.call(commit.address)
    console.log({ balance })
    //function approve(address _spender, uint256 _value) public returns (bool success)
    //function approve(address _gitarg, address _wallet) public auth
    await commit.approve(arg.address, commit.address)
    const allowance = await arg.allowance.call(commit.address, commit.address)
    console.log({ allowance: allowance * 1 })
    assert.equal(allowance, _allowance, "the allowance set through the commit matches the balance")
    await commit.approve(arg.address, accounts[0])
    const allowance_ = await arg.allowance.call(commit.address, accounts[0])
    assert.equal(allowance_, _allowance, "the allowance for accounts 0 is the value of the commit")
    const allowance__ = await arg.allowance.call(commit.address, accounts[1])
    assert.equal(allowance__, 0, "the allowance for accounts 1 is 0 absent approval")
    await commit.approve(arg.address, accounts[1])
    const allowance___ = await arg.allowance.call(commit.address, accounts[1])
    assert.equal(allowance___, _allowance, "the allowance is updated for account 1 in addition")
  })
})
