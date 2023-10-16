// SPDX-License-Identifier: BUSL-1.1
import "./gitorg.sol";
import "./libraries/gitorg.sol";
import "./gitarg.sol";
import "./objects/Proposal.sol";
import "./objects/Handshakes.sol";
import "./gitarray.sol";
import "./ltcgra.sol";

pragma solidity >= "0.8.20";

//spawner
contract argctl {
  address private _gitorg_;
  _gitorg  private Gitorg;
  address public _gitarg;
  address private _handshakes;
  Handshakes handshakes;
  gitarray Gitarray;
  gitarg Gitarg;
  struct Sign {
    address repo;
    address gitarray;
    address handshakes;
  }
  mapping(address => Sign) private repos;
  // interface
  /// trope
  constructor (address handshakes_, address gitorg_, address gitarg_, address _gitarray) {
    _gitarg = gitarg_;
    _gitorg_ = gitorg_;
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
  function repo(address[] memory _handshakes, string memory _name, string memory _url, address _owner, address _argctl) public returns(uint) {
    for (uint i = 0; i < _handshakes.length; i++) {
      require(handshakes.isHandshake(_handshakes[i]), "backhanded");
    }
    Gitarray.repo(_handshakes, _name, _url, _owner, _argctl);
  }
  // NOT A SHORT SELL INTERFACE
  function checkin (address repo, address handshakes) public {
    repos[repo] = Sign(repo, msg.sender, handshakes);
  }
  function commit(address _repo, string memory _message, string memory _author, string memory _date) public returns(uint) {
    Handshakes handshakes = Handshakes(repos[_repo].handshakes);
    Repo _repo = Repo(_repo);
    bool shook = handshakes.isHandshake(msg.sender);
    //require(shook, "msg.sender is not a handshake");
    //uint extTimestamp = gitorg.timestamp();
    //function stamp (string memory _hash, uint timestamp, address _msgSender) public pure returns (bytes32)
    //bytes32 hash = gitorg.stamp(_message, extTimestamp, msg.sender);
    return block.timestamp;
  }
  function tar (uint amount) public returns (uint price) {
    return 1; 
  }
}

