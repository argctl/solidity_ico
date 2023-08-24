// SPDX-License-Identifier: UNLICENSED
// TODO - change to unlicense (unlinsenced?) 
pragma solidity >= "0.8.18";

import "./Commit.sol";

contract Repo {

  string public name;
  string public url;
  address public owner;
  address gitArrayInstance;
  mapping(address => uint) public buyerContributions;
  address[] buyers;
  uint public value;
  Commit[] commits;
  mapping (address => Commit) contributorCommits;

  // v
  address creator;

  modifier seller (address payable _seller) {
    require(msg.sender == owner && _seller == owner, "owner-seller auth failure");
    _;
  }
  modifier owned () {
    require(msg.sender == owner);
    _;
  }

  modifier created () {
    require(msg.sender == creator);
    _;
  }
  
  function commit(Commit _commit, address sender) public returns(uint) {
    commits.push(_commit);//i
    contributorCommits[sender] = _commit;
    return block.timestamp;
  }
  
  constructor(string memory _name, string memory _url, address _owner) payable {
    creator = msg.sender;
    name = _name;
    url = _url;
    owner = _owner;
    gitArrayInstance = msg.sender;
    value = msg.value;
  }
  // TODO
  function sell(address _owner, address payable _seller, uint _value) public seller(_seller) {
    require(_value <= value, "value transfer is less than amount in contract");
    //require(_seller == owner, "owner is the seller");
    //require(msg.sender == owner, "owner is sender");
    uint diff = value - _value;
    value = diff;
    _seller.transfer(_value);
    owner = _owner;
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
        this.sell(_owner, _seller, _value);
        break;
      }
    }   
  }
  // sell by highest value
  function highSell(address _owner, address payable _seller) public seller(_seller) {
    uint _value;
    for(uint i = 0; i < buyers.length; i++) {
      uint amount = buyerContributions[buyers[i]];
      if (value > _value) _value = amount;
    }
    // we don't care about the bid, just the highest value
    this.sell(_owner, _seller, _value);
  }
}
