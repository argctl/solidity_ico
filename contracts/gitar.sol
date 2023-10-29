// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.20";
import "./gitarg.sol";

contract gitar {
  address public owner;
  address public _gitarg;
  gitarg private Gitarg;
  uint public price;
  bool public safe = false;
  bool public locked = false;
  uint public threshold;

  constructor (address gitarg_, uint _price, uint _threshold, uint ratio) {
    Gitarg = gitarg(gitarg_);
    if (ratio < 3) safe = true;
    require(Gitarg.balanceOf(msg.sender) >= Gitarg.totalSupply() / ratio);
    owner = msg.sender;
    _gitarg = gitarg_;
    price = _price;
    threshold = _threshold;
  }
  function lock () private {
    if (locked) lock();
    locked = true;
  }
  function g (uint tar) public payable returns (bool) {
    //require(locked == false, "Locke");
    require(locked == true, "Locke"); 
    if (Gitarg.balanceOf(owner) < threshold) {// || Gitarg.allowance(owner, address(this)) <= tar) {
      lock();
      return false;
    }
    uint targit = tar * price;
    require(msg.value > targit, "price");
    require(Gitarg.allowance(owner, address(this)) >= tar, "allowance");

    Gitarg.transferFrom(owner, msg.sender, tar);
    payable(owner).transfer(msg.value);
    return true;
  }
}
