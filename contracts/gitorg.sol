// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;
import "./gitarg.sol";
import "./gitarray.sol";
import "./objects/Proposal.sol";
import "./objects/Handshakes.sol";

contract _gitorg {
  // sales/market/voting
  address private _gitarg;
  address public _gitarray;
  address private _rate;
  // trope - gitarray needed?
  constructor(address gitarg_, address gitarray_) {
  //constructor(address gitarg_) {
    _gitarg = gitarg_;
    _gitarray = gitarray_;
    gitarray _gitarray_ = gitarray(gitarray_);
    _gitarray_.org();
  }
  function rate (uint rate_) public {
    if (_rate == address(0)) {
      //constructor(uint _proposal, string memory _value, address _object) {
      // TODO - _uint object
      _rate = address(Proposal(address(this)));
    }
  }
  //function listing (address _repo, uint price) public {
  function listing () public {
  }
  //function list (address _repo) public {

  function list (address _proposal) public {
    // TODO - call?
  }
  function open (address _proposal) public {
    // TODO - send _type from proposal
  }
  //function _gitarray_
}
