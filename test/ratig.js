const ratig = artifacts.require('ratig')
const gitar = artifacts.require('gitar')
const gitarg = artifacts.require('gitarg')

contract('ratig', accounts => {
  //function g (uint amount, address _erc20, address _to) public returns (bool) {
  it('transfers amount with a valid address from purchase', async () => {
    const arg = await gitarg.deployed()
    const rat = await ratig.deployed()
    const tar = await gitar.deployed()
    const farg = await gitarg.new({ from: accounts[6] })
    //function approve(address _spender, uint256 _value) public returns (bool success) {
    await arg.approve(rat.address, 100, { from: accounts[5] })
    await arg.approve(tar.address, 100, { from: accounts[0] })
    //await arg.approve(accounts[5], 100, { from: accounts[0] })
    const value = 100000 * 100
    await tar.g(100, { value, from: accounts[5] })
    await farg.approve(rat.address, 100, { from: accounts[6] })
    //function g (uint amount, address _erc20, address _to) public returns (bool) {
    const { receipt } = await rat.g(100, farg.address, accounts[6], { from: accounts[5] }) 
    const balance = await farg.balanceOf(accounts[5])
    assert.equal(balance, 100, "the balance in the address of the second token is the transfer amount")
  })
  //address public owner;
  it('owner', async () => {
    const rat = await ratig.deployed()
    const owner = await rat.owner()
    assert.equal(owner, accounts[0], "owner access modifier")
  })
  it('gg', async () => {
    const tar = await gitar.deployed()
    const gg = await tar.gg(accounts[0])
    // TODO - test if runner is linked execution on the blockchain with env
    assert.equal(gg, process.env.LINKED === 'true' ? 100 : 0, "runner linked execution out of order or assimilation required")
  })
  //address public GITARG;
  it('GITARG', async () => {
    const rat = await ratig.deployed()
    const arg = await gitarg.deployed()
    const GITARG = await rat.GITARG()
    assert.equal(GITARG, arg.address, "GITARG access modifier")
  })
  //address public GITAR;
  it('GITAR', async () => {
    const rat = await ratig.deployed()
    const tar = await gitar.deployed()
    const GITAR = await rat.GITAR()
    assert.equal(GITAR, tar.address, "GITAR access modifier")
  })
})
