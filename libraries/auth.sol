// SPDX-License-Identifier: BUSL-1.1
pragma solidity >= "0.8.18";

library auth {
  // TODO - enum for contract type
  struct Log {
    address wallet;
    uint timestamp;
    address _contract;
    string _type;
    string _action;
  }
  function action (address _contract, string calldata _type,
    string calldata _action, Log[] storage actions) internal returns (Log[] storage) {
    Log memory log = Log(msg.sender, block.timestamp, _contract, _type, _action);
    actions.push(log);
    return actions;
  }
}
