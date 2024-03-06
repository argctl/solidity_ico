const gitarg = artifacts.require('gitarg')
const rig = artifacts.require('rig')
const gitar = artifacts.require('gitar')
const b = artifacts.require('b')
const bs = artifacts.require('bs')
const { logs, wait } = require('./utils')

contract('rig', accounts => {
    it('gitar is not a special child in another land', async () => {
      const tar = await gitar.deployed()
      const arg = await gitarg.deployed()
      const balance = await arg.balanceOf(accounts[0])
      await arg.approve(tar.address, 200)
      const allowance = await arg.allowance(accounts[0], tar.address)
      const _git = await arg.balanceOf(accounts[5])
      //const eth = await web3.eth.getBalance(accounts[0])
      const value = 100000 * 100
      const { receipt } = await tar.g(100, { value, from: accounts[5] })
      /*
      const git = await arg.balanceOf(accounts[5])
      await wait(2000)
      const eth_ = await web3.eth.getBalance(accounts[0])
      const transfer = eth_ - eth
      assert.isBelow(Math.abs(transfer - value), cumulativeGasUsed, "The transfer value is within range of value")
      console.log({ cumulativeGasUsed })
      assert.isAbove(200000, cumulativeGasUsed, "the gas price doesn't make negative transfers invisible by number")
      */
    //TODO - review price calc return
    })
    it('qualifies a gitar contract user purchase', async () => {
        //constructor (address _gitarg, uint _buy, uint _sell) {
        const g = await rig.new((await gitarg.deployed()).address, 90000, 100000)
        const r = await rig.deployed()
        const tar = await gitar.at(await g.gitar_())
        //const tar = await gitar.deployed()
        const arg = await gitarg.at(await g.gitarg_())
        const tokens = 100
        const price = await tar.price()
        await tar.g(tokens, { value: price * tokens, from: accounts[5] })
        /*
        assert.equal(amount * 1, 100, "amount from gitar contract is amount purchased")
        let error
        try {
          const buffer = await r.port(100, 10000, { from: accounts[1] })
        } catch (e) {
          error = e
        }
        assert.equal(error.reason, "treasure chest", "Not gitar tracked sale fails")
        const stiphen = 12500
        const receipt = await r.port(100, stiphen, { from: accounts[5], value: Math.pow(stiphen, 2), gas: 60000 })
        */
        /*
        console.log('receipt1: ', buffer.receipt.logs[0] )
        console.log('receipt0: ', buffer.receipt.logs[0].args)
        console.log('receipt: ', buffer.receipt.logs[0].args[0] * 1)
        console.log('logs: ', logs(buffer))
        console.log('logsNumbered: ', logs(buffer).map(n => n * 1))
        */

    })
})
