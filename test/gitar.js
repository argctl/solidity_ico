const assert = require('node:assert')
const { wait } = require('./utils')

let _tar
let _arg
describe('gitar', () => {
  it('g', async () => {
    //function g (uint tar) public returns (bool) {
    //const tar = await deployer.deploy(gitar, arg.address, 100000, 10000000000, 2, { from: accounts[0] })
    const [owner, buyer, spender, holder, trader, user] = await ethers.getSigners()
    const arg = await ethers.deployContract('gitarg')
    _arg = arg.address
    const tar = await ethers.deployContract('gitar', [arg.address, 100000, 10000000000, 2])
    _tar = tar.address
    const balance = await arg.balanceOf(owner.address)
    await arg.approve(tar.address, 200)
    const allowance = await arg.allowance(owner.address, tar.address)
    const _git = await arg.balanceOf(user.address)
    const eth = await owner.getBalance()
    const value = 100000 * 100
    const receipt = await (await tar.connect(user).g(100, { value })).wait()
    const { cumulativeGasUsed } = receipt
    const git = await arg.balanceOf(user.address)
    await wait(2000)
    const eth_ = await owner.getBalance()
    const transfer = eth_ - eth
    console.log({ cumulativeGasUsed, diff: Math.abs(transfer - value) })
    //485760
    //assert.equal(Math.abs(transfer - value) < cumulativeGasUsed, true, "The transfer value is within range of value")
    assert.equal(Math.abs(transfer - value) < cumulativeGasUsed, false, "The transfer reduces the value of transaction")
    assert.equal(200000 > cumulativeGasUsed, true, "the gas price doesn't make negative transfers invisible by number")
    //TODO - review price calc return
  })
  it('gg', async () => {
    const [owner, buyer, spender, holder, trader, user] = await ethers.getSigners()
    const gitar = await ethers.getContractFactory('gitar')
    const tar = await gitar.attach(_tar)
    const value = 100000 * 100
    await tar.connect(owner).g(100, { value })
    const gg = await tar.gg(owner.address)
    const prev = await tar.gg(user.address)
    assert.equal(prev, 100, "value from previous call to g function")
    assert.equal(gg, 100, "value bought equality")
  })
  //gitarg private Gitarg;
  it('access addresses', async () => {
    //address public owner;
    //address public _gitarg;
    const [owner] = await ethers.getSigners()
    const gitar = await ethers.getContractFactory('gitar')
    const tar = await gitar.attach(_tar)
    const gitarg = await ethers.getContractFactory('gitarg')
    const arg = await gitarg.attach(_arg)
    const _owner = await tar.owner()
    assert.equal(_owner, owner.address, "owner is available for review")
    const _gitarg = await tar._gitarg()
    assert.equal(_gitarg, arg.address, "arg address set for review")
  })
  it('access pricing', async () => {
    //uint public price;
    //uint public threshold;
    const gitar = await ethers.getContractFactory('gitar')
    const tar = await gitar.attach(_tar)
    const price = await tar.price()
    assert.equal(price, 100000, "price is available for review")
    const threshold = await tar.threshold()
    assert.equal(threshold, 10000000000, "threhsold is available for review")
  })
  it('gg', async () => {
    const [owner, buyer, spender, holder, trader, user] = await ethers.getSigners()
    const gitar = await ethers.getContractFactory('gitar')
    const tar = await gitar.attach(_tar) 
    const amount = await tar.gg(user.address)
    assert.equal(amount, 100, "gg returns the value of an account")
  })
  it('access locking', async () => {
    //bool public safe = false;
    //bool public locked = false;
    const gitar = await ethers.getContractFactory('gitar')
    const tar = await gitar.attach(_tar)
    const safe = await tar.safe()
    assert.equal(safe, true, "safe is set to true by accurate threshold")
    const locked = await tar.locked()
    assert.equal(locked, false, "locked check prevents gas leak")
  })
  //function gg (address _purchaser) public returns (uint) {
  
})
