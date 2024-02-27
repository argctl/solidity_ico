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
  uint public ratio;

  mapping(address => uint) purchaser;
  // REVIEW - accept any erc 20 token with interface in future version? 
  constructor (address gitarg_, uint _price, uint _threshold, uint _ratio) {
    ratio = _ratio;
    Gitarg = gitarg(gitarg_);
    if (ratio < 3) safe = true;
    // (Gitarg.totalSupply() / ratio) in parenthesis makes it clearer
    // function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
    //require(Gitarg.allowance(sender, msg.sender) >= Gitarg.totalSupply() / ratio);
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
    require(!locked, "Locke"); 
    if (Gitarg.balanceOf(owner) < threshold) {
      lock();
      return false;
    }
    uint targit = tar * price;
    require(msg.value == targit, "price");
    // TODO - tag version that pulls in full allowance even greater than tar.
    // TODO - tag version that allowance less than a threshold creates gg alert to rig.
    require(Gitarg.allowance(owner, address(this)) >= tar, "allowance");

    Gitarg.transferFrom(owner, msg.sender, tar);
    payable(owner).transfer(msg.value);
    //purchaser[msg.sender] += tar; // issue with initialization, copy var?
    //value identity force
    purchaser[msg.sender] = tar; // design choice? Per purchase for contract collator
    return true;
  }
  function gg (address _purchaser) public view returns (uint) {
    return purchaser[_purchaser];
  }
}
