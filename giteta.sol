// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";
import "./libraries/gitorg.sol";

contract giteta {
  // TODO - make address argument for relays
  address gitarg = 0xb3Bdb3e25BB580CA98480a5fD7c98E6516750685;
  // REVIEW - should include commit message or not for security?
  struct Commit {
    string commit;
    uint256 timestamp;
  }
  struct Repo {
    string name;
    string url;
    address wallet;
  }
  struct Account {
    address wallet;
    uint stash;
  }
  // REVIEW - should every repo force new address or address independent repos?
  mapping(address => bool) private repoLock;
  mapping(address => Account) private accounts;
  mapping(address => Commit[]) private commits;
  mapping(address => Repo[]) private repos;
  mapping(string => Commit[]) private namedRepos;
  mapping(string => Repo) private repoByName;
  // TODO - either generate address or use nested struct if supported
  mapping(string => Commit[]) private commitsByRepoName;
  mapping(address => Repo) private addressRepo;
  constructor() {
      
  }
  function account(address wallet) public payable returns (uint) {
    Account memory account = Account(wallet, msg.value); 
    accounts[wallet] = account;
    return 0;
  }
  function set(address wallet) public payable returns (uint) {
    require(accounts[wallet].wallet == msg.sender);
    // TODO - map to gitarg coin with gitorg library
    accounts[wallet].stash = msg.value;
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
    commits[repo].push(Commit(hash, block.timestamp));   
    return block.number;
  }
  function repo(string memory name, string memory url) public returns (uint) {
    Repo memory repo = Repo(name, url, msg.sender);
    repos[msg.sender].push(repo);
    repoByName[name] = repo;
    return block.timestamp;
  }
  function repo(address wallet, string memory name, string memory url) public returns (uint) {
    require(!repoLock[wallet]);
    addressRepo[wallet] = Repo(name, url, wallet);
  }
}
