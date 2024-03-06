// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;
import "./_type.sol";

contract _address is _type {
  address private A;

  //event ISITREADYYET(address a);

  constructor (address a) {
    A = a;
  }
  function time () public override OUR {
    emit dens(abi.encodePacked(A));
    //emit ISITREADYYET(A);
  }
  function address_ () public override OUR returns (address) {
    return A;
  }
}
