pragma solidity 0.8.20;
import "./ltcgra.sol";
//import "./tar.sol";

contract T {
  address private _ltcgra;
  struct I {
    string ticker;
    uint rate;
  }

  I _i;
  I i_;
  constructor (string memory _ticker, string memory ticker_, uint _rate, uint rate_) {
    _ltcgra = msg.sender;
    _i = I(_ticker, _rate);
    i_ = I(ticker_, rate_);
  }
  function n () public {
  }
}
