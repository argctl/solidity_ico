pragma solidity 0.8.20;

contract bs {
  address public owner;
  constructor () {
    owner = msg.sender;
  }
  function t () public payable {
    payable(owner).transfer(msg.value); 
  } 
}
