// SPDX-License-Identifier: BUSL-1.1
pragma solidity 0.8.18;

library auth {
  // TODO - enum for contract type
  // REVIEW - it's possible that msg.sender isn't available to library and to restrictive
  enum Type { GITARG, GITETA, GITARRAY, GITORG }
  struct Log {
    address wallet;
    uint timestamp;
    address _contract;
    Type _type;
    string _action;
    bool restricted;
  }
  function action (address _contract, Type _type,
    string calldata _action, Log[] storage actions) internal returns (Log[] storage) {
    Log memory log = Log(msg.sender, block.timestamp, _contract, _type, _action, true); // TODO - update to remove restriction
    actions.push(log);
    return actions;
  }
  function query(Log[] storage actions, Log[] storage result) private returns (Log[] storage) {
    for (uint i = 0; i < actions.length; i++) {
      if (actions[i].wallet == msg.sender) {
        result.push(actions[i]);
      }
    }
    return result;
  }
  // result should be empty pointer to Log storage array
  function query(Log[] storage actions, address _contract, Log[] storage result) private returns (Log[] storage) {
    for (uint i = 0; i < actions.length; i++) {
      if (actions[i]._contract == _contract) {
        if (actions[i].restricted && actions[i].wallet != msg.sender) continue;
        result.push(actions[i]);
      }
    }  
    return result;
  }
  function query(Log[] storage actions, uint up, uint down, Log[] storage result) private returns (Log[] storage) {
    for (uint i = 0; i < actions.length; i++) {
      if (actions[i].timestamp >= down && actions[i].timestamp <= up) {
        result.push(actions[i]);
      }
    }
    return result;
  }
}
