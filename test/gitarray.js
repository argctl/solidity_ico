const assert = require('node:assert')

describe('gitarray', () => {
  // TODO - explore beforeAll 
  //function org () public returns (bool) {
  //it('organization', () => {
  it('creates repo for argctl', async () => {
    const [owner, buyer, spender, holder, trader, user] = await ethers.getSigners()
    const gitorg = await ethers.deployContract('gitorg')
    const arg = await ethers.deployContract('gitarg')
    const eta = await ethers.deployContract('giteta', [arg.address])
    //constructor(address[] memory _handshakes, address _owner, address _gitarg, address _giteta) {
    const handshakes = [owner, buyer, spender, holder, trader, user].map(account => account.address)
    const array = await ethers.deployContract('gitarray', [handshakes, owner.address, arg.address, eta.address], { libraries: { gitorg: gitorg.address } })
    const Gitorg = await ethers.deployContract('_gitorg', [arg.address, array.address])
    const _handshakes = await ethers.deployContract('Handshakes', [handshakes, owner.address, 3, true])
    const ctl = await ethers.deployContract('argctl', [_handshakes.address, Gitorg.address, arg.address, array.address, eta.address], { libraries: { gitorg: gitorg.address } })
    //function repo(address[] memory _handshakes, string memory _name, string memory _url, address _owner, address _argctl) public returns (address) {
    //'repo(address[],string,string,address,address)'
    handshakes.push(array.address)
    const receipt = await array.connect(user)['repo(address[],string,string,address,address)'](handshakes, 'Test Repo', 'https://gitarg.com/repo.git', user.address, ctl.address)
    const { events, logs } = await receipt.wait()
    console.log({ events, logs })
    assert.equal(repo_.length, 42, "string address returned from call of repo function")

  })
  //function ctl () public returns (bool) {
  it('control', () => {})
  //function repo(address[] memory _handshakes, string memory _name, string memory _url, address _owner, address _argctl) public returns(uint) {
  //it('', () => {})
  //function proof () public view returns (address) {
  //it('', () => {})

})
