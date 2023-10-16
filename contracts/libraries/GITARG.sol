pragma solidity >= "0.8.20";

// return gitarg interface address, can be token or a proxy (even off chain)
library GITARG {
  function gitarg () public returns (address) {
    return address("");
  }
  function uniswap () public returns (address) {
    return address("");
  }
  function weth () public returns (address) {
    //0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2
    return 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
  }
}
