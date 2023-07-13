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
  mapping(address => Time) valuing;
  mapping(address => uint) values;
  
  constructor(address _gitarg) {
    gitarg = _gitarg;
    gitargWallet = msg.sender;
  }
  // REVIEW - payinto repo?
  //constructor(address _wallet, address _repo, bytes memory _message, bytes memory _author, bytes memory _date) {
  function commit(address repo, string memory message, string memory author, string memory date) public returns (uint) {
    Commit c = new Commit(msg.sender, repo, message, author, date);
    Repo repo = Repo(repo);
    Time time = Time(address(c), block.timestamp);
    commits[repo].push(time);
    valuing[address(c)] = time;
    return block.timestamp;
  }
  // raise value of commits - called when used successfully by chain
  function up(address commit) public returns (uint) { //re-up?
    // subtract timestamps 
    // TODO - repo owner or gitarray tie in?
    Time time = valuing[commit];
    uint value = block.timestamp - time.timestamp;
    values[commit] = value;
    return value;
  }
  // raise value of commits - called when issue is created involving commit
  function down(address commit) public returns (uint) {
    return 0;
  }
  // query value of commit
  function value(address commit) public returns (uint) {
    return values[commit];
  }
  // query commits by range, repo or value
  function query(uint start, uint end) public return (Time[] memory) {
    
  }
  function query(address repo) public return (Time[] memory) {
    return commits[repo];
  }
  function query(uint value) public return (Time[] memory) {
    return value;
  }
}
