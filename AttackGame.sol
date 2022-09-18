// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

contract AttackGame {
    address public minter;
    // each player have Attack defince and balance . and joined flag to know if he is new or not
    // name an state.
    mapping (address => int[3]) public Stats;
    mapping (address => bool) joined;
    mapping (address => string) public names;
    string[] StatsInfo = ["Attach","Defince","Balance"];  
    address[] public players;

    // event that triggers when a sent happens .
    event Sent(address from, address to, uint amount,string Currency);

    constructor() {
        minter = msg.sender;
    }

    // function that create a random number in range you pass
    function random(uint number) private view returns(uint){
        return uint(keccak256(abi.encodePacked(block.timestamp,block.difficulty,msg.sender))) % number;
    }
    // join the game
    function join(string memory name) public {
        require(joined[msg.sender] != true);
        joined[msg.sender] = true;
        Stats[msg.sender][0] = 5+int(random(5));
        Stats[msg.sender][1] = 5+int(random(5));
        Stats[msg.sender][2] = 100;
        names[msg.sender] = name;
        players.push(msg.sender);
    }

    // Attach 
    function Attack(address victim) public  {
        require(joined[victim] == true);
        int result = Stats[msg.sender][0] - Stats[victim][1];

        if (result>0){
            // definder loss lots of HP
            Stats[victim][2] -= result*2;
            // attacker losses some hp
            Stats[msg.sender][2] -= result/2;
            //attaker get more experince attacking. 
            Stats[msg.sender][0] += 10;
            //defender get more experince defending
            Stats[victim][1] += 10;
        }else {
            result *= -1;
            // definder loss some of HP
            Stats[victim][2] -= result/2;
            // attacker losses lots hp
            Stats[msg.sender][2] -= result;
            //attaker gets no experince attacking. 
            //Stats[msg.sender][0] += 0;
            //defender get more experince defending
            Stats[victim][1] += 20;
        }
        RemoveTheDead(msg.sender);
        RemoveTheDead(victim);
    }

    function RemoveTheDead(address someOne) private{
        if(Stats[someOne][2] <= 0){
            joined[someOne] = false;
            for(uint i=0;i<players.length;i++){
                if(players[i]==someOne){
                    delete players[i];
                }
            } 
        }
    }
    
}