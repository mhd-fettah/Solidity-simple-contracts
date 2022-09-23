// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

//contact : Fettah@n3xt.tech
//crypto wallet : Fettah@crypto

/*
contract from zombiFactory : https://cryptozombies.io
create and store zombie with random dna 
*/

contract ZombieFactory {

    // event to be emitted when new zombie is created
    event NewZombie(uint zombieId, string name, uint dna);

    // we use this in _generateRandomDna function 
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    // zombie info (somthing like an object)
    struct Zombie {
        string name;
        uint dna;
    }

    // list of all zombies 
    Zombie[] public zombies;

    // our main function . for creating new zombies
    function createRandomZombie(string memory _name) public {
        // get new random DNA from _generateRandomDna function using the name as seed . 
        uint randDna = _generateRandomDna(_name);
        // create the zombie using the provided name plus the random dna we just created . 
        _createZombie(_name, randDna);
    }

    // we put the public functions first then the private functions 
    // function that creates new zombie 
    function _createZombie(string memory _name, uint _dna) private {
        // add the new created zombie to the zombies array .
        zombies.push(Zombie(_name, _dna));
        // emit event
        emit NewZombie(zombies.length , _name, _dna);
    }

    // the random function that creates a random dna 
    function _generateRandomDna(string memory _str) private view returns (uint) {
        // create a random hash using keccak256
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        // resructure it based on our dna module.
        return rand % dnaModulus;
    }

}
