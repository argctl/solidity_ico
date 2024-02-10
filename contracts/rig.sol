// control token
// there's a point of convergance where the buffer converges with the gas cover stipend
// the value is the transaction capability and there is always slightly more backbone
// this is due to the gas relation function and buffer (acts as program counter)
pragma solidity >= "0.8.20";
import "./gitar.sol";
import "./gitarg.sol";

// use escrow to pay gas for spread of 0.90 - 1.20 (as an example). 
// rig like an oil rig
contract rig {
    uint public sell;
    uint public buy;
    uint public loot; // this allows us to restart a similar contract or leave gracefully
    uint public stakem;
    bool min;
    gitar tar; // REVIEW - access modifier
    gitarg arg;
    address public gitar_;
    address public gitarg_;
    // REVIEW - struct for transaction, probably not
    mapping(address => uint) buffer; // homework - what will buffer do?
    mapping(address => uint) gate; // gates close
    // buffer rollover - remaining buffer used in gitar limiter
    // booty can be for me or for you - max or min
    // TODO - can I create a token interface for generic erc?
    constructor (uint _buy, uint _sell, uint booty, bool _min, address _gitar) {
        gitar_ = _gitar;
        tar = gitar(_gitar);
        gitarg_ = tar._gitarg();
        arg = gitarg(gitarg_);
        min = _min; // booty is a max if false
        sell = _sell;
        buy = _buy;
        loot = booty; //if (!_min) // as a maximum take
        stakem = buy - sell - booty; // if (_min) // used to calculate rate of entire contracts value in loot
        // TODO - initiate gitar contract
        // booty is the max take for the stake
        // aaarrrggg
    }
    modifier start (uint stiphon) {
        require((gasleft() * tx.gasprice) > stiphon, "gas to start");
        _;
    }
    function port (uint amount, uint stiphen) public payable start(stiphen) returns (uint) {
        // left side, sell
        // cannons return loot
        uint purchased = tar.gg(msg.sender);
        require(purchased <= amount, "treasure chest");
        // call once?
        require(buffer[msg.sender] == 0 || (!(amount < buffer[msg.sender]) && buffer[msg.sender] == 0), "parrot's keep");
        buffer[msg.sender] = (sell - buy) * amount; // REVIEW - multiplier
        uint buff = buffer[msg.sender];
        require(buff < (stiphen * stiphen) - stiphen, "ore"); // bridge level deflation mechanic
        // 3 * 3000 = 9000, or buffer is less than 9000 when stiphen is 3000
        require(msg.value == stiphen * stiphen, "gas"); //U
        // the sent value is 3000 * 3000 = 9000000 equals the sent value in ether or backbone
        return buffer[msg.sender];
    }

    function star (uint amount, uint stiphen) public payable start(stiphen) returns (bool) {
        // right side, buy
        // balls rerun shoot
        // multiply value of both token stores, payout gas cover in higher stake amount currency
        uint buff = buffer[msg.sender];
        require(buff - stiphen > 0, "safe stiphen for contract"); //opens us up to higher prices for higher transacts - fight large sum instability problem
        uint cost = (amount * buy) + stiphen;
        // TODO - amount is in token and the buffer is the token number
        // TODO - buy the token amount for the price, return the gas cost buffer in token
        // REVIEW - gas price return in backbone when "loot"?
        buffer[msg.sender] = buff - stiphen; // the stiphen is sent as gitarg token
        if (gate[msg.sender] == 0) gate[msg.sender] = tar.gg(msg.sender);
        gate[msg.sender] -= amount;
        require(gate[msg.sender] >= 0, "closed");
        payable(msg.sender).transfer(cost);
        arg.transferFrom(tar.owner(), msg.sender, stiphen);
        return false;
    }
} // rig, where mean and median converge