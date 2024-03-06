// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.20;
import "./gitarg.sol";
import "./gitar.sol";

interface ERC20 {
  function blanaceOf(address account) external view returns (uint256);
  function allowance(address _owner, address _spender) external view returns (uint256 remaining);
  function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
}

contract ratig {
  address public owner;
  address public GITARG;
  address public GITAR;
  gitarg private arg;
  gitar private tar;
  constructor (address _gitarg, address _gitar) {
    owner = msg.sender;
    GITARG = _gitarg;
    GITAR = _gitar;
    arg = gitarg(_gitarg);
    tar = gitar(_gitar);
  } 
  function g (uint amount, address _erc20, address _to) public returns (bool) {
    ERC20 erc20 = ERC20(_erc20);
    require(erc20.allowance(_to, address(this)) >= amount, "amount");
    require(arg.allowance(msg.sender, address(this)) >= amount, "tar");
    require(tar.gg(msg.sender) >= amount, "rat");
    arg.transferFrom(msg.sender, _to, amount);
    erc20.transferFrom(_to, msg.sender, amount);
    return true;
  }
}
