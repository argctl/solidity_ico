// SPDX-License-Identifier: UNLICENSED
pragma solidity >= "0.8.18";

contract Commit {
  address repo;
  address wallet;
  bytes message;
  bytes author;
  bytes date;
  bytes hash;
  uint hashTime;
  constructor(address _wallet, address _repo, bytes memory _message, bytes memory _author, bytes memory _date) {
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
