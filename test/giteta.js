const giteta = artifacts.require('giteta')
const gitarg = artifacts.require('gitarg')
const Commit = artifacts.require('Commit')
const Repo = artifacts.require('Repo')
const { wait } = require('./utils')

let comm = ''
let _eta = ''

contract('giteta', async accounts => {
  it('arg address matches', async () => {
    const arg = await gitarg.deployed()
    const eta = await giteta.new(arg.address)
    await wait(4000)
    const _arg = await eta.Gitarg.call()
    assert.equal(arg.address, _arg, "addresses match from deployed contract and giteta instance")
  })
  it('commit creates commit object/contract', async () => {
    const arg = await gitarg.deployed()
    const repo = await Repo.deployed()
    const commit = await Commit.deployed()
    //const eta = await giteta.deployed()
    const eta = await giteta.new(arg.address)
    _eta = eta.address
    // App.js
    await arg.approve(eta.address, 200000, { from: accounts[1] })
    await arg.transfer(accounts[1], 2000)
    //Error: VM Exception while processing transaction: revert
    const receipt = await eta.commit(
      repo.address,
      'import gitarray',
      'David Kamer <me@davidkamer.com>',
      'Wed Aug 30 19:39:21 2023 -0400',
      1000, {
        from: accounts[1]
      })
    const address = receipt.logs[0].args.commit
    comm = address
    const balance = await arg.balanceOf.call(address)
    assert.equal(balance, 999, "balance is moved to commit")
  })
  it('up function adds value', async () => {
    const arg = await gitarg.deployed()
    const eta = await giteta.at(_eta)
    const repo = await Repo.deployed()
  /*
    const com = await Commit.at(comm)
    await arg.transfer(accounts[1], 3000)
    await wait(3000)
    const creator = await com.creator()
    const data = await com.getData.call({ from: accounts[1] })
    assert.equal(comm, com.address, "commit is same as at address")
    assert.equal(data.author, 'David Kamer <me@davidkamer.com>', "commit data is populated")
    await eta.up(com.address, false, { from: accounts[1] })
    await wait(4000)
    const value = await eta.value.call(com.address)
    assert.isAtLeast(value * 1, 1000, "The value is at least 1000 after the up function call") 
    */
    //const balance = await arg.balanceOf.call(accounts[1])
    //console.log({ balance })
    //function commit(address _repo, string memory message, string memory author, string memory date, uint escrow) public returns (uint) {
    const com_ = await eta.commit(repo.address, 'direct functions', 'David Kamer <me@davidkamer.com>', 'Fri Sep 8 00:09:57 2023 -0400', 5, { from: accounts[1] })
    const com__ = com_.logs[0].args.commit
    console.log('com__: ', com__)
    //console.log('comm: ', comm)
    const balance = await arg.balanceOf.call(com__)
    //const c = await Commit.at(com__)
    console.log({ balance })
    await wait(10000)
    const receipt = await eta.up(com__, true, { from: accounts[1] })
    console.log({ value: receipt.logs[0].args.value * 1 })
    console.log({ value: receipt.logs[1].args.value * 1 })
    //console.log({ value: receipt.logs[2].args.value * 1 })
    //console.log({ value: receipt.logs[3].args.value * 1 })
    //const value_ = await eta.value.call(com__)
    //assert.isAtLeast(value_ * 1, 6, "The value is at least 6 with balancing after the up function is called")
    //console.log({ assert })
    //assert.isAtMost(value_ * 1, 10, "The value balances to less than 5 + 7 (12)")
  })
})
