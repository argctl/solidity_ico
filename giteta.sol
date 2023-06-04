// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";

contract giteta {
  // TODO - make address argument for relays
  address gitarg = 0xb3Bdb3e25BB580CA98480a5fD7c98E6516750685;
  struct Commit {
    string commit;
    uint256 timestamp;
  }
  struct Repo {
    string name;
    string url;
  }
  // REVIEW - should every repo force new address or address independent repos?
  mapping(address => Commit[]) private commits;
  mapping(address => Repo[]) private repos;
  constructor() {
      
  }
  function commit(string memory hash, string memory repo) public returns (uint) {
    return 0;
  }
  function commit(string memory hash) public returns (uint) {
    return 0;
  }
  function repo(string memory name, string memory url) public returns (uint) {
    return 0;
  }
}
