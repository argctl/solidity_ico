// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";

interface gitarray {  
  function burn(address wallet, uint commits) external returns (uint);
  function hash(address wallet, string memory hash, string memory message,
    string memory commitHash, uint clientTimestamp, uint blockTimestamp) external returns (address);
  function eta(address _giteta) external returns (uint); //TODO
  function org(address _gitorg) external returns (bool); //TODO
  function arg(address _gitarg) external returns (uint); //TODO
  //TODO
}
