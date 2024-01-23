pragma solidity >= "0.8.20";
import "./gitar.sol";

// use escrow to pay gas for spread of 0.90 - 1.20 (as an example). 
contract rig {
    uint public sell;
    uint public buy;
    bool min;
    // REVIEW - struct for transaction, probably not
    mapping(address => uint) buffer; // homework - what will buffer do?
    // booty can be for me or for you - max or min
    constructor (uint _buy, uint _sell, uint booty, bool _min) {
        min = _min; // booty is a max if false
        sell = _sell;
        buy = _buy;
        // TODO - initiate gitar contract
        // booty is the max take for the stake
        // aaarrrggg
    }
    modifier tar (uint stiphon) {
        require(stiphon < gasleft(), "stiphone prediction limiter fail");
        _;
    }
    function port (uint amount, uint stiphen) public payable tar(stiphen) returns (bool) {
        uint start = gasleft();
        // REVIEW - buffer[n1] is initialized to 0
        buffer[msg.sender] = buffer[msg.sender] + (sell - buy) * amount;
        //require(start < stiphen && stiphen < buy - sell, "gas less than food");
        //uint absorb = start - stiphen;
        require(start > stiphen, "limit to increase transactions to increase buffer");
        // left side, sell
        // cannons return loot
        uint price = amount * sell;
        require(msg.value == price, "rate mismatch");
        // tx.gasprice - gasleft() < magic number?
        return false;
    }

    function star (uint amount, uint stiphen) public payable tar(stiphen) returns (bool) {
        // right side, buy
        // balls rerun shoot
        uint cost = amount * buy;
        require(msg.value == cost, "rate mismatch");
        //
        return false;
    }
}