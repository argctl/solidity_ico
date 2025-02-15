// SPDX-License-Identifier: BUSL-1.1
// control token
// there's a point of convergance where the buffer converges with the gas cover stipend
// the value is the transaction capability and there is always slightly more backbone
// this is due to the gas relation function and buffer (acts as program counter)
pragma solidity 0.8.20;
import "./gitar.sol";
import "./gitarg.sol";
import "./libraries/gas.sol";

// use escrow to pay gas for spread of 0.90 - 1.20 (as an example). 
// rig like an oil rig
contract rig {
    address public creator;
    uint public sell;
    uint public buy;
    uint public stakem;
    gitar tar; // REVIEW - access modifier
    gitarg arg;
    address public gitar_;
    address public gitarg_;
    // REVIEW - struct for transaction, probably not
    mapping(address => uint) public buffer; // homework - what will buffer do?
    mapping(address => uint) public gate; // gates close
    // buffer rollover - remaining buffer used in gitar limiter
    // booty can be for me or for you - max or min
    // TODO - can I create a token interface for generic erc?
    event Debug(uint gas);
    event Bool(bool compare);
    // await deployer.deploy(rig, arg.address, 90000, 100000)
    constructor (address _gitarg, uint _buy, uint _sell) {
        creator = msg.sender;
        sell = _sell;
        require(_buy < sell, "chest");
        if (address(0) == _gitarg) {
          arg = new gitarg();
          gitarg_ = address(arg);
        } else {
          arg = gitarg(_gitarg);
          gitarg_ = _gitarg;
        }
        // totalSupply is a variable to the network or chain (id)
        tar = new gitar(gitarg_, sell, arg.totalSupply() / 3, 3);
        gitar_ = address(tar);
        arg.approve(gitar_, arg.totalSupply() / 3);
        buy = _buy;
        // TODO - initiate gitar contract
        // booty is the max take for the stake
        // aaarrrggg
    }
    modifier start (uint stiphon) {
        //bool gascheck = gas.check(uint(int(gasleft())), uint(int(tx.gasprice)), stiphon);
        require(gasleft() > stiphon, "gas to start");
        _;
    }
    function fund () public view returns (uint) {
      require(msg.sender == creator, "organ flush"); 
      require(tar.locked(), "sail over");
      return block.timestamp;
    }
    function port (uint amount, uint stiphen) public payable start(stiphen) returns (uint) {
        // left side, sell
        // cannons return loot
        //uint s = gasleft() * tx.gasprice;
        uint purchased = tar.gg(msg.sender);
        require(purchased >= amount, "treasure chest");
        require(buffer[msg.sender] == 0 || (!(amount < buffer[msg.sender]) && buffer[msg.sender] == 0), "parrot's keep");
        // (3 - 1) * 10 = 20 
        buffer[msg.sender] = (sell - buy) * amount; // REVIEW - multiplier
        uint buff = buffer[msg.sender];
        //  3, 6
        // gas minimization is profitability for node runner, if gas isn't directly paid to node runner
        require(buff < (stiphen * stiphen) - stiphen, "ore"); // bridge level deflation mechanic
        require(msg.value == stiphen * stiphen, "gas"); //U
        require(gasleft() < stiphen, "gas to stop");
        return buffer[msg.sender];
    }

    function star (uint amount, uint stiphen) public payable start(stiphen) returns (uint) {
        // right side, buy
        // balls rerun shoot
        uint buff = buffer[msg.sender];
        // if we use 1 as a flag in the buffer then we can lock the account
        require(buff - stiphen > 0, "safe stiphen for contract"); //opens us up to higher prices for higher transacts - fight large sum instability problem
        uint cost = (amount * buy) + stiphen; // contract (me) cost
        // TODO - amount is in token and the buffer is the token number
        // TODO - buy the token amount for the price, return the gas cost buffer in token ???
        buffer[msg.sender] = buff - stiphen; // the stiphen is sent as gitarg token
        // we haven't set the gate, buffer < s^2 - s, then can buffer - s == 1 to set the gate 
        // REVIEW
        if (gate[msg.sender] == 0 && (buff - stiphen) == 1) gate[msg.sender] = tar.gg(msg.sender);
        // (s(g)^2 - s(g)) - s(g) ?= 1 if s(g) = s(x1) < g(x2);
        gate[msg.sender] -= amount;
        // gate[msg.sender] will revert if require doesn't pass
        require(gate[msg.sender] >= 0, "closed");
        payable(msg.sender).transfer(cost);
        arg.transferFrom(tar.owner(), msg.sender, stiphen);
        buffer[msg.sender] -= 1;
        //require(gasleft() * tx.gasprice < tx.gasprice * 2);
        require(gasleft() < stiphen, "gas to stop");
        return buffer[msg.sender];
    }
} // rig, where mean and median converge
