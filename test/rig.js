artifacts.require('rig.sol')

contract('rig', (accounts) => {
    it('qualifies a gitar contract user purchase', async () => {
        const rig = await deployer.deployed('rig')
        const buffer = await rig.port(100, 100)
        console.log({ buffer })
    })
})