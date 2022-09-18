// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract Coin {
    address public minter;
    // any address (Wallet) can have uint balance.
    mapping (address => uint) public balances;

    // event that triggers when a sent happens .
    event Sent(address from, address to, uint amount);

    constructor() {
        // minter is the one who created the contract .
        minter = msg.sender;
    }

    // Sends an amount of newly created coins to an address
    // Can only be called by the contract creator
    function mint(address receiver, uint amount) public {
        //require is condtion and easy way to do validation in Solidity .
        require(msg.sender == minter);
        balances[receiver] += amount;
    }

    // Errors allow you to provide information about
    // why an operation failed. They are returned
    // to the caller of the function.
    error InsufficientBalance(uint requested, uint available);

    // Sends an amount of existing coins
    // from any caller to an address
    function send(address receiver, uint amount) public {
        if (amount > balances[msg.sender])
            // revert do a roll back . 
            // we added the error after it and passed the info .
            revert InsufficientBalance({
                requested: amount,
                available: balances[msg.sender]
            });

        //if all good do the oprations . 
        balances[msg.sender] -= amount;
        balances[receiver] += amount;

        // emit to trigger the event . 
        emit Sent(msg.sender, receiver, amount);
    }
}