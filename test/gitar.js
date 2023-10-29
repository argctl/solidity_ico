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
})
