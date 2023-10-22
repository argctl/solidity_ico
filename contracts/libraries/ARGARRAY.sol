pragma solidity >= "0.8.20";

// return gitarg interface address, can be token or a proxy (even off chain)
library ARGARRAY {
  function gitarg () public returns (address) {
    return 0xb3Bdb3e25BB580CA98480a5fD7c98E6516750685;
  }
  function gitarg_goerli () public returns (address) {
    return 0xb85C685226095d20EA648C35B9CCE6C1556006A5;
  }
  function uniswap () public returns (address) {
    return 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984;
  }
  function weth () public returns (address) {
    //0xc02aaa39b223fe8d0a0e5c4f27ead9083c756cc2
    return 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
  }
}
