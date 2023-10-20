const Handshakes = artifacts.require('Handshakes')
const Proposal = artifacts.require('Proposal')
const _uint = artifacts.require('_uint')

contract('Handshakes', (accounts) => {
  //function isHandshake(address sender) public view member returns(bool) {
  it('isHandshake sender retreives the handshake when the sender is a member', async () => {
    const handshakes = await Handshakes.deployed()
    const handshakey = await handshakes.isHandshake(accounts[1], { from: accounts[1] })
    console.log({ handshakey })
    assert.equal(handshakey, true, "accounts[1] is a handshake")
  })
  //function isHandshake() public view returns(bool) {
  it('tracks handshakes mutually', async () => {
    const handshakes = await Handshakes.deployed()
    const handshakey = await handshakes.isHandshake({ from: accounts[1] })
    console.log({ handshakey })
    assert.equal(handshakey, true, 'accounts[1] is a handshake')
  })
  //function setProposal(address _proposal) public own returns(uint) {
  it('setProposal links an address of a proposal', async () => {
    const uint = await _uint.new(100)
    //constructor(address _object) {
    const proposal = await Proposal.new(uint.address)

  })
  //function shake() public member {
  it('shake registers handshake address as approved list of shakes', async () => {
    const handshakes = await Handshakes.deployed()
    await handshakes.shake({ from: accounts[1]  })
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
