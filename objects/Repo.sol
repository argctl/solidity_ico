// SPDX-License-Identifier: UNLICENSED
// TODO - change to unlicense (unlinsenced?) 
pragma solidity >= "0.8.18";

contract Repo {

  string name;
  string url;
  address owner;
  mapping(address => uint) buyerContributions;
  address[] buyers;
  uint value;

  modifier seller (address payable _seller) {
    require(msg.sender == owner && _seller == owner);
    _;
  }
  
  constructor(string memory _name, string memory _url) payable {
    name = _name;
    url = _url;
    owner = msg.sender;
    value = msg.value;
  }
  function sell(address _owner, address payable _seller, uint _value) public seller(_seller) {
    require(_value <= value);
    uint diff = value - _value;
    value = diff;
    _seller.transfer(_value);
    owner = _owner;
  }
  function add() payable public {
    if(buyerContributions[msg.sender] == 0) buyers.push(msg.sender);
    buyerContributions[msg.sender] = msg.value; 
    value += msg.value;
  }
  // sell by value of buyer (_owner)
  function safeSell(address _owner, address payable _seller, uint _value) public seller(_seller) {
    
  }
  // sell by highest value
  function highSell(address _owner, address payable _seller) public seller(_seller) {
    uint _value;
    for(uint i = 0; i < buyers.length; i++) {
      uint amount = buyerContributions[buyers[i]];
      if (value > _value) _value = amount;
    }
    this.sell(_owner, _seller, _value);
  }
}
