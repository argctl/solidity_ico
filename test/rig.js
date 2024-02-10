const rig = artifacts.require('rig.sol')
const { logs } = require('./utils')

contract('rig', (accounts) => {
    it('qualifies a gitar contract user purchase', async () => {
        const r = await rig.deployed()
        const buffer = await r.port(100, 1)
        console.log({ buffer })
        console.log('receipt1: ', buffer.receipt.logs[0] )
        console.log('receipt0: ', buffer.receipt.logs[0].args)
        console.log('receipt: ', buffer.receipt.logs[0].args[0] * 1)
        console.log('logs: ', logs(buffer))
        console.log('logsNumbered: ', logs(buffer).map(n => n * 1))

    })
})