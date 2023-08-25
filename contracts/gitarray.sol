// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";
import "./giteta.sol";
//import "./libraries/gitorg.sol";
import "./gitarg.sol";
import "./objects/Repo.sol";
import "./objects/Commit.sol";

contract Proposal {
  uint private proposal;
  string private value;
  address private object;
  address private creator;
  bool public safeMode = true;

  modifier safe () {
    if (safeMode) require(msg.sender == creator);
    _;
  }

  constructor(uint _proposal, string memory _value, address _object) {
    creator = msg.sender;  
    object = _object;
    value = _value;
    proposal = _proposal;
  }
  function disableSafeMode() public safe() returns(uint)  {
    require(msg.sender == creator);
    safeMode = false;
    return block.timestamp;
  }
  function getProposal() public view safe() returns(uint) {
    if (safeMode) require(msg.sender == creator);
    return proposal;
  }
  function getValue() public view safe() returns(string memory) {
    if (safeMode) require(msg.sender == creator);
    return value;
  }
  function getObject() public view safe() returns(address) {
    if (safeMode) require(msg.sender == creator);
    return object;
  }
  function getCreator() public view safe() returns(address) {
    if (safeMode) require(msg.sender == creator);
    return creator;
  }
}

contract Handshakes {
  address creator;
  address owner;
  mapping(address => uint) handshakes;
  mapping(address => uint) private shook;
  uint threshold;

  address proposal;
  uint proposalTime;

  bool corp;

  modifier owned () {
    if (corp) require(msg.sender == owner);
  }

  constructor(address[] memory _handshakes, address _owner, uint _threshold, bool corp) {
    creator = msg.sender;
    owner = _owner;
    proposal = proposal;
    if (threshold == 0) {
      threshold = _handshakes.length;
    } else {
      threshold = _threshold;
    }
    for (uint i = 0; i < _handshakes.length; i++) {
      handshakes[_handshakes[i]] = block.timestamp;
    }
  }
  function setProposal(address _proposal) public returns(uint) {
    proposal = _proposal;
    proposalTime = block.timestamp;
    return block.timestamp;
  }
  function isHandshake(address sender) public view returns(bool) {
    // review - owner and creator or just owner
    require(creator == msg.sender || owner == msg.sender);
    return handshakes[sender] != 0;
  }
  function isHandshake() public view returns(bool) {
    return handshakes[msg.sender] != 0;
  }
  function shake() public {
    shook[msg.sender] = block.timestamp;
  }
  // TODO - expiry on handshake check with greaterthan
  function check(address[] memory shakes, address[] memory noshakes) public owned {
    for (uint i = 0; i < shakes.length; i++) {
      require(handshakes[shakes[i]] != 0);
      require(shook[shakes[i]] != 0);
    }
    for (uint i = 0; i < noshakes.length; i++) {
      require(handshakes[noshakes[i]] != 0);
      require(shook[noshakes[i]] == 0);
    }
  }
}

contract gitarray {

  address creator;
  address owner;
  uint threshold;
  mapping(address => Handshakes) signers;
  mapping(address => Repo) repos;
  
  constructor(address[] memory _handshakes, address _owner) {
    threshold = _handshakes.length;
    creator = msg.sender;
    owner = _owner;
    Handshakes handshakes = new Handshakes(_handshakes, _owner, threshold);
    signers[msg.sender] = handshakes;
  }  
  // REVIEW - customizable threshold?
  function repo(address[] memory _handshakes, string memory _name, string memory _url, address _owner) public returns(uint) {
    Handshakes handshakes = new Handshakes(_handshakes, _owner, threshold);
    signers[msg.sender] = handshakes;
    Repo _repo = new Repo(_name, _url, _owner);
    repos[msg.sender] = _repo;
    // REVIEW - return repo object or address?
    return block.timestamp;
  }
  // TODO - commit with one or more handshakes

  function commit(address signer, string memory _message, string memory _author, string memory _date) public returns(uint) {
    Handshakes handshakes = signers[signer];
    Repo _repo = repos[signer];
    require(handshakes.isHandshake(msg.sender));
    //constructor(address _wallet, address _repo, string memory _message, string memory _author, string memory _date) {
    Commit _commit = new Commit(msg.sender, address(_repo), _message, _author, _date);
    _repo.commit(_commit, msg.sender);
    return block.timestamp;
  }

  // REVIEW - commit call total?
  //function commit()
  // REVIEW - in handshakes object
  // REVIEW - in gitorg library?
  // TODO - threshold adjustment
  //function threshold
  // TODO - add handshake
  //function handshake
  // TODO - remove handshake
  //function handshake
  // TODO - total recursive signers
  //function total
  // TODO - action with totaled handshakes
  //function action
  // TODO - set/get action or action list
  
}
