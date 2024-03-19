// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.20;
import "./giteta.sol";
//import "./ltcgra.sol";
import "./gitarg.sol";
import "./argctl.sol";
import "./objects/Repo.sol";
//import "./objects/Proposal.sol";
import "./objects/Handshakes.sol";
//import "./libraries/gitorg.sol";

import "./gitorg.sol";

// think identity
contract gitarray {

  address creator;
  address owner;
  uint threshold;
  mapping(address => Handshakes) signers;
  Handshakes private handshakes;
  mapping(address => Repo) repos;
  //mapping(bytes32 => uint) unique;
  // REVIEW - address only with check
  mapping(address => argctl) private ctls;
  address private arg;
  //address private _argctl;
  //address public _gitorg;
  mapping(address => _gitorg) public orgs;
  argctl private ARGCTL;
  address private eta;
  // !IMPORTANT
  // !!!
  // REVIEW - threshold divider 
  //uint down_;
  //uint tar_;
  modifier own {
    require(msg.sender == owner, "own");
    _;
  }
  constructor(address[] memory _handshakes, address _owner, address _gitarg, address _giteta) {
    arg = _gitarg;
    eta = _giteta;
    threshold = _handshakes.length;
    creator = msg.sender;
    owner = _owner;
    //_gitorg = gitorg_;
    // REVIEW - corp var
    // corp set to true indication of member for isHandshake, but member is already only check - caching?
    // TODO - corp var should likely be set to false? or is this the setter and handshakes interface? review in GITORG.ORG code
    // push loop?
    // ineffecient compare effeciency with seperate addHandshake calls and BL issues with unstopper
    address[] memory _handshakes_ = new address[](_handshakes.length + 1);
    for (uint i = 0; i < _handshakes.length; i++) {
        _handshakes_[i] = _handshakes[i];
    }
    _handshakes_[_handshakes.length] = address(this);
    // owner should be owner address or should be be array address and effect corp var?
    handshakes = new Handshakes(_handshakes_, _owner, threshold, true);
    signers[msg.sender] = handshakes;

  }  
  /* 
  function proof () public view returns (address) {
    require(handshakes.isHandshake(msg.sender), "bluffalo");
    return arg;
  }
*/
  function repo() public view returns (address) {
    // handshake in both repo and gitarray list

    require(handshakes.isHandshake(msg.sender), "raid");
    //Repo repo_ = repos[handshake];
    Repo repo_ = repos[msg.sender];
    //rar
    Handshakes handshakes_ = signers[address(repo_)];
    require(handshakes_.isHandshake(msg.sender), "arid");
    return address(repo_);
  }
  // REVIEW - customizable threshold?
  function repo(address[] memory _handshakes, string memory _name, string memory _url, address _owner, address _argctl) public returns (address) {
    //require(handshakes.isHandshake(msg.sender), "array");
    // TODO - review handshakes check for gitarray to check if sender is handshake
    // REVIEW - corp var
    Repo _repo = new Repo(_name, _url, _owner, arg, address(this));
    address repo_ = address(_repo);
    Handshakes handshakes_ = new Handshakes(_handshakes, _owner, threshold, true);
    require(handshakes_.isHandshake(msg.sender), "git");
    require(address(repos[_owner]) == address(0), "owner");
    repos[_owner] = _repo;
    argctl ctl = argctl(_argctl);
    ctl.checkin(repo_, address(handshakes_), _owner);
    signers[repo_] = handshakes_;
    return repo_;
  }
  function ctl (address handshake) public returns (bool) {
    // TODO - review handshake check?
    require(address(ctls[handshake]) == address(0), "");
    ctls[handshake] = argctl(msg.sender);
    return true;
  }
  function org (address org) public returns (bool) {
    orgs[msg.sender] = _gitorg(org);
    return orgs[msg.sender]._gitarg() == arg;
  }
/*
  function tar () public payable {
    //slow movement to prevent theft
    tar_ += msg.value;
  }
  function git (address _repo) public payable {
    // require the repo map to the gas type?
    //called on commit in argctl to drain tar
  }
  function down () public payable {
    //place ether down to prove value
    down_ += msg.value;
  }
*/
  //function isHandshake(address repo, address handshake) public returns (bool) {
    //require(msg.sender == _argctl, "the argctl address equals the address of argctl");
    //Handshakes _handshakes = signers[handshake];
    //return _handshakes.isHandshake(handshake);
  //}
}
