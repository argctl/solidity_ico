// SPDX-License-Identifier: UNLICENSED
pragma solidity >= "0.8.20";

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/giteta.sol";
import "truffle/console.sol";

contract TestGiteta {
  function testContractCreation () public {
    //gitarg arg = gitarg(DeployedAddresses.gitarg());
    giteta eta = new giteta(DeployedAddresses.gitarg());
    //address arg = eta.arg();
    gitarg _gitarg = eta.Gitarg();
    //console.log("argarg", arg);
    // address(arg)
    Assert.equal(address(_gitarg), DeployedAddresses.gitarg(), "Arg contract address matches eta contract storage address");
  }
}
