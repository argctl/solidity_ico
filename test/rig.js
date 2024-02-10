const rig = artifacts.require('rig.sol')

contract('rig', (accounts) => {
    it('qualifies a gitar contract user purchase', async () => {
        const r = await rig.deployed()
        const buffer = await r.port(100, 100)
        console.log({ buffer })
    })
})