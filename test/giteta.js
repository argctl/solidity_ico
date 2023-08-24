const giteta = artifacts.require('giteta')
const gitarg = artifacts.require('gitarg')
const { wait } = require('./utils')

contract('giteta', async accounts => {
  it('arg address matches', async () => {
    const arg = await gitarg.deployed()
    const eta = await giteta.new(arg.address)
    await wait(4000)
    //const _arg = console.log(eta)
    const _arg = await eta.Gitarg.call()
    assert.equal(arg.address, _arg, "addresses match from deployed contract and giteta instance")
  })
})
