const assert = require('node:assert')
const { wait } = require('./utils')
//const _string = artifacts.require('_string') 

// TODO - private type?
let _string_
let _uint_
let _int_
let _address_
describe('_type', accounts => {
  it('public owner', async () => {
    const [owner] = await ethers.getSigners()
    const type_ = await ethers.deployContract('_type')
    assert.equal(await type_.O(), owner.address, 'owner is the default owner and accessable')
    //console.log('owner: ', await type_.O(), accounts[0])
  })
  it('send changes owner', async () => {
    const [owner, buyer] = await ethers.getSigners()
    const type_ = await ethers.deployContract('_type') 
    await type_.send(buyer.address)
    assert.equal(await type_.O(), buyer.address, 'the owner changes when the type is sent')
  })
  it('string send', async () => {
    const [owner, buyer] = await ethers.getSigners()
    const string_ = await ethers.deployContract('_string', ['duck'])
    await string_.send(buyer.address)
    assert.equal(await string_.O(), buyer.address, 'the owner changes when the string is sent')
    _string_ = string_.address
  })
  it('string', async () => {
    const [owner, buyer] = await ethers.getSigners()
    const _string = await ethers.getContractFactory('_string')
    const string_ = await _string.attach(_string_)
    const receipt = await (await string_.connect(buyer).time()).wait()
    const bytes = receipt.events[0].args[0]
    console.log({ bytes })
    const buff = Buffer.from(bytes.split('x')[1], 'hex')
    const decodedString = buff.toString('utf-8')
    console.log({ decodedString })
    assert.equal(decodedString, 'duck', 'string matches deploy')
  })
  it('uint send', async () => {
    const [owner, buyer] = await ethers.getSigners()
    const uint_ = await ethers.deployContract('_uint', [100])
    await uint_.send(buyer.address)
    assert.equal(await uint_.O(), buyer.address, 'the owner changes when the uint is sent')
    _uint_ = uint_.address
  })
  it('uint', async () => {
    const [owner, buyer] = await ethers.getSigners()
    const _uint = await ethers.getContractFactory('_uint')
    const uint_ = await _uint.attach(_uint_)
    const receipt = await (await uint_.connect(buyer).time()).wait()
    const bytes = receipt.events[0].args[0]
    console.log({ bytes })
    const decodedUint = parseInt(bytes, 16)
    //const buff = Buffer.from(bytes.split('x')[1], 'hex')
    //const decodedString = buff.toString('utf-8')
    assert.equal(decodedUint, 100, 'uint matches deploy')
  })
  it('int send', async () => {
    const [owner, buyer] = await ethers.getSigners()
    const int_ = await ethers.deployContract('_int', [100])
    await int_.send(buyer.address)
    assert.equal(await int_.O(), buyer.address, 'the owner changes when the int is sent')
    _int_ = int_.address
  })
  it('int', async () => {
    const [owner, buyer] = await ethers.getSigners()
    const _int = await ethers.getContractFactory('_int')
    const int_ = await _int.attach(_int_)
    const receipt = await (await int_.connect(buyer).time()).wait()
    const bytes = receipt.events[0].args[0]
    console.log({ bytes })
    //const decodedInt = parseInt(bytes, 16)
    const decodedInt = ethers.utils.defaultAbiCoder.decode(['uint256'], bytes) * 1
    console.log('decodedInt: ', decodedInt.toString())
    // 115,792,089,237,316,200,000,000,000,000,000,000,000,000,000
    //const decodedInt = parseInt(bytes, 16)
    assert.equal(decodedInt, 100, 'int matches deploy')
  })
  it('address', async () => {
    const [owner] = await ethers.getSigners()
    const address_ = await ethers.deployContract('_address', [owner.address])
    const receipt = await (await address_.connect(owner).time()).wait()
    console.log({ receipt })
    //const bytes = web3.utils.hexToBytes(receipt.logs[0].args[0])
    const bytes = receipt.events[0].args[0]
    console.log({ bytes })
    //const address = receipt.logs[0].args[0]
    //const buff = Buffer.from(bytes.split('x')[1], 'hex')
    //const decodedString = buff.toString('utf-8')
    //const address = web3.utils.bytesToHex(bytes)
    //assert.equal(address, accounts[0], 'the address deployed matches the address from the accounts in deployement')
    assert.equal(bytes.toLowerCase(), owner.address.toLowerCase(), 'the address deployed matches the address from the accounts in deployement')
  })
  // TODO - send address
})
