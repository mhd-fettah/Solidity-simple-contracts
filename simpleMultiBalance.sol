// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

//contact : Fettah@n3xt.tech
//crypto wallet : Fettah@crypto

contract MultiBalance {
    address public minter;
    // add balances for each wallet ... any wallet on network can have all this balances and recive tokens
    mapping (address => uint[3]) public balances;
    string[] Currinces = ["USD","EURO","TL"];  

    // event that triggers when a sent happens .
    event Sent(address from, address to, uint amount,string Currency);

    constructor() {
        // minter is the one who created the contract .
        minter = msg.sender;
    }

    // create new coins . only by admin
    /// currency can be 0 , 1 , 2 for ["USD","EURO","TL"]
    function mint(uint amount,uint currencyID) public {
        require(msg.sender == minter);
        require(currencyID < Currinces.length);
        balances[minter][currencyID] += amount;
    }

    error InsufficientBalance(uint requested, uint available,string Currency);

    // from any caller adress to the next 
    function send(address receiver, uint amount,uint currencyID) public {
        if (amount > balances[msg.sender][currencyID])
            revert InsufficientBalance(amount,balances[msg.sender][currencyID],Currinces[currencyID]);

        //if all good do the oprations . 
        balances[msg.sender][currencyID] -= amount;
        balances[receiver][currencyID] += amount;

        // emit to trigger the event . 
        emit Sent(msg.sender, receiver, amount,Currinces[currencyID]);
    }
}

