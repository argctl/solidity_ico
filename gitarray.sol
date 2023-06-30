// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";
import "./interfaces/gitarray.sol";
import "./giteta.sol";
import "./gitarg_proxy.sol";
import "./libraries/gitorg.sol";
import "./gitarg.sol";

abstract contract gitarray is Gitarray {
  
  address gitargWallet;
  address[] private handshakes;
  mapping (address => uint) private handshakeValues;
  mapping (address => uint) private handshakeStash;
  mapping (address => giteta) GitetaMap;
  mapping (address => gitarg_proxy) gitargProxies;
  bool private vault;

  uint private stash;
  uint private trap;
  uint public ration;
  uint public proposal;

  gitarg private Gitarg;
  giteta private Giteta;

  
  constructor (address _gitarg, address _giteta, address[] memory _handshakes, uint[] memory values, bool _vault, uint _ration) {
    require(_handshakes.length == values.length);
    for (uint i = 0; i < _handshakes.length; i++) {
      handshakeValues[handshakes[i]] = values[i]; 
    }
    handshakes = _handshakes;
    gitargWallet = msg.sender;
    vault = _vault;
    ration = _ration;
    Gitarg = gitarg(_gitarg);
    Giteta = giteta(_giteta);
  }
  function propose(uint _ration) public returns (uint) {
    require(gitargWallet == msg.sender);
    proposal = _ration;
    return block.timestamp;
  }
  function vote(address _handshake) public payable {
    require(handshakeStash[_handshake] == 0);
    handshakeStash[_handshake] = msg.value;
    stash += msg.value;
  }
  function setTrap() public payable {
    require(msg.sender == gitargWallet);
    trap = msg.value;
  }
  function set() public payable {
    require(trap == msg.value); 
    uint total;
    uint votes;
    for(uint i = 0; i < handshakes.length; i++) {
      total += handshakeStash[handshakes[i]];
      votes += handshakeValues[handshakes[i]];
    }
    if (vault) require(total == votes);
    require(total >= votes);
    ration = proposal;
  }
  function burn(address _repo, string memory repoURL, uint commits, address payable _to) internal override returns (uint) {
    // TODO - direct
    Repo repo = Repo(_repo);
    // ration
    uint cost = commits * ration;
    //function logCommitMap(address _repo, uint commits, string memory repoURL) public returns (Log[] memory) {
    Giteta.logCommitMap(_repo, commits, repoURL);
    //repo.

    //gitorg.direct(_giteta, _gitarg, repo, stash, _to);
    require(gitargWallet == _to);
    gitorg.direct(address(Giteta), address(Gitarg), _repo, cost, _to);
    // charge ration for each commit that's ran against log
    // commits
    // direct in gitorg?
    return block.timestamp;
  }
  function hash(address wallet, string memory codeHash, string memory message,
    string memory commitHash, uint clientTimestamp, uint blockTimestamp) internal override returns (address) {
    //keccak256(codeHash);
    return gitargWallet;
  }
  function eta(address _giteta) internal override returns (uint) {
    GitetaMap[msg.sender] = giteta(_giteta);
    return block.timestamp;
  }
  function eta() external returns (uint) {
    GitetaMap[msg.sender] = new giteta();
    return block.timestamp;
  }
  
  function arg(address _gitarg) internal override returns (uint) {
    if (_gitarg != gitargWallet) {
      gitargProxies[_gitarg] = gitarg_proxy(_gitarg);     
    }
    return block.timestamp;
  }
  function direct(address _giteta, address _gitarg, address repo, uint stash, address payable _to) public payable returns (uint) {
    // REVIEW - recycle to either contract address or escrow wallet to cycle GITARG coin
    //require(stash >= msg.value * 100000); // REVIEW - query for rate on contract? 
    //arg.transfer(wallet, stash);
    // TODO - stash from msg.value or account stash?
    // TODO - use gitarray setter value for inflation deflation control
    gitorg.direct(_giteta, _gitarg, repo, stash, _to);
    _to.transfer(msg.value);
    return 0;
  }
  //function contracts(address _giteta, address _gitorg, address _gitarg
}
