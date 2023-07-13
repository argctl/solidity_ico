// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";
import "./gitarg.sol";
import "./objects/Repo.sol";
import "./objects/Commit.sol";
import "./objects/Log.sol";

// TimeLog handshake string/bytes for blockchain interface

contract giteta {
  address gitargWallet;
  address gitarg;

  struct Time {
    address commit;
    uint timestamp;
  }

  mapping(Repo => Time[]) commits;
  
  constructor(address _gitarg) {
    gitarg = _gitarg;
    gitargWallet = msg.sender;
  }
  // REVIEW - payinto repo?
  //constructor(address _wallet, address _repo, bytes memory _message, bytes memory _author, bytes memory _date) {
  function commit(address repo, string memory message, string memory author, string memory date) public returns (uint) {
    Commit c = new Commit(msg.sender, repo, message, author, date);
    Repo repo = Repo(repo);
    commits[repo].push(Time(address(c), block.timestamp));
    return block.timestamp;
  }
}
