// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.16 <0.9.0;

//contact : Fettah@n3xt.tech
//crypto wallet : Fettah@crypto

// this simple contract build one simple storage contract 
// https://github.com/mhd-fettah/Solidity-simple-contracts/blob/main/simpleStorage.sol
// to do simple math . 
contract SimpleMath {
    uint firstNumber;
    uint SecondNumber;
    uint latestResult;
    string latestOpration;

    function set(uint VarfirstNumber,uint VarSecondNumber) public {
        firstNumber = VarfirstNumber;
        SecondNumber = VarSecondNumber;
    }

    function checkNumbers() public view returns (uint,uint) {
        return (firstNumber,SecondNumber);
    }

    function checklatestOpration() public view returns (string memory) {
        return (latestOpration);
    }

    function checklatestResult() public view returns (uint) {
        return (latestResult);
    }

    /// use one of oprations . { sum , minus , multiple , divide }
    function math(string memory opration) public returns(bool,uint){

        if (keccak256(bytes(opration))==keccak256(bytes('sum'))){
            latestResult = firstNumber + SecondNumber;
        }
        else if (keccak256(bytes(opration))==keccak256(bytes('minus'))){
            latestResult = firstNumber - SecondNumber;
        } 
        else if (keccak256(bytes(opration))==keccak256(bytes('multiple'))){
            latestResult = firstNumber * SecondNumber;
        } 
        else if (keccak256(bytes(opration))==keccak256(bytes('divide'))){
            latestResult = firstNumber / SecondNumber;
        } 
        else {
            /// your opration name is not recognized
            return (false,0);
        } 
        latestOpration = opration;
        return (true,latestResult);
    }
}

//contact : Fettah@n3xt.tech
//crypto wallet : Fettah@crypto