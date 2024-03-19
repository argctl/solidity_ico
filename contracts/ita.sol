// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.20;

interface ERC20 {
  //function allowance(address _owner, address _spender) external view returns (uint256 remaining);
  function approve(address _spender, uint amount) external returns (bool);
} 

contract ita {
  mapping(address => uint) private owners;
  uint public creation;
  address[] private owners_;
  constructor (address[] memory _owners) {
    owners_ = _owners;
    creation = block.timestamp + _owners.length;
    for (uint i = 0; i < _owners.length; i++) {
      owners[_owners[i]] = block.timestamp;
    }
  }
  // TODO - secondary owners list
  function allow (address token, uint amount) public returns (bool) {
    require(owners[msg.sender] == creation - owners_.length, "own");
    ERC20 erc20 = ERC20(token);
    return erc20.approve(msg.sender, amount);
  }
}
