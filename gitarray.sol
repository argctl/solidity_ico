// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";
import "./giteta.sol";
//import "./libraries/gitorg.sol";
import "./gitarg.sol";
import "./objects/Repo.sol";
import "./objects/Commit.sol";

contract Handshakes {
  address creator;
  address owner;
  mapping(address => uint) handshakes;
  constructor(address[] memory _handshakes, address _owner) {
    creator = msg.sender;
    owner = _owner;
    for (uint i = 0; i < _handshakes.length; i++) {
      handshakes[_handshakes[i]] = block.timestamp;
    }
  }
}

contract gitarray {

  address creator;
  address owner;
  uint threshold;
  mapping(address => Handshakes) signers;
  mapping(address => Repo) repos;
  
  constructor(address[] memory _handshakes, address _owner) {
    threshold = _handshakes.length;
    creator = msg.sender;
    owner = _owner;
    Handshakes handshakes = new Handshakes(_handshakes, _owner);
    signers[msg.sender] = handshakes;
  }  
  //constructor(string memory _name, string memory _url, address _owner) payable {
  function repo(address[] memory _handshakes, string memory _name, string memory _url, address _owner) public returns(uint) {
    Handshakes handshakes = new Handshakes(_handshakes, _owner);
    signers[msg.sender] = handshakes;
    Repo _repo = new Repo(_name, _url, _owner);
    repos[msg.sender] = _repo;
    // REVIEW - return repo object or address?
    return block.timestamp;
  }
  // TODO - commit with one or more handshakes
  // REVIEW - commit call total?
  //function commit()
  // REVIEW - in handshakes object
  // REVIEW - in gitorg library?
  // TODO - threshold adjustment
  //function threshold
  // TODO - add handshake
  //function handshake
  // TODO - remove handshake
  //function handshake
  // TODO - total recursive signers
  //function total
  // TODO - action with totaled handshakes
  //function action
  // TODO - set/get action or action list
  
}
