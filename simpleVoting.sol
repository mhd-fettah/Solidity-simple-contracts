// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;
contract SimpleVoting {
    
    // struct to declare somthing like an object with many sub elements . 
    struct Voter {
        bool voted;  // if true, that person already voted
        uint vote;   // index of the voted proposal
    }

    // This is a type for a single proposal.
    struct Proposal {
        bytes32 name;   // short name (up to 32 bytes)
        uint voteCount; // number of accumulated votes
    }

    address public chairperson;
    bytes32 private winnerName = "";

    // This declares a state variable that
    // stores a `Voter` struct for each possible address.
    mapping(address => Voter) public voters;

    // A dynamically-sized array of `Proposal` structs.
    Proposal[] public proposals;

    /// Create a new ballot to choose one of `proposalNames`.
    constructor(bytes32[] memory proposalNames) {
        //here we used bytes32[] arrany of strings ... 
        // and the key word memory so this value is stored on ram not on block chain
        chairperson = msg.sender;

        // For each of the provided proposal names,
        // create a new proposal object and add it
        // to the end of the array.
        for (uint i = 0; i < proposalNames.length; i++) {
            // `Proposal({...})` creates a temporary
            // Proposal object and `proposals.push(...)`
            // appends it to the end of `proposals`.
            // declare an Struct ie object : Proposal({ name: proposalNames[i], voteCount: 0 })
            proposals.push(Proposal({ name: proposalNames[i], voteCount: 0 }));
        }
    }

    // Give `voter` the right to vote on this ballot.
    // May only be called by `chairperson`.
    function giveRightToVote(address voter) external view {
        // If the first argument of `require` evaluates
        // to `false`, execution terminates and all
        // changes to the state and to Ether balances
        // are reverted.
        // This used to consume all gas in old EVM versions, but
        // not anymore.
        // It is often a good idea to use `require` to check if
        // functions are called correctly.
        // As a second argument, you can also provide an
        // explanation about what went wrong.
        // note that require Halt the prgram . it works like EXIT or TRY CATCH in simple way 
        // note2 'require' take second parameter of string msg to return in case of error
        require( msg.sender == chairperson, "Only chairperson can give right to vote." );
        require( !voters[voter].voted, "The voter already voted." );
    }

    /// Give your vote to proposal `proposals[proposal].name`.
    function vote(uint proposal) external {
        Voter storage sender = voters[msg.sender];

        // check if the voter did not already voted . 
        require(!sender.voted, "Already voted.");

        // notice that after the vaidation we change the state then we do the other work . 
        sender.voted = true;
        sender.vote = proposal;

        // If `proposal` is out of the range of the array,
        // this will throw automatically and revert all
        // changes.
        proposals[proposal].voteCount += 1;
    }

    /// @dev Computes the winning proposal taking all
    /// previous votes into account.
    function winningProposal() public returns (uint winningProposal_)
    {
        uint winningVoteCount = 0;
        for (uint p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > proposals[winningProposal_].voteCount) {
                winningProposal_ = p;
            }
        }
        winningVoteCount = proposals[winningProposal_].voteCount;
        winnerName = proposals[winningProposal()].name;
    }

    // Calls winningProposal() function to get the index
    // of the winner contained in the proposals array and then
    // returns the name of the winner
    function getWinnerName() external returns (bytes32)
    {
        if(winnerName != ''){
            return winnerName;
        }
        else{
            return proposals[winningProposal()].name;
        }
    }
}