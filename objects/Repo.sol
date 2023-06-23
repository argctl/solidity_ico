// SPDX-License-Identifier: UNLICENSED
// TODO - change to unlicense (unlinsenced?) 
pragma solidity >= "0.8.18";

contract Repo {

  string name;
  string url;
  address owner;
  uint value;
  
  constructor(string memory _name, string memory _url) payable {
    name = _name;
    url = _url;
    owner = msg.sender;
    value = msg.value;
  }
  function sell(address _owner, address payable _seller, uint _value) public {
    require(msg.sender == owner && _seller == owner);
    require(_value <= value);
    uint diff = value - _value;
    value = diff;
    _seller.transfer(_value);
    owner = _owner;
  }
}
