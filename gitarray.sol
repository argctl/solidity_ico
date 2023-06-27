// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";
import "interfaces/gitarray.sol";
import "giteta.sol";
import "gitarg_proxy.sol";
import "libraries/gitorg.sol";

abstract contract gitarray is Gitarray {
  address gitargWallet;
  address[] private handshakes;
  mapping (address => uint) private handshakeValues;
  mapping (address => giteta) Giteta;
  mapping (address => gitarg_proxy) gitargProxies;
  
  constructor (address[] memory _handshakes, uint[] memory values) {
    require(_handshakes.length == values.length);
    for (uint i = 0; i < _handshakes.length; i++) {
      handshakeValues[handshakes[i]] = values[i]; 
    }
    gitargWallet = msg.sender;
  }
  //function setFee()
  function burn(address wallet, uint commits) internal override returns (uint) {
    return block.timestamp;
  }
  function hash(address wallet, string memory codeHash, string memory message,
    string memory commitHash, uint clientTimestamp, uint blockTimestamp) internal override returns (address) {
    //keccak256(codeHash);
    return gitargWallet;
  }
  function eta(address _giteta) internal override returns (uint) {
    Giteta[msg.sender] = giteta(_giteta);
    return block.timestamp;
  }
  function eta() external returns (uint) {
    Giteta[msg.sender] = new giteta();
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
