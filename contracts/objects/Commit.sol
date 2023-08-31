// SPDX-License-Identifier: UNLICENSED
pragma solidity >= "0.8.18";

contract Commit {
  address public repo;
  // private wallet that can be made public might just need a check
  // the rest of the variables need access from repo
  // could put it in a struct
  address private wallet;
  string private message;
  string private author;
  string private date;
  bytes private hash;
  // should the hash time be public?
  uint public hashTime;

  address creator; // likely giteta contract
  // code cost
  constructor(address _wallet, address _repo, string memory _message, string memory _author, string memory _date) {
    creator = msg.sender;
    wallet = _wallet;
    repo = _repo;
    message = _message;
    author = _author;
    date = _date;
  }

  function setCodeHash(bytes memory _hash) public returns (uint) {
    require(hash.length == 0);
    hash = _hash;
    hashTime = block.timestamp;
    return hashTime;
  }

}
