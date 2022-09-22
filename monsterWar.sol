// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

//contact : Fettah@n3xt.tech
//crypto wallet : Fettah@crypto

/*
simple game I (fettah) created 
there is MosterChest that gives you one of three common monsters with radom attributes . 
contract creator can decide what is the cost of the chest is then any one can buy chests for ETH 
user then can open the chest they have to get one of 3 monsters . 
you can merge 2 monsters to get higher level stronger moster
you send your monster to war by adding eth 
monsters in war get matched randomly and the winner take 90% of the loser eth the remaining 10% sent to the contract creator
*/

contract MosterWar{
    // the admin
    address admin;

    // chest data
    struct Chest{
        uint price;
        mapping (address => uint) owned;
    }
    Chest chest;

    //monster data
    enum element{ fire , water , earth }
    enum rarity{ common , rare , epic , legend }
    struct Stats{
        uint ATK;
        uint DEF;
        uint HP;
        element Element;
        rarity Rarity;
    }
    struct monster{
        uint ID;
        Stats stats;

    }

    constructor(uint _price){
        chest.price = _price;
        admin = msg.sender;
    }

    function buyChest() payable public{
        require(msg.value == chest.price ,"you need to send the chest price");
        payable(admin).transfer(msg.value);
        ++chest.owned[msg.sender];
    }

/*
    function openChest(){
        //todo not finished yet ... 
    }

    function SendToWar(){
        //todo not finished yet ... 
    }


    //todo not finished yet ... 
    */
}