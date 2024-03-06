// SPDX-License-Identifier: UNLICENSED
pragma solidity >="0.8.20";
// Intended use: exchange for services on gitarg decentralized platform and ada NFTs (release date June 2nd - June 15th 2023)
// NICE-TO-HAVES: 
// * lock password interface
// * unlock password interface
// * timestamp based lockout

contract gitarg {
  /*struct SpendDown {
    address owner;
    address spender;
    uint256 amount;
  } */
  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);


  mapping(address => mapping (address => uint256)) allowed;

  mapping(address => uint256) private balances;
  mapping(address => bool) private locked;

  uint256 totalSupply_ = 1000 ether;

  constructor() {
    balances[msg.sender] = totalSupply_;
  }
  function lock() public returns (bool) {
    locked[msg.sender] = true;
    return locked[msg.sender];
  }
  function unlock() public returns (bool) {
    locked[msg.sender] = false;
    return locked[msg.sender];
  }

  // ICO ERC-20 standard functions

  //https://eips.ethereum.org/EIPS/eip-20#name
  // function definition can be changed to pure - not in standard
  function name() public pure returns (string memory) {
    return "gitarg";  
  }
  //https://eips.ethereum.org/EIPS/eip-20#symbol
  // function definition can be changed to pure - not in standard
  function symbol() public pure returns (string memory) {
    return "GIT";
  }
  //https://eips.ethereum.org/EIPS/eip-20#decimals
  // function definition can be changed to pure - not in standard
  function decimals() public pure returns (uint8) {
    return 6;
  }
  //https://eips.ethereum.org/EIPS/eip-20#decimals
  // function definition can be changed to pure - not in standard
  function totalSupply() public view returns (uint256) {
    return totalSupply_;
  }
  function balanceOf(address _owner) public view returns (uint256 balance) {
    require(!locked[msg.sender] && !locked[_owner], "Locke's view");
    return balances[_owner];
  }
  function transfer(address _to, uint256 _value) public returns (bool success) {
    require(!locked[msg.sender] && !locked[_to], "Davy Jone's locker");
    require(_value <= balances[msg.sender], "treasure chest");
    balances[msg.sender] = balances[msg.sender] - _value;
    balances[_to] = balances[_to] + _value;
    emit Transfer(msg.sender, _to, _value);
    return true;
  }
  function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
    require(!locked[msg.sender] && !locked[_from] && !locked[_to], "Davy Jone's lockers");
    require(_value <= balances[_from], "treasure chest");
    require(_value <= allowed[_from][msg.sender], "iou");
    balances[_from] = balances[_from] - _value;
    allowed[_from][msg.sender] = allowed[_from][msg.sender] - _value;
    // _to should then be message sender
    balances[_to] = balances[_to] + _value;
    emit Transfer(_from, _to, _value);
    return true;
  }
  function approve(address _spender, uint256 _value) public returns (bool success) {
    require(!locked[msg.sender] && !locked[_spender], "locket");
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }
  function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
    // STYLEEE
    //for (uint i = 0; i < spendDownFunds.length; i++) {
     // if (spendDownFunds[i].spender == _spender && spendDownFunds[i].owner == _owner) {
      //  return spendDownFunds[i].amount;
      //}
    //}
    require(!locked[msg.sender] && !locked[_owner] && !locked[_spender], "closed locket");
    return allowed[_owner][_spender];
  }
}
