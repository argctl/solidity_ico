// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";
import "./gitarg.sol";
import "./objects/Repo.sol";
import "./objects/Commit.sol";

// TimeLog handshake string/bytes for blockchain interface

contract giteta {
  // TODO - make address argument for relays
  address gitarg = 0xb3Bdb3e25BB580CA98480a5fD7c98E6516750685;
  // REVIEW - should include commit message or not for security?
  
  struct SimpleCommit {
    string hash;
    uint timestamp;
  }
  struct Access {
    address wallet;
    uint256 timestamp;
  }
  struct Log {
    address wallet;
    bytes commit;
    bytes author;
    bytes date;
  }
  
  // REVIEW - should every repo force new address or address independent repos?
  mapping(address => bool) private repoLock;
  mapping(address => SimpleCommit[]) private commits;
  mapping(address => Repo[]) private repos;
  mapping(string => SimpleCommit[]) private namedRepos;
  mapping(string => Repo) private repoByUrl;
  // TODO - either generate address or use nested struct if supported
  mapping(string => SimpleCommit[]) private commitsByUrl;
  mapping(address => Repo) private addressRepo;
  mapping(address => Log[]) private repoLog;

  address private gitargWallet;
  Access[] private accessList;
  
  constructor() {
    gitargWallet = msg.sender;
  }
  function getGitargWallet() public returns (address) {
    accessList.push(Access(msg.sender, block.timestamp));
    return gitargWallet;
  }
  function commit(string memory hash, string memory repo) public returns (uint) {
    commitsByUrl[repo].push(SimpleCommit(hash, block.timestamp));
    return block.number;
  }
  function commit(string memory hash) public returns (uint) {
    commits[msg.sender].push(SimpleCommit(hash, block.timestamp));
    return block.number;
  }
  function commit(string memory hash, address repo) public returns (uint) {
    commits[repo].push(SimpleCommit(hash, block.timestamp));   
    return block.number;
  }
  function repo(string memory name, string memory url) public returns (uint) {
    Repo repo = new Repo(name, url);
    repos[msg.sender].push(repo);
    repoByUrl[url] = repo;
    return block.timestamp;
  }
  // move repo to new wallet organization
  function repo(address _Repo, string memory name, string memory url) public returns (uint) {
    //interchain so no LinkSecret needed
    require(!repoLock[_Repo]);
    Repo repo = Repo(_Repo);
    repos[_Repo].push(repoByUrl[url]);
  }
  function log(address repo, string[] memory logEntries) public returns (uint) { //uint[]
    /*
    commit e6c47dc17a0a711e07a75f267b6bc428d626b13c
    Author: David Kamer <me@davidkamer.com>
    Date:   Fri Jun 16 12:30:11 2023 -0400

    refactor

    commit e9537ece4130fdd24ed902417d5b80bb008c20ba
    Author: David Kamer <me@davidkamer.com>
    Date:   Fri Jun 16 03:16:07 2023 -0400

    important note! 
    */
    require(!repoLock[msg.sender]);
    Log[] memory log;
    repoLog[repo] = log;
    
    for (uint i = 0; i < logEntries.length; i++) {
      string memory logEntry = logEntries[i];
      bytes memory logBytes = bytes(logEntry);
      uint count = 0;
      //bytes memory date;
      bytes memory commit;
      bytes memory author;
      bytes memory date;
      bytes memory message;
      bool flag = true;
      uint byteCount = 0;
      // REVIEW - need second iterator for bytes arrays
      for (uint i = 0; i < logBytes.length; i++) {
        // TODO - map commit
        if (count == 0) {
          if (flag) {
            commit[byteCount] = logBytes[i];
            byteCount++;
          }
          if (logBytes[i] == ' ') flag = true;
        }
        // TODO - store commit date from dev terminal
        if (count == 1) {
          if (flag) {
            author[byteCount] = logBytes[i]; 
            byteCount++;
          }
          if (logBytes[i] == ' ') flag = true;
        }
        if (count == 2) {
          if (flag) {
            date[byteCount] = logBytes[i];
            byteCount++;
          }
          if (logBytes[i] == ' ') flag = true;
        }
        if (count == 4) {
          message[byteCount] = logBytes[i];
          byteCount++;
        }
        // REVIEW - 2 byte counts for escape?
        if (logBytes[i] == '\n') {
          flag = false;
          byteCount = 0;
          count++;
        }
      }
      repoLog[repo].push(Log(msg.sender, message, author, date));
    }
    return 0;
  }
}
