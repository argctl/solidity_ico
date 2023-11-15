pragma solidity >= "0.8.20";
import "./gitarg.sol";

interface ERC20 {
  function blanaceOf(address account) external view returns (uint256);
  function allowance(address _owner, address _spender) public view returns (uint256 remaining);
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
}

contract ratig {
  uint public rate
  address public owner;
  address public arg;
  constructor (uint _rate, address _gitarg) {
    rate = _rate; 
    owner = msg.sender();
    gitarg arg = gitarg(_gitarg);
  } 
  function g (uint amount, address _erc20) public returns (bool) {
    //payable(msg.sender).transfer(
    ERC20 erc20 = ERC20(_erc20);
    require(erc20.allowance(msg.sender, address(this)) >= amount, "amount");
    require(arg.allowance(msg.sender, address(this)) >= amount, "tar");
    arg.transferFrom(msg.sender, owner, amount);
    erc20.transferFrom(msg.sender, owner, amount);
  }
}
