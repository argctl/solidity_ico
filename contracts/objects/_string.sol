// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;
import "./_type.sol";

contract _string is _type {
  string private S;
  constructor (string memory N) {
    S = N;
  }
  function time () public override OUR {
    emit dens(abi.encodePacked(S)); 
  } 
  function string_ () public override OUR returns (string memory) {
    return S;
  }
}
