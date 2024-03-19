// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.20;
import "./gitorg.sol";
import "./libraries/gitorg.sol";
import "./gitarg.sol";
//import "./objects/Proposal.sol";
import "./objects/Handshakes.sol";
import "./gitarray.sol";
//import "./ltcgra.sol";
import "./objects/Repo.sol";
import "./giteta.sol";


//spawner
contract argctl {
  address private _gitorg_;
  address private _giteta_;
  _gitorg  private Gitorg;
  address public _gitarg;
  address private _handshakes;
  mapping(bytes32 => uint) public unique;
  Handshakes handshakes;
  gitarray Gitarray;
  gitarg Gitarg;
  struct Sign {
    address repo;
    address gitarray;
    address handshakes;
  }
  mapping(address => Sign) private repos;

  // TODO - handshake checkmarks for preverification or creation from gitarray?
  // interface
  /// trope
  constructor (address handshakes_, address gitorg_, address gitarg_, address _gitarray, address _giteta) {
  //constructor (address handshakes_, address gitorg_, address gitarg_, address _gitarray) {
    _gitarg = gitarg_;
    _gitorg_ = gitorg_;
    _giteta_ = _giteta;
    Gitarg = gitarg(gitarg_);
    Gitorg = _gitorg(gitorg_);
    _handshakes = handshakes_;
    handshakes = Handshakes(handshakes_);
    Gitarray = gitarray(_gitarray);
    Gitarray.ctl(msg.sender);
  }

  function proof () public view returns (address) {
    require(handshakes.isHandshake(msg.sender), "defer");
    return _gitorg_;
  }
  
  function repo(address[] memory _handshakes, string memory _name, string memory _url, address _argctl) public returns (address) {
    for (uint i = 0; i < _handshakes.length; i++) {
      require(handshakes.isHandshake(_handshakes[i]), "backhanded");
    }
    uint _stamp = unique[gitorg.key(_url)];
    require(_stamp == 0, "repo not unique"); 
    address repo_ = Gitarray.repo(_handshakes, _name, _url, msg.sender, _argctl);
    unique[gitorg.key(_url)] = block.timestamp;
    return repo_;
  }
  /*
  function repo(address repo) public returns(Repo) {
    Sign memory sign = repos[repo];
    Handshakes signers = Handshakes(sign.handshakes);
    require(signers.isHandshake(msg.sender), "signer");
    Repo _repo = Repo(sign.repo);
    return _repo;
  }
  */
  // NOT A SHORT SELL INTERFACE
  function checkin (address repo, address handshakes, address handshake) public {
    repos[repo] = Sign(repo, msg.sender, handshakes);
    Gitarray.ctl(handshake);
  }
  /*
  function check () public returns ( {
    //by msg.sender or handshake? starting with msg.sender for review
    // TODO - repos from msg.sender handshake?
    Sign repo_ = repos[_repo];
    Handshakes handshakes_ = Handshakes(repo_.handshakes);
    require(msg.sender == handshakes_.isHandshake(msg.sender), "checker");
    return
  }
  */
  function commit(address _giteta, address _repo, string memory _message, string memory _author, string memory _date) public payable returns(uint) {
    Handshakes _handshakes = Handshakes(repos[_repo].handshakes);
    Repo repo_ = Repo(_repo);
    //bool shook = handshakes.isHandshake(msg.sender);

    require(_handshakes.isHandshake(msg.sender), "repository");
    uint extTimestamp = gitorg.timestamp();
    //function stamp (string memory _hash, uint timestamp, address _msgSender) public pure returns (bytes32)
    bytes32 hash = gitorg.stamp(_message, extTimestamp, msg.sender);
    giteta giteta_ = giteta(_giteta);
    // TODO - review - stable coin of wei if msg.value is still used, may want to parameterize
    //function commit(address _repo, string memory message, string memory author, string memory date, uint escrow) public returns (uint)
    // TODO - issue is that commit always throws escrow errors from accounts[0], we might need to review giteta tests
    // it's likely the issue is commit spend approval, even on commit address, there may just be an interface issue with
    // the gitarg contract so redeclaration may also work. The fact that balanceOf is the revert trigger means
    // that the interface issue may be the problem and an issue with ganache or something string related
    uint escrow = 1;
    Gitarg.approve(address(giteta_), escrow);
    giteta_.commit(_repo, _message, _author, _date, escrow);
    return block.timestamp;
  }
  function tar (uint amount) public returns (uint price) {
    return 1; 
  }
}

