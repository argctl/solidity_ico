// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";
import "./giteta.sol";
//import "./libraries/gitorg.sol";
import "./gitarg.sol";

abstract contract gitarray {
  
  mapping(address => uint) handshakes;
  constructor(address[] memory _handshakes) {
    for (uint i = 0; i < _handshakes.length; i++) {
      handshakes[_handshakes[i]] = block.timestamp;
    }
  }  
  
}
