pragma solidity >= "0.8.20";
import "./T.sol";

contract ltcgra {
  address private owner;
  address private _handshakes;
  address private gitorg_;
  address private gitarg_;

  constructor (address handshakes_, address _gitorg, address _gitarg) {
    _handshakes = handshakes_;
    gitorg_ = _gitorg;
    gitarg_ = _gitarg;
    owner = msg.sender;
  }
  function gram () public {
    //new argctl(_handshakes, gitorg_, gitarg_, msg.sender);
    T t = new T();
    t.n(_handshakes, gitorg_, gitarg_, owner);
  }
}
