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
    //address wallet;
  }
  // REVIEW - should every repo force new address or address independent repos?
  mapping(address => Commit[]) private commits;
  mapping(address => Repo[]) private repos;
  mapping(string => Commit[]) private namedRepos;
  mapping(string => Repo) private repoByName;
  // TODO - either generate address or use nested struct if supported
  mapping(string => Commit[]) private commitsByRepoName;
  constructor() {
      
  }
  function commit(string memory hash, string memory repo) public returns (uint) {
    commitsByRepoName[repo].push(Commit(hash, block.timestamp));
    return block.number;
  }
  function commit(string memory hash) public returns (uint) {
    commits[msg.sender].push(Commit(hash, block.timestamp));
    return block.number;
  }
  function commit(string memory hash, address repo) public returns (uint) {
    return 0;
  }
  function repo(string memory name, string memory url) public returns (uint) {
    return 0;
  }
}
