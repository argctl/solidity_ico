// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";
import "interfaces/gitarray.sol";
import "giteta.sol";

abstract contract gitarray is Gitarray {
  address gitargWallet;
  mapping (address => giteta) Giteta;
  
  constructor () {
    gitargWallet = msg.sender;
  }
  function burn(address wallet, uint commits) internal override returns (uint) {
    return block.timestamp;
  }
  function hash(address wallet, string memory codeHash, string memory message,
    string memory commitHash, uint clientTimestamp, uint blockTimestamp) internal override returns (address) {
    return gitargWallet;
  }
  function eta(address _giteta) internal override returns (uint) {
    Giteta[msg.sender] = giteta(_giteta);
    return block.timestamp;
  }
  function eta() external returns (uint) {
    giteta _eta = new giteta();
    Giteta[msg.sender] = _eta;
    return block.timestamp;
  }
  function org(address _gitorg) internal override returns (uint) {
    return block.timestamp;
  }
  function arg(address _gitarg) internal override returns (uint) {
    if (_gitarg != gitargWallet) {
      
    }
    return block.timestamp;
  }
  //function contracts(address _giteta, address _gitorg, address _gitarg
}
