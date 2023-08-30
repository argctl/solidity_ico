// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";

contract Handshakes {
  address creator;
  address owner;
  mapping(address => uint) handshakes;
  mapping(address => uint) private shook;
  uint threshold;

  address proposal;
  uint proposalTime;

  bool corp;

  modifier owned () {
    if (corp) require(msg.sender == owner);
    _;
  }

  constructor(address[] memory _handshakes, address _owner, uint _threshold, bool _corp) {
    creator = msg.sender;
    owner = _owner;
    proposal = proposal;
    corp = _corp;
    if (threshold == 0) {
      threshold = _handshakes.length;
    } else {
      threshold = _threshold;
    }
    for (uint i = 0; i < _handshakes.length; i++) {
      handshakes[_handshakes[i]] = block.timestamp;
    }
  }
  function setProposal(address _proposal) public returns(uint) {
    proposal = _proposal;
    proposalTime = block.timestamp;
    return block.timestamp;
  }
  function isHandshake(address sender) public view returns(bool) {
    // review - owner and creator or just owner
    require(creator == msg.sender || owner == msg.sender);
    return handshakes[sender] != 0;
  }
  function isHandshake() public view returns(bool) {
    return handshakes[msg.sender] != 0;
  }
  function shake() public {
    shook[msg.sender] = block.timestamp;
  }
  // TODO - expiry on handshake check with greaterthan
  function check(address[] memory shakes, address[] memory noshakes) public view owned {
    for (uint i = 0; i < shakes.length; i++) {
      require(handshakes[shakes[i]] != 0);
      require(shook[shakes[i]] != 0);
    }
    for (uint i = 0; i < noshakes.length; i++) {
      require(handshakes[noshakes[i]] != 0);
      require(shook[noshakes[i]] == 0);
    }
  }
}
