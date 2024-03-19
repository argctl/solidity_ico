pragma solidity 0.8.20;
import "./ita.sol";
/*
interface ERC20 {
  //function allowance(address _owner, address _spender) external view returns (uint256 remaining);
  function approve(address _spender, uint amount) external returns (bool);
} 
*/
contract ati is ita {
  constructor (address[] memory owners) ita(owners) {
  // TODO - store owners? - REVIEW
  }
  function fullfill (address token, address[] memory spenders, uint amount) public returns (uint) {
    // TODO - attempt allow on parrent
    for (uint i = 0; i < spenders.length; i++) {
      bool user = allow(token, amount);
      require(user, "spender is user");
      // TODO - transferFrom? - is from sender or is this address?
    }
    return 0;
  } 
}
