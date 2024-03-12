const assert = require('node:assert')
describe('ratig', () => {
  //function g (uint amount, address _erc20, address _to) public returns (bool) {
  it('transfers amount with a valid address from purchase', async () => {
    const [owner, buyer, spender, account3, account4, account5, account6] = await ethers.getSigners()
    const gitarg = await ethers.getContractFactory('gitarg')
    const arg = await ethers.deployContract('gitarg')
    //const tar = await deployer.deploy(gitar, arg.address, 100000, 10000000000, 2, { from: accounts[0] })
    const tar = await ethers.deployContract('gitar', [arg.address, 100000, 10000000000, 2])
    //await deployer.deploy(ratig, arg.address, tar.address)
    const rat = await ethers.deployContract('ratig', [arg.address, tar.address])
    const farg = await gitarg.connect(account6).deploy()
    //function approve(address _spender, uint256 _value) public returns (bool success) {
    await arg.connect(account5).approve(rat.address, 100)
    await arg.connect(owner).approve(tar.address, 100)
    //await arg.approve(accounts[5], 100, { from: accounts[0] })
    const value = 100000 * 100
    await tar.connect(account5).g(100, { value })
    await farg.connect(account6).approve(rat.address, 100)
    //function g (uint amount, address _erc20, address _to) public returns (bool) {
    const { receipt } = await rat.connect(account5).g(100, farg.address, account6.address) 
    const balance = await farg.balanceOf(account5.address)
    assert.equal(balance * 1, 100, "the balance in the address of the second token is the transfer amount")
  })
  //address public owner;
  it('owner', async () => {
    const [owner] = await ethers.getSigners()
    const arg = await ethers.deployContract('gitarg')
    const tar = await ethers.deployContract('gitar', [arg.address, 100000, 10000000000, 2])
    const rat = await ethers.deployContract('ratig', [arg.address, tar.address])
    const _owner = await rat.owner()
    assert.equal(owner.address, _owner, "owner access modifier")
  })
  it('gg', async () => {
    const [owner] = await ethers.getSigners()
    const arg = await ethers.deployContract('gitarg')
    const tar = await ethers.deployContract('gitar', [arg.address, 100000, 10000000000, 2])
    const gg = await tar.gg(owner.address)
    // TODO - test if runner is linked execution on the blockchain with env
    assert.equal(gg, process.env.LINKED === 'true' ? 100 : 0, "runner linked execution out of order or assimilation required")
  })
  //address public GITARG;
  it('GITARG', async () => {
    const arg = await ethers.deployContract('gitarg')
    const tar = await ethers.deployContract('gitar', [arg.address, 100000, 10000000000, 2])
    const rat = await ethers.deployContract('ratig', [arg.address, tar.address])
    const GITARG = await rat.GITARG()
    assert.equal(GITARG, arg.address, "GITARG access modifier")
  })
  //address public GITAR;
  it('GITAR', async () => {
    const arg = await ethers.deployContract('gitarg')
    const tar = await ethers.deployContract('gitar', [arg.address, 100000, 10000000000, 2])
    const rat = await ethers.deployContract('ratig', [arg.address, tar.address])
    const GITAR = await rat.GITAR()
    assert.equal(GITAR, tar.address, "GITAR access modifier")
  })
})
