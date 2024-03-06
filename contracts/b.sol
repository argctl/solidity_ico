pragma solidity 0.8.20;
import "./bs.sol";
import "./gitarg.sol";

contract b {
  address public owner;
  constructor () {
    owner = address(new bs()); 
    gitarg Gitarg = new gitarg();
  }
}
