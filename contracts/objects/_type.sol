// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;

contract _type {
  address public O;
  event dens(bytes T);
  modifier OUR {
    require(O == msg.sender, "sour");
    _;
  }
  constructor () {
    O = msg.sender;  
  }
  function send(address U) public OUR {
    O = U;
  }
  function time () public virtual {}
  function int_() public virtual returns (int) {}
  function uint_() public virtual returns (uint) {}
  function string_() public virtual returns (string memory) {}
  function address_() public virtual returns (address) {}
}
