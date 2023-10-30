const gitar = artifacts.require('gitar')
const gitarg = artifacts.require('gitarg')

contract('gitar', accounts => {
  it('g', async () => {
    //function g (uint tar) public returns (bool) {
    const tar = await gitar.deployed()
    const arg = await gitarg.deployed()
    const balance = await arg.balanceOf(accounts[0])
    await arg.approve(tar.address, 200)
    console.log({ balance })
    const allowance = await arg.allowance(accounts[0], tar.address)
    console.log({ allowance })
    await tar.g(100, { value: 100000 * 100 })
    //TODO - review price calc return
  })
  //gitarg private Gitarg;
  it('access addresses', async () => {
    //address public owner;
    //address public _gitarg;
    const tar = await gitar.deployed()
    const arg = await gitarg.deployed()
    const owner = await tar.owner()
    assert.equal(owner, accounts[0], "owner is available for review")
    const _gitarg = await tar._gitarg()
    assert.equal(_gitarg, arg.address, "arg address set for review")
  })
  it('access pricing', async () => {
    //uint public price;
    //uint public threshold;
    const tar = await gitar.deployed()
    const price = await tar.price()
    assert.equal(price, 100000, "price is available for review")
    const threshold = await tar.threshold()
    assert.equal(threshold, 10000000000, "threhsold is available for review")
  })
  it('access locking', async () => {
    //bool public safe = false;
    //bool public locked = false;
    const tar = await gitar.deployed()
    const safe = await tar.safe()
    assert.equal(safe, true, "safe is set to true by accurate threshold")
    const locked = await tar.locked()
    assert.equal(locked, false, "locked check prevents gas leak")
  })
})
