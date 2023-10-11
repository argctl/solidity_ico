pragma solidity >= "0.8.20";
import "./ltcgra.sol";
import "./tar.sol";

contract T {
  address private _ltcgra;
  constructor () {
    _ltcgra = msg.sender;
  }
  function n (address _handshakes, address gitorg_, address gitarg_, address gitarray_) public {
    new tar(_handshakes, gitorg_, gitarg_, gitarray_);
  }
}
