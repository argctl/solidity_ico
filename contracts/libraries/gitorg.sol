// SPDX-License-Identifier: UNLICENSED
pragma solidity >= "0.8.20";
import "../giteta.sol";
import "../gitarg.sol";
//import "../objects/Repo.sol";

//library so that there is a single point and interface to externals reference

// !!!
// REVIEW - msg.value may not be available in library functions and might need to be replaced with contract functions
// REVIEW - msg.value and transfer - if msg.value is not available, transfer/send shouldn't be?
library gitorg {
  // TODO - library interface exteranal to gitarg
  // uses contract addresses to pool/poll versioning data 
  // "directs traffic"
  function stamp (string memory _hash, uint timestamp, address _msgSender) public pure returns (bytes32) {
    return keccak256(abi.encodePacked(_hash, timestamp, _msgSender));
  }
  function key (string memory _hash) public pure returns (bytes32) {
    // REVIEW - keccak is a rainbow table or one way hash?
    return keccak256(abi.encodePacked(_hash));
  }
  function donate(address _giteta, address payable _gitarg) public returns (bool) {
    // REVIEW - should msg.sender to commit instead of eta or value split
    //giteta eta = giteta(_giteta);
    gitarg arg = gitarg(_gitarg);
    arg.transferFrom(msg.sender, _giteta, msg.value);
    bool success = _gitarg.send(msg.value);
    if (!success) {
      payable(msg.sender).transfer(msg.value);
    }
    return success;
  }
  function direct(address _giteta, address _gitarg, address payable _repo, uint stash, address payable _to) public returns (bool) {
    // REVIEW - recycle to either contract address or escrow wallet to cycle GITARG coin
    giteta eta = giteta(_giteta);
    gitarg arg = gitarg(_gitarg);
    //Repo repo = Repo(_repo);
    address wallet = eta.gitargWallet();
    require(_to == wallet);
    // TODO - stash from msg.value or account stash?
    //require(stash >= msg.value * 100000); // REVIEW - query for rate on contract? 
    // TODO - use gitarray setter value for inflation deflation control
    arg.transfer(wallet, stash);
    //eta.transfer(repo);
    // TODO - giteta gitarg bridge
    bool success = _repo.send(msg.value);
    if (!success) {
      payable(msg.sender).transfer(msg.value);
    }
    return success;
  }
  function stats() public pure returns (uint) {
    return 0;
  }
  function pool() public pure returns (uint) {
    return 0;
  }
  function poll() public pure returns (uint) {
    return 0;
  }
  function search() public view returns (address) {
    return msg.sender;
  }
  function timestamp() public view returns (uint) {
    return block.timestamp;
  }
  // TODO - place the argctl command
  //function argctl()
  function approve(address _gitarg, address payable _wallet, uint value) public {
    gitarg Gitarg = gitarg(_gitarg);
    Gitarg.approve(_wallet, value);
  }
  //function 
}
