// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.20";
import "./gitarg.sol";

interface ERC20 {
  function blanaceOf(address account) external view returns (uint256);
  function allowance(address _owner, address _spender) external view returns (uint256 remaining);
  function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
}

contract ratig {
  uint public rate;
  address public owner;
  address public GITARG;
  gitarg private arg;
  constructor (uint _rate, address _gitarg) {
    rate = _rate; 
    owner = msg.sender;
    GITARG = _gitarg;
    arg = gitarg(_gitarg);
  } 
  function g (uint amount, address _erc20, address _to) public returns (bool) {
    ERC20 erc20 = ERC20(_erc20);
    require(erc20.allowance(_to, address(this)) >= amount, "amount");
    require(arg.allowance(msg.sender, address(this)) >= amount, "tar");
    arg.transferFrom(msg.sender, _to, amount);
    erc20.transferFrom(_to, msg.sender, amount);
    return true;
  }
}
