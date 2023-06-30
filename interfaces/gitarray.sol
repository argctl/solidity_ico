// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";

abstract contract Gitarray {  
  function burn(address _repo, string memory repoURL, uint commits, address payable _to) internal virtual returns (uint);
  function hash(address wallet, string memory codeHash, string memory message,
    string memory commitHash, uint clientTimestamp, uint blockTimestamp) internal virtual returns (address);
  function eta(address _giteta) internal virtual returns (uint);
  function org(address _gitorg) internal virtual returns (uint);
  function arg(address _gitarg) internal virtual returns (uint);
  //TODO
}
