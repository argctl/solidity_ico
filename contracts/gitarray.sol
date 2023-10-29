// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.20";
import "./giteta.sol";
import "./ltcgra.sol";
import "./gitarg.sol";
import "./argctl.sol";
import "./objects/Repo.sol";
//import "./objects/Proposal.sol";
import "./objects/Handshakes.sol";
import "./libraries/gitorg.sol";
import "./gitorg.sol";

// think identity
contract gitarray {

  address creator;
  address owner;
  uint threshold;
  mapping(address => Handshakes) signers;
  Handshakes handshakes;
  mapping(address => Repo) repos;
  mapping(bytes32 => uint) unique;
  // REVIEW - address only with check
  mapping(address => argctl) private ctls;
  address private arg;
  //address private _argctl;
  //address public _gitorg;
  mapping(address => _gitorg) private orgs;
  argctl private ARGCTL;
  address private eta;
  // !IMPORTANT
  // !!!
  // REVIEW - threshold divider 
  uint down_;
  uint tar_;
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
    handshakes = new Handshakes(_handshakes, _owner, threshold, true);
    signers[msg.sender] = handshakes;

  }  
  
  function proof () public view returns (address) {
    require(handshakes.isHandshake(msg.sender), "bluffalo");
    return arg;
  }
  function repo() public view returns (address) {
    // handshake in both repo and gitarray list
    require(handshakes.isHandshake(msg.sender), "raid");
    Repo repo_ = repos[msg.sender];
    //rar
    Handshakes handshakes_ = signers[address(repo_)];
    require(handshakes_.isHandshake(msg.sender), "arid");
    return address(repo_);
  }
  // REVIEW - customizable threshold?
  function repo(address[] memory _handshakes, string memory _name, string memory _url, address _owner, address _argctl) public returns(address) {
    // TODO - review handshakes check for gitarray to check if sender is handshake
    // REVIEW - corp var
    uint _stamp = unique[gitorg.key(_url)];
    require(_stamp == 0, "repo not unique"); 
    //require(msg.sender != creator);
    //constructor(string memory _name, string memory _url, address _owner, address _gitarg, address _gitarray) payable 
    Repo _repo = new Repo(_name, _url, _owner, arg, address(this));
    Handshakes handshakes_ = new Handshakes(_handshakes, _owner, threshold, true);
    repos[msg.sender] = _repo;
    argctl ctl = argctl(_argctl);
    ctl.checkin(address(_repo), address(handshakes));
    signers[address(_repo)] = handshakes_;
    // REVIEW - return repo object or address?
    unique[gitorg.key(_url)] = block.timestamp;
    return address(_repo);
  }
  function ctl (address handshake) public returns (bool) {
    ctls[handshake] = argctl(msg.sender);
    return true;
  }
  function org () public returns (bool) {
    orgs[msg.sender] = _gitorg(msg.sender);
    return true;
  }
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
  //function isHandshake(address repo, address handshake) public returns (bool) {
    //require(msg.sender == _argctl, "the argctl address equals the address of argctl");
    //Handshakes _handshakes = signers[handshake];
    //return _handshakes.isHandshake(handshake);
  //}
}
