pragma solidity >= "0.8.20";
import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "truffle/console.sol";
import "../contracts/objects/Repo.sol";
import "../contracts/gitarg.sol";
import "../contracts/gitarray.sol";
import "../contracts/libraries/gitorg.sol";

contract TestRepo {
  function testCreateRepo() public {
    //constructor(string memory _name, string memory _url, address _owner) payable {
    //constructor(string memory _name, string memory _url, address _owner, address _gitarg, address _gitarray) payable {
    Repo repo = new Repo("test", "test", tx.origin, DeployedAddresses.gitarg(), DeployedAddresses.gitarray());
    //Assert.isString(address(repo), "repo deployed");
    Assert.equal(address(repo), address(repo), "repo deployed");
    Assert.equal(address(repo) != address(0), true, "repo deployed");
    Assert.equal(abi.encodePacked(address(repo)).length, 20, "repo deployed");
  }
  // REVIEW - move
  function testGitorgHash() public {
    bytes32 hash_1 = gitorg.stamp("test", block.timestamp,tx.origin);
    bytes32 hash_2 = keccak256(abi.encodePacked("test", block.timestamp, tx.origin));
    //require(hash_1, hash_2);
    Assert.equal(hash_1, hash_2, "hashes match from gitorg call");
  }
  function testStamping() public {
    //console.log("timestamp: %o", block.timestamp);
    //Repo repo = Repo(DeployedAddresses.Repo());
    //constructor(string memory _name, string memory _url, address _owner, address _gitarg, address _gitarray) payable {

    Repo repo = new Repo("hashtest", "https://linkerfinder.com/", tx.origin, DeployedAddresses.gitarg(), DeployedAddresses.gitarray());
    string memory _hash = "1f8fb8d143a0873188c4ed36e843b911bf433e2c";
    uint timestamp = repo.stamp(_hash);
    bytes32 hash_ = repo._stamp(_hash, timestamp);
    bytes32 hash_1 = repo.verification(1);
    //bytes32 hash_2 = gitorg.stamp(_hash, timestamp, tx.origin);
    //bytes32 hash_2 = keccak256(abi.encodePacked(_hash, timestamp, tx.origin));
    Assert.equal(hash_1 == hash_, true, "hashes match when retrieved from repo");
  }
}
