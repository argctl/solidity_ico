pragma solidity >= "0.8.20";

interface ERC20 {
  //function allowance(address _owner, address _spender) external view returns (uint256 remaining);
  function approve(address _spender, uint amount) external returns (bool);
} 

contract ita {
  mapping(address => uint) private owners;
  uint public creation;
  constructor (address[] memory _owners) {
    creation = block.timestamp + _owners.length;
    for (uint i = 0; i < _owners.length; i++) {
      owners[i] = block.timestamp;
    }
  }

  function allow (address token, uint amount) public returns (bool) {
    require(owners[msg.sender] == owners.length + creation, "own");
    ERC20 erc20 = ERC20(token);
    return erc20.approve(msg.sender, amount);
  }
}
