// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

//contact : Fettah@n3xt.tech
//crypto wallet : Fettah@crypto

// lets say there is 2 parites (buyer&Seller) that want to make a transaction 
// buyer will put the money in the contract and the money will get locked . to make sure that the buyer is serious . 
// seller as well will have to put the same amount to make sure he will not keep the buyer hanging.
// then when buyers confirms the transaction . buyer will have the option to release the money.

contract PurchaseAgreement {
    // buyer adress , seller adress and the amount they agreed on.
    uint public amount;
    address payable public seller;
    address payable public buyer;

    enum State { Created, Locked, Release, Inactive }
    State public agreementState;

    // arrange permissions . with modifirers

    /// Only the buyer can call this function.
    error OnlyBuyer();

    /// Only the seller can call this function.
    error OnlySeller();

    modifier onlyBuyer() {
        if (msg.sender != buyer)
            revert OnlyBuyer();
        _;
    }

    modifier onlySeller() {
        if (msg.sender != seller)
            revert OnlySeller();
        _;
    }

    // events to emit 
    event Aborted();
    event PurchaseConfirmed();
    event ItemReceived();
    event SellerRefunded();

    constructor() payable {
        // seller initiate the contract and we wrote down who the seller is
        seller = payable(msg.sender);
        //and what the amount of the contract is 
        amount = msg.value;
    }

    // seller can cancel the contract before the buyer enters.
    function abort() external
        onlySeller
    {
        // in case of the agreementState being at Created only .
        require(agreementState == State.Created);
        emit Aborted();
        agreementState = State.Inactive;
        seller.transfer(address(this).balance);
        // address(this) : return the adress of this contract.
        // SOMEADRESS.balance : total balance for that adress.
        // here we transfer all the balance of current contract to the seller because all the coins here came from the seller looking at the state of the contract.
    }

    // any one can join the fun and make the order by sending the amount needed
    function confirmPurchase() external payable {
        // the offer still on
        require(agreementState == State.Created);

        //he sent the right amount 
        require(msg.value == amount);

        emit PurchaseConfirmed();
        
         // save the adress of the new buyer 
        buyer = payable(msg.sender);
        // change the state .
        agreementState = State.Locked;
    }

    // when the buyer get his order he can call this function to close the agreement and send the money,
    function confirmReceived() external 
        onlyBuyer
    {
        require(agreementState == State.Locked);

        // the state of agreement is done
        agreementState = State.Release;

        // send the coins to the seller ... not this is x2 the amount . 
        // part seller paid as collateral other is what the buyer paid. 
        seller.transfer(address(this).balance);
    }

}