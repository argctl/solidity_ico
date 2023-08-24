pragma solidity >= "0.8.20";
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "truffle/console.sol";
import "../contracts/objects/Repo.sol";

contract TestRepo {
  function testCreateRepo() public {
    //constructor(string memory _name, string memory _url, address _owner) payable {
    Repo repo = new Repo("test", "test", tx.origin);
    //Assert.isString(address(repo), "repo deployed");
    console.log("Assert");
    Assert.equal(address(repo), address(repo), "repo deployed");
    Assert.equal(address(repo) != address(0), true, "repo deployed");
    Assert.equal(abi.encodePacked(address(repo)).length, 20, "repo deployed");
  }
}
