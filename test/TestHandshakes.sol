pragma solidity >= "0.8.20"; // ~
import "../contracts/objects/Handshakes.sol";
import "truffle/DeployedAddresses.sol";
import "truffle/Assert.sol";

contract TestHandshakes {
  function testEpoch () public {
    //Handshakes handshakes = Handshakes(DeployedAddresses.Handshakes());
    //constructor(address[] memory _handshakes, address _owner, uint _threshold, bool _corp) {
    address[] memory accounts = new address[](1);
    accounts[0] = tx.origin;
    Handshakes handshakes = new Handshakes(accounts, tx.origin, 3, false);
    //handshakes.epoch();
  }
}
