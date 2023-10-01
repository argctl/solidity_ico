// SPDX-License-Identifier: UNLICENSED
pragma solidity >= "0.8.20";
import "./_type.sol";

contract _uint is _type {
  uint private xy; 
  constructor(uint R) {
    xy = R;
  }
  function time () public OUR {
    emit dens(abi.encodePacked(xy)); 
  }
}
