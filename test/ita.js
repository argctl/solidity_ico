const assert = require('node:assert')
let _ita
let _arg
describe('ita', () => {
  it('creates ita wallet with constructor arguments', async () => {
    const [owner, buyer, spender, holder, trader, user] = await ethers.getSigners()
    const accounts = [owner, buyer, spender, holder, user].map(({ address }) => address)
    const ita = await ethers.deployContract('ita', [accounts])
    _ita = ita.address
    assert.equal(await ita.creation() > 0, true, "the creation timestamp with length var are created")
  }) 
  it('allows transfer from one of the owners', async () => {
    const [owner, buyer, spender, holder, trader, user] = await ethers.getSigners()
    const accounts = [owner, buyer, spender, holder, user].map(({ address }) => address)
    const arg = await ethers.deployContract('gitarg')
    _arg = arg.address
    const ITA = await ethers.getContractFactory('ita')
    const ita = await ITA.attach(_ita)
    await ita.connect(owner).allow(arg.address, 100)
    assert.equal(await arg.allowance(ita.address, owner.address), 100, "allowance updated through ita")
  })
  it('successfully transfers from with generic approve interface', async () => {
    const [owner, buyer, spender, holder, trader, user] = await ethers.getSigners()
    const ITA = await ethers.getContractFactory('ita')
    const ita = await ITA.attach(_ita)
    const gitarg = await ethers.getContractFactory('gitarg')
    const arg = await gitarg.attach(_arg)
    //await ita.connect(user).allow(_arg, 100)
    await arg.connect(owner).transfer(_ita, 100)
    await arg.connect(owner).transferFrom(_ita, user.address, 100)
  })
})
