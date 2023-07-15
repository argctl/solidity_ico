// SPDX-License-Identifier: UNLICENSED
pragma solidity >= "0.8.18";

contract Commit {
  address repo;
  address wallet;
  string message;
  string author;
  string date;
  bytes hash;
  uint hashTime;

  address creator; // likely giteta contract
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
