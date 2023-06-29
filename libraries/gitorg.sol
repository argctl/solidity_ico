// SPDX-License-Identifier: UNLICENSED
pragma solidity >= "0.8.18";
import "../giteta.sol";
import "../gitarg.sol";

//library so that there is a single point and interface to externals reference

library gitorg {
  // TODO - library interface exteranal to gitarg
  // uses contract addresses to pool/poll versioning data 
  // "directs traffic"
  function donate(address giteta, address gitarg) public returns (uint) {
    return 0;
  }
  function direct(address _giteta, address _gitarg, address repo, uint stash, address _to) public returns (uint) {
    // REVIEW - recycle to either contract address or escrow wallet to cycle GITARG coin
    giteta eta = giteta(_giteta);
    gitarg arg = gitarg(_gitarg);
    address wallet = eta.getGitargWallet();
    require(_to == wallet);
    // TODO - stash from msg.value or account stash?
    require(stash >= msg.value * 100000); // REVIEW - query for rate on contract? 
    // TODO - use gitarray setter value for inflation deflation control
    arg.transfer(wallet, stash);
    //eta.transfer(repo);
    // TODO - giteta gitarg bridge
    return block.timestamp;
  }
  function stats() public returns (uint) {
    return 0;
  }
  function pool() public returns (uint) {
    return 0;
  }
  function poll() public returns (uint) {
    return 0;
  }
  function search() public returns (address) {
    return msg.sender;
  }
}
