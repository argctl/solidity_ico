pragma solidity 0.8.20;

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
  function dai () public returns (address) {
    return 0x6B175474E89094C44Da98b954EedeAC495271d0F;
  }
  function usdc () public returns (address) {
    return 0xa0B86991c6218b36c1d19d4a2e9eb0Ce360CFb3D;
  }
  function link () public returns (address) {
    return 0x514910771AF9Ca656af840dff83E8264EcF986CA;
  }
  function aave () public returns (address) {
    return 0x7Fc66500c84A76Ad7e9c93437bFc5Ac33E2DDaE9;
  }
  function snx () public returns (address) {
    return 0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F;
  }
  function mkr () public returns (address) {
    return 0x9f8F72aA9304c8B593d555F12eF6589cC3A579A2;
  }
  function bat () public returns (address) {
    return 0x0D8775F648430679A709E98d2b0Cb6250d2887EF;
  }
  function comp () public returns (address) {
    return 0xc00e94Cb662C3520282E6f5717214004A7f26888;
  }
  function yfi () public returns (address) {
    return 0x0bc529c00C6401aEF6D220BE8C6Ea1667F6Ad93e;
  }
  function wbtc () public returns (address) {
    return 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599;
  }
}
