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

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;

    // our main function . for creating new zombies
    function createRandomZombie(string memory _name) public {
        require(ownerZombieCount[msg.sender] == 0);
        // get new random DNA from _generateRandomDna function using the name as seed . 
        uint randDna = _generateRandomDna(_name);
        // create the zombie using the provided name plus the random dna we just created . 
        randDna = randDna - randDna % 100;
        _createZombie(_name, randDna);
    }

    // we put the public functions first then the private functions 
    // function that creates new zombie 
    function _createZombie(string memory _name, uint _dna) internal  {
        // add the new created zombie to the zombies array .
        zombies.push(Zombie(_name, _dna));
        uint id = zombies.length;
        zombieToOwner[id] = msg.sender;
        ownerZombieCount[msg.sender]++;
        // emit event
        emit NewZombie( id, _name, _dna);
    }

    // the random function that creates a random dna 
    function _generateRandomDna(string memory _str) private view returns (uint) {
        // create a random hash using keccak256
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        // resructure it based on our dna module.
        return rand % dnaModulus;
    }

}

interface KittyInterface {
  function getKitty(uint256 _id) external view returns (
    bool isGestating,
    bool isReady,
    uint256 cooldownIndex,
    uint256 nextActionAt,
    uint256 siringWithId,
    uint256 birthTime,
    uint256 matronId,
    uint256 sireId,
    uint256 generation,
    uint256 genes
  );
}

contract ZombieFeeding is ZombieFactory {

  address ckAddress = 0x06012c8cf97BEaD5deAe237070F9587f8E7A266d;
  KittyInterface kittyContract = KittyInterface(ckAddress);

  // Modify function definition here:
  function feedAndMultiply(uint _zombieId, uint _targetDna) public {
    require(msg.sender == zombieToOwner[_zombieId]);
    Zombie storage myZombie = zombies[_zombieId];
    _targetDna = _targetDna % dnaModulus;
    uint newDna = (myZombie.dna + _targetDna) / 2;
    // Add an if statement here
    _createZombie("NoName", newDna);
  }

  function feedOnKitty(uint _zombieId, uint _kittyId) public {
    uint kittyDna;
    (,,,,,,,,,kittyDna) = kittyContract.getKitty(_kittyId);
    // And modify function call here:
    feedAndMultiply(_zombieId, kittyDna);
  }

}