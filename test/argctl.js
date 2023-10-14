const argctl = artifacts.require('argctl')
const repo = artifacts.require('repo')

contract('argctl', (accounts) => {
  it('can commit', async () => {
    const ctl = await argctl.deployed()
    const _repo = await repo.deployed()
    /*
    commit 84227419a8d956aa5f5ccfd27286705e202243fe
    Author: David Kamer <me@davidkamer.com>
    Date:   Sun Oct 1 03:40:44 2023 -0400

    untyped proposal
    */
    //function commit(address _repo, string memory _message, string memory _author, string memory _date) public returns(uint) {
    await ctl.commit(_repo.address, 'untyped proposal', 'David Kamer <me@davidkamer.com>', 'Sun Oct 1 03:40:44 2023 -0400', { from: accounts[1] })
  })
  //function checkin (address repo, address handshakes) public {
  it('checkin times', async () => {

  })
  //function proof () public view returns (address) {
  it('proof provides', async () => {

  })
})
