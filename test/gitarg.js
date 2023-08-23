const gitarg = artifacts.require('gitarg')

const wait = async ms => {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve() 
    }, ms)
  })
}

contract('gitarg', accounts => {
  it('allows name retreival', async () => {
    const ico = await gitarg.deployed() 
    const name = await ico.name()
    assert.equal(name, 'gitarg', 'name matches set on token')
  })
  it('satisfies initial balance conditions', async () => {
    const ico = await gitarg.deployed()
    const balance = await ico.balanceOf.call(accounts[0])
    assert.isAbove(Number(balance), 0, 'balance greater than 0')
    assert.equal(Number(balance), Number(1e+21), 'balance is equal to starting balance')
  })
  it('has total supply equals 1000000000000000000000', async () => {
    const totalSupply_ = 1000000000000000000000
    const ico = await gitarg.deployed()
    const totalSupply = await ico.totalSupply.call()
    assert.equal(totalSupply, totalSupply_, 'the total supply is equal to the supply in js')
  })
  it('transfers value to the address', async () => {
    const ico = await gitarg.deployed()
    const tokens = 100000
    await ico.transfer(accounts[1], tokens)
    await wait(1000)
    const tokens_ = await ico.balanceOf.call(accounts[1])
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
  it('trasfers from address to address', async () => {
    const tokens = 100000
    const ico = await gitarg.deployed()
    await ico.approve(accounts[2], tokens, { from: accounts[0] }) 
    await wait(2000)
    const allowance = await ico.allowance.call(accounts[0], accounts[2] )
    await wait(2000)
    assert.equal(allowance, tokens, 'allowance equals amount of approval')
    await ico.transferFrom(accounts[0], accounts[2], tokens, { from: accounts[2] })
    const balance = await ico.balanceOf.call(accounts[2])
    assert.equal(allowance * 1, balance * 1, 'transfer from works from address with allowance')
    assert.equal(tokens, balance * 1, 'transfer from works from address with allowance')
  })
  it('locks address', async () => {
    const ico = await gitarg.deployed()
    await ico.lock({ from: accounts[1] })
    try {
      const balance = await ico.balanceOf.call(accounts[1])
    } catch (e) {
      assert.equal(e.toString().split('\n')[0],
        'Error: VM Exception while processing transaction: revert',
        'error thrown on locked account')
    }
  })
  it('unlock address', async () => {
    const ico = await gitarg.deployed()
    await ico.unlock({ from: accounts[1] })
    const balance = await ico.balanceOf.call(accounts[1])
    assert.isAbove(balance * 1, 0, 'unlock allows function call with lock functionality')
  })
})
