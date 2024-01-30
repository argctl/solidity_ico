pragma solidity >= "0.8.20";
import "./gitar.sol";

// use escrow to pay gas for spread of 0.90 - 1.20 (as an example). 
// rig like an oil rig
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
        // left side, sell
        // cannons return loot
        // REVIEW - buffer[n1] is initialized to 0
        uint start = gasleft() * tx.gasprice;
        // TODO - bungee more for forced escrow
        require(start > stiphen, "limit to increase transactions to increase buffer");
        buffer[msg.sender] = buffer[msg.sender] + (sell - buy) * amount;
        uint buff = buffer[msg.sender];
        require(buff - stiphen > 0, "safe stiphen for contract");
        uint price = (amount * sell) - stiphen;
        require(msg.value == price, "rate mismatch"); // review if we should make it greater than and return value
        // TODO - sell the token amount for the price
        buffer[msg.sender] = buff - stiphen;
        return false;
    }

    function star (uint amount, uint stiphen) public payable tar(stiphen) returns (bool) {
        // right side, buy
        // balls rerun shoot
        uint start = gasleft() * tx.gasprice;
        require(start > stiphen, "limit to increase transactions to increase buffer");
        uint buff = buffer[msg.sender];
        require(buff - stiphen > 0, "safe stiphen for contract");
        uint cost = (amount * buy) + stiphen;
        require(msg.value == cost, "rate mismatch");
        // TODO - buy the token amount for the price
        buffer[msg.sender] = buff - stiphen;
        return false;
    }
}