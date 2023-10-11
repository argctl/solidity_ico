// SPDX-License-Identifier: UNLICENSED
pragma solidity >= "0.8.20";
import "./_type.sol";

contract _int is _type {
  int private o;
  constructor (int m) {
    o = m; 
  }
  function time () public OUR {
    emit dens(abi.encodePacked(o));
  }
}
