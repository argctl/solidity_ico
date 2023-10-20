const argctl = artifacts.require('argctl')
const repo = artifacts.require('repo')
const Handshakes = artifacts.require('Handshakes')

contract('argctl', (accounts) => {
  it('can add repo', async () => {
  })
  it('can commit', async () => {
    const ctl = await argctl.deployed()
    const _repo = await repo.deployed()
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
    const commitReceipt = await ctl.commit(_repo.address, 'untyped proposal', 'David Kamer <me@davidkamer.com>', 'Sun Oct 1 03:40:44 2023 -0400', { from: accounts[1] })
    console.log({ commitReceipt })

  })
  //function checkin (address repo, address handshakes) public {
  it('checkin times', async () => {

  })
  //function proof () public view returns (address) {
  it('proof provides', async () => {

  })
})
