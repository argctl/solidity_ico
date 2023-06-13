// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";

library auth {
  // TODO - enum for contract type
  struct Log {
    address wallet;
    uint timestamp;
    address _contract;
    string _type;
  }
}
