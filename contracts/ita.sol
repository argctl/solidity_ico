// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.20";

interface ERC20 {
  //function allowance(address _owner, address _spender) external view returns (uint256 remaining);
  function approve(address _spender, uint amount) external returns (bool);
} 

contract ita {
  mapping(uint => address) private owners;
  uint public creation;
  constructor (address[] memory _owners) {
    creation = block.timestamp + _owners.length;
    for (uint i = 0; i < _owners.length; i++) {
      owners[block.timestamp + i] = _owners[i];
    }
  }

  function allow (address token, uint amount, uint i) public returns (bool) {
    require(owners[creation + i] == msg.sender, "own");
    ERC20 erc20 = ERC20(token);
    return erc20.approve(msg.sender, amount);
  }
}
