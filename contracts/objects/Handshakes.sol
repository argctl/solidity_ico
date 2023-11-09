// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.20";

contract Handshakes {
  // TODO - review creator/owner hostage scenario
  address private creator;
  address private owner;
  mapping(address => uint) private handshakes;
  mapping(address => uint) private removed;
  mapping(address => uint) private shook;
  mapping(address => uint) private stopper;

  uint private threshold;

  address private proposal;
  uint private proposalTime;

  //uint private epoch;
  uint private placement;
  uint private stopperEpoch = block.number;

  address[] private shakeList;

  bool public corp;

  // timing linearly related to the length of a list
  modifier rhyme () {
    // x - f(x) or f(y) = f(x) - x or f(y) = -x ~RE~VIEW~
    // 12 - 5 > 16
    require(block.number - stopperEpoch > shakeList.length, "emhyr");
    //slant ryhme - just based on the epoch, less than (slugging) you have to predict the epochs
    _;
  }

  modifier own () {
    if (corp) {
      require(msg.sender == owner, "corp owner");
    } else {
      require(msg.sender == owner || handshakes[msg.sender] != 0, "owner");
    }
    _;
  }

  modifier stop () {
    require(stopper[msg.sender] == 0, "stopper");
    _;
  }

  modifier member () {
    require(handshakes[msg.sender] != 0, "member");
    _; 
    // TODO - explore - we can execute post-middlewear -  require(handshakes[msg.sender] != 0);
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
      stopper[msg.sender] = 0;
    }
    shakeList = _handshakes;
  }
  function setProposal(address _proposal) public own returns(uint) {
    proposal = _proposal;
    proposalTime = block.timestamp;
    return block.timestamp;
  }
  function isHandshake() public view returns(bool) {
    return handshakes[msg.sender] != 0;
  }
  function isHandshake(address handshake) public view member returns(bool) {
    // review - owner and creator or just owner
    //require(creator == msg.sender || owner == msg.sender);
    return handshakes[handshake] != 0;
  }
  
  function shake() public member {
    shook[msg.sender] = block.timestamp;
  }
  // TODO - expiry on handshake check with greaterthan
  function check(address[] memory shakes, address[] memory noshakes) public view own {
    for (uint i = 0; i < shakes.length; i++) {
      require(handshakes[shakes[i]] != 0);
      require(shook[shakes[i]] != 0);
    }
    for (uint i = 0; i < noshakes.length; i++) {
      require(handshakes[noshakes[i]] != 0);
      require(shook[noshakes[i]] == 0);
    }
  }
  // handshake add resembles a chain of addresses (linked list)
  function add(address handshake) public member stop returns (uint) {
    handshakes[handshake] = block.timestamp;
    shakeList.push(handshake);
    stopper[msg.sender] = block.timestamp;
    stopper[handshake] = 1;
    return block.timestamp;
  }
  // removing a handshake leaves a trace of the handshake
  function remove() public returns (uint) {
    // TODO - remove from shakeList?
    require(handshakes[msg.sender] != 0, "replicant");
    handshakes[msg.sender] = 0;
    removed[msg.sender] = block.timestamp;
    return block.timestamp;
  }
  // REVIEW - restrict to owner (own review) for handshake address-is own handshake check too?
  function remove(address handshake) public own stop returns (uint) {
    // TODO - remove from shakeList? - shakeList only used for length
    require(handshakes[handshake] != 0, "deepfake");
    handshakes[handshake] = 0;
    removed[handshake] = block.timestamp;
    return block.timestamp;
  }
  // unstopper pseudo ownership of add address for dictatorship
  function unstopper(address handshake, bool _epoch) public own rhyme stop returns (uint) {
    // REVIEW - should stopperEpoch have a different adder
    // TODO - multiply by thresholdDivider or another multiplier?
    if (!corp) require(stopper[handshake] == 1, "trap");
    stopper[handshake] = 0;
    if (_epoch) epoch();
    return block.timestamp;
  }
  function epoch () public own {
    stopperEpoch = block.number;
  }
}
