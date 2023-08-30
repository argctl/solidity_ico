// SPDX-License-Identifier: UNLICENSED
// REVIEW - change to unlicense (unlinsenced?) 
// Public Information Transaction System(s)
// Content/Media Distribution Placement/Network
pragma solidity >= "0.8.18";

import "./Commit.sol";
import "../libraries/gitorg.sol";
import "truffle/console.sol";

contract Repo {

  string public name;
  string public url;
  address public owner;
  bytes32[] private hash;
  address private array;
  address private arg;
  mapping(address => uint) private buyerContributions;
  address[] private buyers;
  uint public value;
  Commit[] commits;
  mapping (address => Commit) contributorCommits;

  // v
  address private creator; 
  bool private flag;
  mapping(address => uint) public allowed;
  // workers rights
  mapping(address => uint) private revoked;

  event Stamp(bytes32 hash);
  event Timestamp(uint timestamp);

  modifier seller (address payable _seller) {
    require(msg.sender == owner && _seller == owner, "owner-seller auth failure");
    _;
  }
  modifier owned () {
    require(msg.sender == owner, "owner auth failure");
    _;
  }
  modifier created () {
    require(msg.sender == creator, "creator auth failure");
    _;
  }
  modifier auth () {
    // 🤯
    require(allowed[msg.sender] > revoked[msg.sender], "the sender's timestamp was revoked more recently");
    _;
  }
  function allow (address _allow) public owned  {
    allowed[_allow] = block.timestamp;
  }
  function revoke (address _disallow, bool clean) public owned {
    if (clean) allowed[_disallow] = 1; // 1 makes them still appear on the list if queried directly for the name
    revoked[_disallow] = block.timestamp;
  }
  constructor(string memory _name, string memory _url, address _owner, address _gitarg, address _gitarray) payable {
    if(_gitarray != msg.sender) flag = true;
    creator = msg.sender;
    name = _name;
    url = _url;
    owner = _owner;
    array = msg.sender;
    arg = _gitarg;
    value = msg.value;
    // TODO - gitarray compare for url
    allowed[msg.sender] = block.timestamp;
    allowed[_owner] = block.timestamp;
    allowed[creator] = block.timestamp;
    hash.push(keccak256(abi.encodePacked(url, block.timestamp, msg.sender)));
  }
  // REVIEW - should the stamp check for gitarray
  function stamp(string memory _hash) public auth returns (uint) {
    hash.push(gitorg.stamp(_hash, block.timestamp, msg.sender));
    emit Timestamp(block.timestamp);
    return block.timestamp;
  }
  function _stamp(string memory _hash, uint timestamp) public auth returns (bytes32) {
    bytes32 hash_ = keccak256(abi.encodePacked(_hash, timestamp, msg.sender));
    emit Stamp(hash_);
    return hash_;
  }
  // defaults to 0
  function verification(uint iteration) public auth returns (bytes32) {
    // REVIEW - can call gitarg directly?
    bytes32 hash_ = hash[iteration];
    emit Stamp(hash_);
    return hash_;
  }
  // verify with gitarray address also verified
  function verification(address payable _gitarray, uint iteration) public auth returns (bytes32) {
    require(_gitarray == creator, "verification address is not creator");
    // REVIEW - can call gitarg directly?
    bytes32 hash_ = hash[iteration];
    emit Stamp(hash_);
    return hash_;
  }
  function verify() public view returns (bool) {
    return false;
  }
  function commit(Commit _commit, address sender) public returns(uint) {
    commits.push(_commit);//i
    contributorCommits[sender] = _commit;
    return block.timestamp;
  }
  
  function _sell(address _owner, address payable _seller, uint _value) internal {
    require(_value <= value, "value transfer is less than amount in contract");
    // REVIEW - ledger should be enough - gitarg integration may change this in layer 4-5
    for (uint i = 0; i < buyers.length; i++) {
      buyerContributions[buyers[i]] = 0;
    }
    delete buyers;
    value -= _value;
    _seller.transfer(_value);
    owner = _owner;
  }
  // TODO - ?
  function sell(address _owner, address payable _seller, uint _value) public seller(_seller) {
    _sell(_owner, _seller, _value);
  }
  // if it is a bid change from += to = for [msg.sender]
  function add() payable public {
    if(buyerContributions[msg.sender] == 0) buyers.push(msg.sender);
    buyerContributions[msg.sender] += msg.value; 
    value += msg.value;
  }
  // sell by value of buyer (_owner)
  function safeSell(address _owner, address payable _seller, uint _value) public seller(_seller) {
    for(uint i = 0; i < buyers.length; i++) {
      uint amount = buyerContributions[buyers[i]];
      if (_value == amount) {
        require(buyers[i] == _owner);
        _sell(_owner, _seller, _value);
        break;
      }
    }   
  }
  // REVIEW - query functions in different standard?
  // REVIEW - private?
  function high() public view returns (uint) {
    uint _amount;
    for(uint i = 0; i < buyers.length; i++) {
      uint amount = buyerContributions[buyers[i]];
      if (amount >= _amount) {
        _amount = amount;
      }
    }
    return _amount;
  }
  // REVIEW - ethics
  function high(address payable _seller) public view seller(_seller) returns (address) {
    uint _amount;
    address _owner;
    for(uint i = 0; i < buyers.length; i++) {
      uint amount = buyerContributions[buyers[i]];
      if (_amount < amount) {
        _amount = amount;
        _owner = buyers[i];
      }
    }
    return _owner;
  }
  // sell by highest value
  function highSell(address payable _seller) public seller(_seller) {
    uint _amount;
    address _owner;
    for(uint i = 0; i < buyers.length; i++) {
      uint amount = buyerContributions[buyers[i]];
      if (_amount < amount) {
        _amount = amount;
        _owner = buyers[i];
      }
    }
    // we don't care about the bid, just the highest value
    _sell(_owner, _seller, _amount);
  }
  function _buyerContributions(address buyer) public auth returns (uint) {
    return buyerContributions[buyer];
  }
}
