const _type = artifacts.require('_type')
const _string = artifacts.require('_string')
const _uint = artifacts.require('_uint')
const _int = artifacts.require('_int')
const { wait } = require('./utils')
//const _string = artifacts.require('_string') 

// TODO - private type?
contract('_type', accounts => {
  it('public owner', async () => {
    const type_ = await _type.deployed()
    assert.equal(await type_.O(), accounts[0], 'owner is the default owner and accessable')
    //console.log('owner: ', await type_.O(), accounts[0])
  })
  it('send changes owner', async () => {
    const type_ = await _type.deployed() 
    await type_.send(accounts[1])
    assert.equal(await type_.O(), accounts[1], 'the owner changes when the type is sent')
  })
  it('string send', async () => {
    const string_ = await _string.deployed()
    await string_.send(accounts[1])
    assert.equal(await string_.O(), accounts[1], 'the owner changes when the string is sent')
  })
  it('string', async () => {
    const string_ = await _string.deployed()
    const receipt = await string_.time({ from: accounts[1] })
    console.log({ receipt })
    console.log('log: ', receipt.logs[0].args[0])
    const bytes = receipt.logs[0].args[0]
    console.log({ bytes })
    const buff = Buffer.from(bytes.split('x')[1], 'hex')
    const decodedString = buff.toString('utf-8')
    console.log({ decodedString })
    assert.equal(decodedString, 'duck', 'string matches deploy')
  })
  it('uint send', async () => {
    const uint_ = await _uint.deployed()
    await uint_.send(accounts[1])
    assert.equal(await uint_.O(), accounts[1], 'the owner changes when the uint is sent')
  })
  it('uint', async () => {
    const uint_ = await _uint.deployed()
    const receipt = await uint_.time({ from: accounts[1] })
    const bytes = receipt.logs[0].args[0]
    console.log({ bytes })
    const decodedUint = parseInt(bytes, 16)
    //const buff = Buffer.from(bytes.split('x')[1], 'hex')
    //const decodedString = buff.toString('utf-8')
    assert.equal(decodedUint, 100, 'uint matches deploy')
  })
  it('int send', async () => {
    const int_ = await _int.deployed()
    await int_.send(accounts[1])
    assert.equal(await int_.O(), accounts[1], 'the owner changes when the int is sent')
  })
  it('int', async () => {
    const int_ = await _int.deployed()
    const receipt = await int_.time({ from: accounts[1] })
    const bytes = receipt.logs[0].args[0]
    console.log({ bytes })
    //const decodedInt = parseInt(bytes, 16)
    const decodedInt = web3.utils.toBN(bytes) * 1
    console.log('decodedInt: ', decodedInt.toString())
    // 115,792,089,237,316,200,000,000,000,000,000,000,000,000,000
    //const decodedInt = parseInt(bytes, 16)
    assert.equal(decodedInt, 100, 'int matches deploy')
  })
})
