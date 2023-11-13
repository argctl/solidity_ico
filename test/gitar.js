const gitar = artifacts.require('gitar')
const gitarg = artifacts.require('gitarg')
const { wait } = require('./utils')

contract('gitar', accounts => {
  it('g', async () => {
    //function g (uint tar) public returns (bool) {
    const tar = await gitar.deployed()
    const arg = await gitarg.deployed()
    const balance = await arg.balanceOf(accounts[0])
    await arg.approve(tar.address, 200)
    const allowance = await arg.allowance(accounts[0], tar.address)
    const _git = await arg.balanceOf(accounts[5])
    const eth = await web3.eth.getBalance(accounts[0])
    const value = 100000 * 100
    const { receipt } = await tar.g(100, { value, from: accounts[5] })
    const { cumulativeGasUsed } = receipt
    const git = await arg.balanceOf(accounts[5])
    await wait(2000)
    const eth_ = await web3.eth.getBalance(accounts[0])
    const transfer = eth_ - eth
    assert.isBelow(Math.abs(transfer - value), cumulativeGasUsed, "change to less than cumulativeGas")
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
