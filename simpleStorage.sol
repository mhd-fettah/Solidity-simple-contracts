// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

//this simple contract store data as int in StoreData var 
// you can get the data via get() function 
// and set the data via Set(uint x) function
contract SimpleStorage {
    uint storedData;

    function set(uint x) public {
        storedData = x;
    }

    function get() public view returns (uint) {
        return storedData;
    }
}