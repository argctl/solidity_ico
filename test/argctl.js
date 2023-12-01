const gitarg = artifacts.require('gitarg')
const argctl = artifacts.require('argctl')
const gitarray = artifacts.require('gitarray')
const giteta = artifacts.require('giteta')
const repo = artifacts.require('Repo')
const Handshakes = artifacts.require('Handshakes')
const { wait } = require('./utils')

contract('argctl', (accounts) => {
  it('can add repo', async () => {
    //function repo(address[] memory _handshakes, string memory _name, string memory _url, address _argctl) public returns(address) {
    // TODO -  review get handshakes from handshakes object good or security issue?
    //function repo(address[] memory _handshakes, string memory _name, string memory _url, address _argctl) public returns(address) {
    const handshakes = accounts.slice(1)
    const _handshakes = await Handshakes.deployed()
    const array = await gitarray.deployed()
    const ctl = await argctl.deployed()
    //await _handshakes.add(ctl.address)
    await _handshakes.add(array.address, { from: accounts[5] })
    handshakes.push(ctl.address)
    handshakes.push(array.address)
    console.log({ handshakes })
    await new Promise((resolve, reject) => {
      setTimeout(() => {
        resolve()
      }, 5000) 
    })
    console.log('ctl: ', ctl.address)
    console.log({ handshakes })
    console.log('has value: ', handshakes.includes(accounts[2]))
    console.log('has value: ', handshakes.includes(ctl.address))
    const _repo = await ctl.repo(handshakes, "gitarg_eth_ico", "gitlab.com:me2211/gitarg_eth_ico.git", ctl.address, { from: accounts[2] })
    console.log({ _repo })
    //const array = await gitarray.deployed()
    //const b = await array.somethingdifferent({ from: accounts[3] })
    //console.log({ b })
    //console.log({ _repo, accounts2: accounts[2] })
  })

  
  it('can commit', async () => {
    const arg = await gitarg.deployed()
    const ctl = await argctl.deployed()
    const array = await gitarray.deployed()
    const eta = await giteta.deployed()

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

    const repo_ = await array.repo({ from: accounts[2] })
    // TODO - review this causes the problem too, causes revert from accounts[0] which should not have a balance issue.
    //await eta.commit(repo_, 'untyped proposal', 'David Kamer <me@davidkamer.com>', 'Sun Oct 1 03:40:44 2023 -0400', 10)
    console.log({ repo_ })
    //const commitReceipt = await ctl.commit(eta.address, repo_, 'untyped proposal', 'David Kamer <me@davidkamer.com>', 'Sun Oct 1 03:40:44 2023 -0400', { from: accounts[1], value: 1 })
    /*
    */
    //console.log({ commitReceipt })

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
