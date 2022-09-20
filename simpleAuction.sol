// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract SimpleAuction {
    
    // adress of the beneficiary
    address payable public beneficiary;
    // Times are either absolute unix timestamps (seconds since 1970-01-01) or time periods in seconds.
    uint public auctionEndTime;

    // Current state of the auction.
    struct higgestBid{
        address Adress;
        uint bid;
    }
    higgestBid public TheHighistBid;    

    // Allowed withdrawals of previous bids
    mapping(address => uint) pendingReturns;

    // Set to true at the end, disallows any change.
    // By default initialized to `false`.
    bool ended;

    // Events that will be emitted on changes.
    event HighestBidIncreased(address bidder, uint amount);
    event AuctionEnded(address winner, uint amount);
    /// Create a simple auction with `biddingTime`
    /// seconds bidding time on behalf of the
    /// beneficiary address `beneficiaryAddress`.
    constructor( uint biddingTime, address payable beneficiaryAddress) {
        beneficiary = beneficiaryAddress;
        auctionEndTime = block.timestamp + biddingTime;
    }

    function bid() external payable {

        // period is not over.
        require (block.timestamp < auctionEndTime , "The auction has already ended");

        // bid is higher than the highest .
        require (msg.value > TheHighistBid.bid , "There is already a higher or equal bid.");

        if (TheHighistBid.bid != 0) {
            // Sending back the money by simply using
            // highestBidder.send(highestBid) is a security risk
            // because it could execute an untrusted contract.
            // It is always safer to let the recipients
            // withdraw their money themselves.
            pendingReturns[TheHighistBid.Adress] += TheHighistBid.bid;
        }
        TheHighistBid.Adress = msg.sender;
        TheHighistBid.bid = msg.value;
        emit HighestBidIncreased(msg.sender, msg.value);
    }

    // three slashes means note .
    /// Withdraw a bid that was overbid.
    function withdraw() external returns (bool) {
        uint amount = pendingReturns[msg.sender];
        if (amount > 0) {
            // It is important to set this to zero because the recipient
            // can call this function again as part of the receiving call
            // before `send` returns.
            pendingReturns[msg.sender] = 0;

            // msg.sender is not of type `address payable` and must be
            // explicitly converted using `payable(msg.sender)` in order
            // use the member function `send()`.
            if (!payable(msg.sender).send(amount)) {
                // No need to call throw here, just reset the amount owing
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }

    /// End the auction and send the highest bid
    /// to the beneficiary.
    function auctionEnd() external {
        // It is a good guideline to structure functions that interact
        // with other contracts (i.e. they call functions or send Ether)
        // into three phases:
        // 1. checking conditions
        // 2. performing actions (potentially changing conditions)
        // 3. interacting with other contracts
        // If these phases are mixed up, the other contract could call
        // back into the current contract and modify the state or cause
        // effects (ether payout) to be performed multiple times.
        // If functions called internally include interaction with external
        // contracts, they also have to be considered interaction with
        // external contracts.

        // 1. Conditions
        require(block.timestamp > auctionEndTime,"The auction has not ended yet.");
        require(!ended,"The function auctionEnd has already been called.");

        // 2. Effects
        ended = true;
        emit AuctionEnded(TheHighistBid.Adress, TheHighistBid.bid);

        // 3. Interaction
        beneficiary.transfer(TheHighistBid.bid);
    }
}