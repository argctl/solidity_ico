// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";

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
