// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";

contract Proposal {
  address private object;
  address private creator;
  bool public safeMode = true;

  modifier safe () {
    if (safeMode) require(msg.sender == creator);
    _;
  }

  constructor(address _object) {
    creator = msg.sender;  
    object = _object;
  }
  function disableSafeMode() public safe() returns(uint)  {
    require(msg.sender == creator);
    safeMode = false;
    return block.timestamp;
  }
  function getObject() public view safe() returns(address) {
    if (safeMode) require(msg.sender == creator);
    return object;
  }
}
