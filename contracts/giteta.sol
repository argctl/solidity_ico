// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.20";
import "./gitarray.sol";
import "./gitarg.sol";
import "./objects/Repo.sol";
import "./objects/Commit.sol";
import "./objects/Log.sol";

// TimeLog handshake string/bytes for blockchain interface

contract giteta {
  // REVIEW - wallet changeable with handshakes in gitarray
  // REVIEW - should we change the modifiers to private
  address public gitargWallet;
  gitarg public Gitarg;
  address public arg;

  uint public service;

  struct Time {
    address commit;
    uint timestamp;
  }

  mapping(Repo => Time[]) private commits;
  mapping(address => Time) private valuing;
  mapping(address => uint) private bounties;

  event Com(address commit);
  event Comm(Time[] commits);
  event Value(uint value);
  
  constructor(address _gitarg) {
    arg = _gitarg;
    Gitarg = gitarg(_gitarg);
    gitargWallet = msg.sender;
  }
  // REVIEW - payinto repo?
  //constructor(address _wallet, address _repo, bytes memory _message, bytes memory _author, bytes memory _date) {
  function commit(address _repo, string memory message, string memory author, string memory date, uint escrow) public returns (uint) {
    require(Gitarg.balanceOf(msg.sender) >= escrow, "not enough escrow");
    // REVIEW - should the transfer be placed into the repo?
    Commit c = new Commit(msg.sender, _repo, message, author, date);
    //🤯
    service += 1;
    Gitarg.transferFrom(msg.sender, address(c), escrow - 1);
    Repo repo = Repo(_repo);
    Time memory time = Time(address(c), block.timestamp);
    // REVIEW - should this really be a repo object as a key or the address
    commits[repo].push(time);
    valuing[address(c)] = time;
    emit Com(address(c));
    return Gitarg.balanceOf(address(c));
  }
  // raise value of commits - called when used successfully by chain
  function up(address payable _commit, bool _balance) public payable returns (uint) {
    Commit commit = Commit(_commit);
    Time memory time = valuing[_commit];
    uint _value = block.timestamp - time.timestamp;
    if (_balance) {
      uint balance = Gitarg.balanceOf(_commit);
      // REVIEW - should we spit back
      if (_value < balance) _value = 0; 
      if (_value >= balance) _value -= balance;
    }
    require(Gitarg.balanceOf(msg.sender) > _value, "Balance of wallet is less than the difference (_value)");
    Gitarg.transferFrom(msg.sender, _commit, _value);
    return _value;
  }
  // raise value of commits - called when issue is created involving commit
  // REVIEW - gitarray 
  function down(address payable _repo, address payable _commit, uint bounty) public payable returns (uint) {
    // TODO - check gitarg token stash of wallet
    Repo repo = Repo(_repo);
    Commit commit = Commit(_commit);
    // TODO - gitorg library to use handshakes
    // REVIEW - should this be the commit owner?
    require(msg.sender == repo.owner(), "repo owner doesn't match msg.sender");
    require(Gitarg.balanceOf(address(commit)) >= bounty);
    Gitarg.transferFrom(_commit, _repo, bounty);
    // REVIEW - bounty needed
    bounties[_commit] += bounty;
    // REVIEW - values based on the git token backed?
    return 0;
  }
  // query value of commit
  function value(address _commit) public view returns (uint) {
    return Gitarg.balanceOf(address(Commit(_commit)));
  }
  // query commits by range, repo or value
  function query(address _repo, uint start, uint end) public returns (Time[] memory) {
    Time[] memory repo = commits[Repo(_repo)];
    Time[] memory _commits = new Time[](repo.length);
    uint j = 0;
    for (uint i = 0; i < repo.length; i++) {
      Time memory time = repo[i];
      if (time.timestamp >= start && time.timestamp <= end) {
        // _commits.length is 0 when index is 0 for length of 0, 1 when index is 1 for unwritten space
        _commits[++j] = time;
        emit Value(time.timestamp);
        emit Com(time.commit);
      }
    }
    return _commits; 
  }
  function query(address repo) public view returns (Time[] memory) {
    return commits[Repo(repo)];
  }
  function query(uint _value, address _repo) public view returns (Time[] memory) {
    Time[] memory repo = commits[Repo(_repo)];
    Time[] memory _commits = new Time[](repo.length);
    for (uint i = 0; i < repo.length; i++) {
      if (Gitarg.balanceOf(repo[i].commit) == _value) {
        _commits[i] = repo[i];
      }
    }
    return _commits;
  }
}
