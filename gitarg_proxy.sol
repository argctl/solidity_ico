// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";

contract gitarg_proxy {
  address creator;
  constructor() {
    creator = msg.sender;
  }
}
