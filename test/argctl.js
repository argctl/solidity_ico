const assert = require('node:assert')
const { wait } = require('./utils')

let _handshakes_
let _arg
let _eta
let gitorg
let _array
let _ctl

describe('argctl', () => {
  it('can add repo', async () => {
    //function repo(address[] memory _handshakes, string memory _name, string memory _url, address _argctl) public returns(address) {
    // TODO -  review get handshakes from handshakes object good or security issue?
    //function repo(address[] memory _handshakes, string memory _name, string memory _url, address _argctl) public returns(address) {
    const org = await ethers.deployContract('gitorg')
    gitorg = org.address
    const [owner, buyer, spender, holder, trader, user] = await ethers.getSigners()
    const handshakes = [buyer, spender, holder, trader, user].map(({ address }) => address)
    
    //const handshakes = await deployer.deploy(Handshakes, accounts.slice(1), accounts[0], 3, true)
    const _handshakes = await ethers.deployContract('Handshakes', [handshakes, owner.address, 3, true])
    _handshakes_ = _handshakes.address
    //await deployer.deploy(gitarray, accounts.slice(1), accounts[0], arg.address, eta.address)
    const arg = await ethers.deployContract('gitarg')
    _arg = arg.address
    const eta = await ethers.deployContract('giteta', [arg.address])
    _eta = eta.address
    const array = await ethers.deployContract('gitarray', [handshakes, owner.address, arg.address, eta.address], { libraries: { gitorg } })
    _array = array.address
    //const ctl = await deployer.deploy(argctl, handshakes.address, org.address, arg.address, array.address, eta.address)
    const ctl = await ethers.deployContract('argctl', [_handshakes.address, org.address, arg.address, array.address, eta.address], { libraries: { gitorg } })
    _ctl = ctl.address
    //await _handshakes.add(ctl.address)
    await _handshakes.connect(user).add(array.address)
    await _handshakes.connect(trader).add(ctl.address)
    handshakes.push(ctl.address)
    handshakes.push(array.address)
  /*
    console.log({ handshakes })
    handshakes.forEach(async handshake => {
      console.log({ handshake })
      console.log('here: ', await _handshakes.handshakes(handshake))
    })
  */
    
    //console.log({ handshakes })
    /*
    await new Promise((resolve, reject) => {
      setTimeout(() => {
        resolve()
      }, 5000) 
    })
    console.log('ctl: ', ctl.address)
    console.log({ handshakes })
    console.log('has value: ', handshakes.includes(spender.address))
    console.log('has value: ', handshakes.includes(ctl.address))
    */
    let error
    try {
      // i hAvE tHe rEaL aDDreSS
      // the solution is either reveal it in an emit or keep it secret to reduce higher level fraud
      const _repo = await array.connect(spender)['repo()']() // not returning
      
    } catch (e) {
      error = e
    }
    //console.log({ error: error.toString() })
    //assert.throws(await array.repo({ from: accounts[2] }), "VM Exception while processing transaction: revert", "reverts from lack of repo assigned to address")
    assert.equal(error.toString().includes('Error: call revert exception'), true, "reverts from lack of repo assigned to address")
    //VM Exception while processing transaction: revert
    //assert.equal(error.message, "VM Exception while processing transaction: revert", "reverts from lack of repo assigned to address")
    //function repo(address[] memory _handshakes, string memory _name, string memory _url, address _argctl) public returns (address) {
    console.log('here')
    const receipt = await ctl.connect(spender).repo(handshakes, "gitarg_eth_ico", "gitlab.com:me2211/gitarg_eth_ico.git", ctl.address)
    console.log({ receipt })
    const repo_ = await array.connect(spender)['repo()']()
    assert.equal(repo_.length, 42, "repo address returned after creation")
  })

  
  it('can commit', async () => {
    const [owner, buyer, spender] = await ethers.getSigners()

    const gitarg = await ethers.getContractFactory('gitarg')
    const arg = await gitarg.attach(_arg)
    const argctl = await ethers.getContractFactory('argctl', { libraries: { gitorg } })
    const ctl = await argctl.attach(_ctl)
    const gitarray = await ethers.getContractFactory('gitarray', { libraries: { gitorg } })
    const array = await gitarray.attach(_array)
    const giteta = await ethers.getContractFactory('giteta')
    const eta = await giteta.attach(_eta)

    //array.
    //const _repo = await repo.deployed()
    //const handshakes = await Handshakes.deployed()
    /*
    commit 84227419a8d956aa5f5ccfd27286705e202243fe
    Author: David Kamer <me@davidkamer.com>
    Date:   Sun Oct 1 03:40:44 2023 -0400

    untyped proposal
    */
    
    //function add(address handshake) public own stop returns (uint) {

    //await handshakes.add(ctl.address)
    //const handshakes = await Handshakes.at(_repo.address)
    //const isHandshake = await handshakes.isHandshake({ from: ctl.address })
    //const isHandshake_ = await handshakes.isHandshake({ from: accounts[1] })
    //console.log({ isHandshake, isHandshake_ })
    //function commit(address _repo, string memory _message, string memory _author, string memory _date) public returns(uint) {
    /*
    await arg.transfer(ctl.address, 100, { from: accounts[0] })
    const balance = await arg.balanceOf(ctl.address)
    console.log({ balance })
    await wait(2000)
    const vv = await ctl.v.call({ value: 1 })
    console.log({ vv })
    //const xx = await ctl.x.call()
    //console.log({ xx })

    */
    //const repo_ = await array.connect(spender)['repo()']()
    const repo_ = await array.connect(spender)['repo()']()
    // TODO - review this causes the problem too, causes revert from accounts[0] which should not have a balance issue.
    //await eta.commit(repo_, 'untyped proposal', 'David Kamer <me@davidkamer.com>', 'Sun Oct 1 03:40:44 2023 -0400', 10)
    //console.log({ repo_ })
    const _balance_ = (await arg.balanceOf(ctl.address)) * 1
    //console.log({ _balance_ })
    await arg.transfer(ctl.address, 1)
    const balance2 = (await arg.balanceOf(ctl.address)) * 1
    //console.log({ balance2 })
    const commitReceipt = await ctl.connect(spender).commit(eta.address, repo_, 'untyped proposal', 'David Kamer <me@davidkamer.com>', 'Sun Oct 1 03:40:44 2023 -0400', { value: 1 })
    //console.log('allowance for eta from ctl: ', (await arg.allowance(ctl.address, eta.address)) * 1)
    /*
    */
    //console.log({ commitReceipt })
    //console.log(commitReceipt.logs)

  })


  //function checkin (address repo, address handshakes) public {
  it('checkin times', async () => {
    console.log('placeholder')
  })
  //function proof () public view returns (address) {
  it('proof provides', async () => {
    console.log('placeholder')
  })
})
