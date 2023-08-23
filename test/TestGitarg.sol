// SPDX-License-Identifier: UNLICENSED
pragma solidity >= "0.8.20";

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/gitarg.sol";

contract TestGitarg {
  
  function testName() public {
    gitarg ico = new gitarg();
    Assert.equal(ico.name(), "gitarg", "name match");
  }
  function testSymbol() public {
    gitarg ico = gitarg(DeployedAddresses.gitarg());
    Assert.equal(ico.symbol(), "GIT", "symbol match");
  }
  function testDecimals() public {
    gitarg ico = gitarg(DeployedAddresses.gitarg());
    Assert.equal(ico.decimals(), 6, "decimal matches creation");
  }
  function testTokenAmount() public {
    gitarg ico = gitarg(DeployedAddresses.gitarg());
    uint256 t = 1000 ether;
    //1000000000000000000000
    //1000000000000000000000

    uint x = 1000 * 10**18;
    Assert.equal(ico.balanceOf(tx.origin), x, "translation with wei equals token number");
    Assert.equal(ico.balanceOf(tx.origin), t, "decimal translation of eth");
  }
}
