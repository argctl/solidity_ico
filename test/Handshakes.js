const assert = require('node:assert')

let _Handshakes
describe('Handshakes', (accounts) => {
  //function isHandshake(address sender) public view member returns(bool) {
  it('isHandshake sender retreives the handshake when the sender is a member', async () => {
    const [owner, buyer, spender, holder, trader, user] = await ethers.getSigners()
    //const handshakes = await deployer.deploy(Handshakes, accounts.slice(1), accounts[0], 3, true)
    const _handshakes = [buyer, spender, holder, trader, user].map(({ address }) => address)
    const handshakes = await ethers.deployContract('Handshakes', [_handshakes, owner.address, 3, true])
    _Handshakes = handshakes.address
    const handshakey = await handshakes.connect(buyer)['isHandshake(address)'](buyer.address)
    console.log({ handshakey })
    assert.equal(handshakey, true, "buyer is a handshake")
  })
  //function isHandshake() public view returns(bool) {
  it('tracks handshakes mutually', async () => {
    const [owner, buyer] = await ethers.getSigners()
    const Handshakes = await ethers.getContractFactory('Handshakes')
    const handshakes = await Handshakes.attach(_Handshakes)
    const handshakey = await handshakes.connect(buyer)['isHandshake()']()
    console.log({ handshakey })
    assert.equal(handshakey, true, 'buyer account is a handshake')
  })
  //function setProposal(address _proposal) public own returns(uint) {
  it('setProposal links an address of a proposal', async () => {
    const uint = await ethers.deployContract('_uint', [100])
    //constructor(address _object) {
    const proposal = await ethers.deployContract('Proposal', [uint.address])

  })
  //function shake() public member {
  it('shake registers handshake address as approved list of shakes', async () => {
    const [owner, buyer] = await ethers.getSigners()
    const Handshakes = await ethers.getContractFactory('Handshakes')
    const handshakes = await Handshakes.attach(_Handshakes)
    await handshakes.connect(buyer).shake()
  })
  //function check(address[] memory shakes, address[] memory noshakes) public view own {
  it('check shakes vs no shakes all noshakes except account[1]', async () => {
    //const handshakes = await Handshakes.deployed()
    //await handshakes.check(accounts.slice(2), accounts[1])
  })
  //function add(address handshake) public own stop returns (uint) {
  it('', async () => {

  })
  //function remove() public returns (uint) {
  it('', async () => {

  })
  //function remove(address handshake) public own stop returns (uint) {
  it('', async () => {

  })
  //function unstopper(address handshake, bool _epoch) public own rhyme returns (uint) {
  //function epoch () public own {
  it('', async () => {

  })
})
