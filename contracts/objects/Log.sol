// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

contract Log {
  address public wallet;
  bytes public commit;
  bytes public message;
  bytes public author;
  bytes public date;
  constructor(bytes memory _commit, bytes memory _author, bytes memory _date, bytes memory _message) {
    wallet = msg.sender;
    commit = _commit;
    message = _message;
    author = _author;
    date = _date;
  }
  function getWallet() public view returns (address) {
    return wallet;
  }
  function getCommit() public view returns (bytes memory) {
    return commit;
  }
  function getMessage() public view returns (bytes memory) {
    return message;
  }
  function getAuthor() public view returns (bytes memory) {
    return author;
  }
  function getDate() public view returns (bytes memory) {
    return date;
  } 
}
