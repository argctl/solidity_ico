// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";
import "./giteta.sol";
import "./gitarg.sol";
import "./objects/Repo.sol";
import "./objects/Proposal.sol";
import "./objects/Handshakes.sol";
import "./libraries/gitorg.sol";

contract gitarray {

  address creator;
  address owner;
  uint threshold;
  mapping(address => Handshakes) signers;
  mapping(address => Repo) repos;
  mapping(bytes32 => uint) unique;
  address public arg;
  // !IMPORTANT
  // !!!
  // REVIEW - threshold divider 
  constructor(address[] memory _handshakes, address _owner, address _gitarg) {
    arg = _gitarg;
    threshold = _handshakes.length;
    creator = msg.sender;
    owner = _owner;
    //constructor(address[] memory _handshakes, address _owner, uint _threshold, bool _corp) {
    // REVIEW - corp var
    Handshakes handshakes = new Handshakes(_handshakes, _owner, threshold, true);
    signers[msg.sender] = handshakes;
  }  
  // REVIEW - customizable threshold?
  function repo(address[] memory _handshakes, string memory _name, string memory _url, address _owner) public returns(uint) {
    // REVIEW - corp var
    uint _stamp = unique[gitorg.key(_url)];
    require(_stamp == 0, "repo not unique"); 
    Handshakes handshakes = new Handshakes(_handshakes, _owner, threshold, true);
    signers[msg.sender] = handshakes;
    //constructor(string memory _name, string memory _url, address _owner, address _gitarg, address _gitarray) payable {
    Repo _repo = new Repo(_name, _url, _owner, arg, address(this));
    repos[msg.sender] = _repo;
    // REVIEW - return repo object or address?
    unique[gitorg.key(_url)] = block.timestamp;
    return block.timestamp;
  }
  // TODO - commit with one or more handshakes
  function commit(address signer, string memory _message, string memory _author, string memory _date) public returns(uint) {
    Handshakes handshakes = signers[signer];
    Repo _repo = repos[signer];
    require(handshakes.isHandshake(msg.sender));
    uint extTimestamp = gitorg.timestamp();
    //function stamp (string memory _hash, uint timestamp, address _msgSender) public pure returns (bytes32) {
    bytes32 hash = gitorg.stamp(_message, extTimestamp, msg.sender);
    //constructor(address _wallet, address _repo, string memory _message, string memory _author, string memory _date) {

    return block.timestamp;
  }
  // HERE - function approve
  // REVIEW - commit call total?
  //function commit()
  // REVIEW - in handshakes object
  // REVIEW - in gitorg library?
  // TODO - threshold adjustment
  //function threshold
  // TODO - add handshake
  //function handshake
  // TODO - remove handshake
  //function total
  // TODO - action with totaled handshakes
  //function action
  // TODO - set/get action or action list
  
}
