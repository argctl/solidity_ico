const rig = artifacts.require('rig.sol')

contract('rig', (accounts) => {
    it('qualifies a gitar contract user purchase', async () => {
        const r = await rig.deployed()
        const buffer = await r.port(100, 1)
        console.log({ buffer })
        console.log('receipt1: ', buffer.receipt.logs )
        console.log('receipt0: ', buffer.receipt.logs.args)
        console.log('receipt: ', buffer.receipt.logs.args[0] * 1)

    })
})