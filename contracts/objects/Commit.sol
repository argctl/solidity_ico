// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.20;
import "../gitarg.sol";

contract Commit {
  address public repo;
  // private wallet that can be made public might just need a check
  // the rest of the variables need access from repo
  // could put it in a struct
  struct Data {
    address wallet;
    string message;
    string author;
    string date;
  }
  uint private hashTime;
  bytes private hash;
  Data private data;
  // should the hash time be public?

  address public creator; // likely giteta contract
  // code cost

  modifier auth () {
    require(creator == msg.sender || data.wallet == msg.sender, "non authorized user");
    _;
  }
  constructor(address _wallet, address _repo, string memory _message, string memory _author, string memory _date) {
    creator = msg.sender;
    repo = _repo;
    data = Data(_wallet, _message, _author, _date);
  }

  function setCodeHash(bytes memory _hash) public returns (uint) {
    require(hash.length == 0);
    hash = _hash;
    hashTime = block.timestamp;
    return hashTime;
  }
  function getData() public view auth returns (Data memory) {
    return data;
  }
  // REVIEW - change parameter list to include value instead of approving full balance
  function approve(address _gitarg, address _wallet) public auth {
    gitarg Gitarg = gitarg(_gitarg);
    //function approve(address _spender, uint256 _value) public returns (bool success)
    Gitarg.approve(_wallet, Gitarg.balanceOf(address(this)));
  }
}
