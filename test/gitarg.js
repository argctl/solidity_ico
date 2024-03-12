const assert = require('node:assert')

describe('gitarg', () => {
  it('allows name retreival', async function () {
    const ico = await ethers.deployContract('gitarg')
    const name = await ico.name()
    assert.equal(name, 'gitarg', 'name matches set on token')
  })
  it('satisfies initial balance conditions', async () => {
    const [owner] = await ethers.getSigners()
    const ico = await ethers.deployContract('gitarg')
    const balance = await ico.balanceOf(owner.address);
    assert.equal(Number(balance) > 0, true, 'balance greater than 0')
    assert.equal(Number(balance), Number(1e+21), 'balance is equal to starting balance')
    })
  it('has total supply equals 1000000000000000000000', async () => {
    const totalSupply_ = 1000000000000000000000
    const ico = await ethers.deployContract('gitarg')
    const totalSupply = await ico.totalSupply.call()
    assert.equal(totalSupply, totalSupply_, 'the total supply is equal to the supply in js')
  })
  it('transfers value to the address', async () => {
    const ico = await ethers.deployContract('gitarg')
    const [owner, buyer] = await ethers.getSigners()
    const tokens = 100000
    await ico.transfer(buyer.address, tokens, { from: owner.address })
    const tokens_ = await ico.balanceOf(buyer.address)
    assert.equal(tokens, tokens_, 'the tokens transferred equal the tokens in the account')
  })
  /*
  it('trasfers from address to address', async () => {
  //function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
    const tokens = 100000
    const ico = await gitarg.deployed()
    const tokens_ = await ico.transferFrom(accounts[0], accounts[2], tokens, { from: accounts[0] })
    // FAILS without "or" condition 
    assert.equal(tokens, tokens_, 'transfer from works from address without allowance')
  })
  */
  // TODO - review the logic of spender
  it('trasfers from address to address', async () => {
    const tokens = 100000
    const ico = await ethers.deployContract('gitarg')
    const [owner, buyer, spender] = await ethers.getSigners()
    await ico.connect(owner).approve(spender.address, tokens) 
    const allowance = await ico.allowance(owner.address, spender.address)
    assert.equal(allowance, tokens, 'allowance equals amount of approval')
    await ico.connect(spender).transferFrom(owner.address, spender.address, tokens)
    const balance = await ico.balanceOf(spender.address)
    assert.deepEqual(allowance, balance, 'transfer from works from address with allowance')
    assert.equal(tokens, balance * 1, 'transfer from works from address with allowance')
  })
  it('locks address', async () => {
    const ico = await ethers.deployContract('gitarg')
    const [owner, buyer, spender] = await ethers.getSigners()
    await ico.connect(buyer).lock()
    let error
    try {
      const balance = await ico.balanceOf(buyer.address)
    } catch (e) {
      error = e.toString().split('\n')[0] 
      // TODO - use e.reason
    }
    assert.equal(error, 'Error: call revert exception [ See: https://links.ethers.org/v5-errors-CALL_EXCEPTION ] (method="balanceOf(address)", data="0x", errorArgs=null, errorName=null, errorSignature=null, reason=null, code=CALL_EXCEPTION, version=abi/5.7.0)', 'error thrown on locked account')
  })
  it('unlock address', async () => {
    const ico = await ethers.deployContract('gitarg')
    const [owner, buyer, spender] = await ethers.getSigners()
    await ico.transfer(buyer.address, 100, { from: owner.address })
    await ico.connect(buyer).lock()
    await ico.connect(buyer).unlock()
    const balance = await ico.balanceOf(buyer.address)
    assert.equal(balance, 100, 'unlock allows function call with lock functionality')
  })
})
