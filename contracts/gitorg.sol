// SPDX-License-Identifier: UNLICENSED
import "./gitarg.sol";
import "./objects/Proposal.sol";
pragma solidity >= "0.8.20";

contract gitorg {
  // sales/market/voting
  address private _gitarg;
  address public _gitarray;
  address private _rate;
  constructor(address gitarg_, address gitarray_) {
    _gitarg = gitarg_;
    _gitarray = gitarray_;
  }
  function rate (uint rate_) public {
    if (_rate == address(0)) {
      //constructor(uint _proposal, string memory _value, address _object) {
      // TODO - _uint object
      _rate = address(Proposal(address(this)));
    }
  }
}
