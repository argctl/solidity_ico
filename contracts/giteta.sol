// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";
import "./gitarg.sol";
import "./objects/Repo.sol";
import "./objects/Commit.sol";
import "./objects/Log.sol";

// TimeLog handshake string/bytes for blockchain interface

contract giteta {
  address gitargWallet;
  gitarg public Gitarg;
  address public arg;

  struct Time {
    address commit;
    uint timestamp;
  }

  mapping(Repo => Time[]) commits;
  mapping(address => Time) valuing;
  mapping(address => uint) bounties;
  mapping(address => uint) values;
  
  constructor(address _gitarg) {
    arg = _gitarg;
    Gitarg = gitarg(_gitarg);
    gitargWallet = msg.sender;
  }
  // REVIEW - payinto repo?
  //constructor(address _wallet, address _repo, bytes memory _message, bytes memory _author, bytes memory _date) {
  function commit(address _repo, string memory message, string memory author, string memory date, uint escrow) public returns (uint) {
    require(Gitarg.balanceOf(msg.sender) >= escrow);
    // REVIEW - should the transfer be placed into the repo?
    Commit c = new Commit(msg.sender, _repo, message, author, date);
    Gitarg.transferFrom(msg.sender, address(c), escrow);
    Repo repo = Repo(_repo);
    Time memory time = Time(address(c), block.timestamp);
    commits[repo].push(time);
    valuing[address(c)] = time;
    return block.timestamp;
  }
  // raise value of commits - called when used successfully by chain
  function up(address payable _commit) public payable returns (uint) { //re-up?
    // subtract timestamps 
    // TODO - repo owner or gitarray tie in?
    Time memory time = valuing[_commit];
    uint _value = block.timestamp - time.timestamp;
    // REVIEW - gte
    require(Gitarg.balanceOf(msg.sender) > _value);
    // REVIEW - repo instead of commit?
    Gitarg.transferFrom(msg.sender, _commit, _value);
    values[_commit] = _value;
    return _value;
  }
  // raise value of commits - called when issue is created involving commit
  function down(address payable _repo, address payable _commit, uint bounty) public payable returns (uint) {
    // TODO - check gitarg token stash of wallet
    Repo repo = Repo(_repo);
    // TODO - gitorg library to use handshakes
    // REVIEW - should this be the commit owner?
    require(msg.sender == repo.owner());
    require(values[_commit] >= bounty && Gitarg.balanceOf(_commit) >= bounty);
    Gitarg.transferFrom(_commit, _repo, bounty);
    // REVIEW - bounty needed
    bounties[_commit] += bounty;
    // REVIEW - values based on the git token backed?
    values[_commit] -= bounty;
    return 0;
  }
  // query value of commit
  function value(address _commit) public view returns (uint) {
    return values[_commit];
  }
  // query commits by range, repo or value
  function query(address _repo, uint start, uint end) public view returns (Time[] memory) {
    Time[] memory _commits;
    Time[] memory repo = commits[Repo(_repo)];
    for (uint i = 0; i < repo.length; i++) {
      Time memory time = repo[i];
      if (time.timestamp >= start && time.timestamp <= end) _commits[i] = time;
    }
    return _commits; 
  }
  function query(address repo) public view returns (Time[] memory) {
    return commits[Repo(repo)];
  }
  function query(address _repo, uint _value) public view returns (Time[] memory) {
    Time[] memory _commits;
    Time[] memory repo = commits[Repo(_repo)];
    for (uint i = 0; i < repo.length; i++) {
      if (values[repo[i].commit] == _value) {
        _commits[i] = repo[i];
      }
    }
    return _commits;
  }
}
