// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";

abstract contract Gitarray {  
  function burn(address wallet, uint commits) internal virtual;
  function hash(address wallet, string memory hash, string memory message,
    string memory commitHash, uint clientTimestamp, uint blockTimestamp) internal virtual;
  function eta(address _giteta) internal virtual;
  function org(address _gitorg) internal virtual;
  function arg(address _gitarg) internal virtual;
  //TODO
}
