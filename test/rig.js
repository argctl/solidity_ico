const rig = artifacts.require('rig.sol')
const gitar = artifacts.require('gitar.sol')
const { logs } = require('./utils')

contract('rig', (accounts) => {
    it('qualifies a gitar contract user purchase', async () => {
        const r = await rig.deployed()
        const gt = await gitar.deployed()
        let error
        try {
          // TODO - check if gt has purchase record in test for value in r.port
          const buffer = await r.port(100, 10000, { from: accounts[1] })
        } catch (e) {
          error = e
          console.log({ e })
        }
        assert.equal(error.reason, "treasure chest", "Not gitar tracked sale fails")
        /*
        console.log('receipt1: ', buffer.receipt.logs[0] )
        console.log('receipt0: ', buffer.receipt.logs[0].args)
        console.log('receipt: ', buffer.receipt.logs[0].args[0] * 1)
        console.log('logs: ', logs(buffer))
        console.log('logsNumbered: ', logs(buffer).map(n => n * 1))
        */

    })
})
