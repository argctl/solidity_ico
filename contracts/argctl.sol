// SPDX-License-Identifier: BUSL-1.1
//import "./gitorg.sol";
import "./libraries/gitorg.sol";
import "./gitarg.sol";
import "./objects/Proposal.sol";
import "./objects/Handshakes.sol";
pragma solidity >= "0.8.20";

contract argctl {
  address private _gitorg;
  address public _gitarg;
  address private _handshakes;
  Handshakes handshakes;
  struct Sign {
    address repo;
    address gitarray;
    address handshakes;
  }
  mapping(address => Sign) private repos;
  // interface
  constructor (address handshakes_, address gitorg_, address gitarg_) {
    _gitarg = gitarg_;
    _gitorg = gitorg_;
    _handshakes = handshakes_;
    handshakes = Handshakes(handshakes_);
  }
  function proof () public view returns (address) {
    require(handshakes.isHandshake(msg.sender), "defer");
    return _gitorg;
  }
  function checkin (address repo, address handshakes) public {
    repos[repo] = Sign(repo, msg.sender, handshakes);
  }
  function commit(address _repo, string memory _message, string memory _author, string memory _date) public returns(uint) {
    Handshakes handshakes = Handshakes(repos[_repo].handshakes);
    Repo _repo = Repo(_repo);
    require(handshakes.isHandshake(msg.sender));
    uint extTimestamp = gitorg.timestamp();
    //function stamp (string memory _hash, uint timestamp, address _msgSender) public pure returns (bytes32)
    bytes32 hash = gitorg.stamp(_message, extTimestamp, msg.sender);
    return block.timestamp;
  }
}

