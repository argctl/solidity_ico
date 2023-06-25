// SPDX-License-Identifier: UNLICENSED
pragma solidity >= "0.8.18";

contract Commit {
  address repo;
  address wallet;
  bytes commit;
  bytes author;
  bytes date;
  constructor(address _wallet, address _repo, bytes memory _commit, bytes memory _author, bytes memory _date) {
    wallet = _wallet;
    repo = _repo;
    commit = _commit;
    author = _author;
    date = _date;
  }

}
