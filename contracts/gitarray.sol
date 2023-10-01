// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";
import "./giteta.sol";
import "./gitarg.sol";
import "./argctl.sol";
import "./objects/Repo.sol";
//import "./objects/Proposal.sol";
import "./objects/Handshakes.sol";
import "./libraries/gitorg.sol";

contract gitarray {

  address creator;
  address owner;
  uint threshold;
  mapping(address => Handshakes) signers;
  Handshakes handshakes;
  mapping(address => Repo) repos;
  mapping(bytes32 => uint) unique;
  address private arg;
  // !IMPORTANT
  // !!!
  // REVIEW - threshold divider 
  constructor(address[] memory _handshakes, address _owner, address _gitarg) {
    arg = _gitarg;
    threshold = _handshakes.length;
    creator = msg.sender;
    owner = _owner;
    // REVIEW - corp var
    handshakes = new Handshakes(_handshakes, _owner, threshold, true);
    signers[msg.sender] = handshakes;
  }  
  function proof () public view returns (address) {
    require(handshakes.isHandshake(msg.sender), "bluffalo");
    return arg;
  }
  // REVIEW - customizable threshold?
  function repo(address[] memory _handshakes, string memory _name, string memory _url, address _owner, address _argctl) public returns(uint) {
    // REVIEW - corp var
    uint _stamp = unique[gitorg.key(_url)];
    require(_stamp == 0, "repo not unique"); 
    //require(msg.sender != creator);
    //constructor(string memory _name, string memory _url, address _owner, address _gitarg, address _gitarray) payable 
    Repo _repo = new Repo(_name, _url, _owner, arg, address(this));
    Handshakes handshakes = new Handshakes(_handshakes, _owner, threshold, true);
    repos[msg.sender] = _repo;
    argctl ctl = argctl(_argctl);
    ctl.checkin(address(_repo), address(handshakes));
    signers[address(_repo)] = handshakes;
    // REVIEW - return repo object or address?
    unique[gitorg.key(_url)] = block.timestamp;
    return block.timestamp;
  }
}
