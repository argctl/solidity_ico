const gitarg = artifacts.require('gitarg')
const rig = artifacts.require('rig')
const gitar = artifacts.require('gitar')
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
        const r = await rig.deployed()
        const tar = await gitar.deployed()
        const arg = await gitarg.deployed()
        const tokens = 100
        const cost = 100000
        //arg.approve(tar.address, 200)
        //await tar.g(tokens, { value: cost * tokens, from: accounts[5] })
        // for whatever reason this doesn't work between test groupings (contract tests), could adding time or checking order explain?
        const amount = await tar.gg(accounts[5])
        //const amount = await tar.gg(accounts[5])
        console.log({ amount: amount * 1 })
        assert.equal(amount * 1, 100, "amount from gitar contract is amount purchased")
        let error
        try {
          // TODO - check if gt has purchase record in test for value in r.port
          const buffer = await r.port(100, 10000, { from: accounts[1] })
        } catch (e) {
          error = e
        }
        assert.equal(error.reason, "treasure chest", "Not gitar tracked sale fails")
        //const stiphen = 55000
        const stiphen = 12500
        const receipt = await r.port(100, stiphen, { from: accounts[5], value: Math.pow(stiphen, 2), gas: 60000 })
        const buffer = await r.buffer(accounts[5])
        console.log({ buffer: buffer * 1 }) 
        console.log({ receipt })
        //const buffer = await r.port(99, 10000, { from: accounts[1] })
        /*
        console.log('receipt1: ', buffer.receipt.logs[0] )
        console.log('receipt0: ', buffer.receipt.logs[0].args)
        console.log('receipt: ', buffer.receipt.logs[0].args[0] * 1)
        console.log('logs: ', logs(buffer))
        console.log('logsNumbered: ', logs(buffer).map(n => n * 1))
        */

    })
})
