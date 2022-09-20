# Solidity-simple-contracts
Collection of Web3 Solidity smart contracts , with notest and documentation .
some of them are copied or inspired from various sources but with small changes 
others are orgianl created by me will add the word **Original to them**

## 1- Storage 
[simpleStorage.sol](https://github.com/mhd-fettah/Solidity-simple-contracts/blob/main/simpleStorage.sol)
- most simple contract ever 
- store a value on blockchain 
- `get` & `set` functions 

## 2- Math 
[simpleMath.sol](https://github.com/mhd-fettah/Solidity-simple-contracts/blob/main/simpleMath.sol)
- **Original** 
- based on `#1- Storage` 
- two values stored in the blockchain 
- function `function math(string memory opration) public returns(bool,uint)`
that do math you need to spifiy what opration you want { sum , minus , multiple , divide }
- result is stored on the block chain 
- you can call the result without the need to call the function via `latestResult`
- some error handling . 

## 3- Coin 
[simpleCoin.sol](https://github.com/mhd-fettah/Solidity-simple-contracts/blob/main/simpleCoin.sol)
- this is not ERC20 token.
- create a balance to any address that wish to interact with the smart contract . 
- Mint new coins by contract creator only 
- users can send balance to each other 
- some error handling .


## 4- MultiBalance 
[simpleMultiBalance.sol](https://github.com/mhd-fettah/Solidity-simple-contracts/blob/main/simpleMultiBalance.sol)
- **Original** 
- based on `#3- Coin` 
- show the ablility to store muliply balances for each user 
- in this example they are 3 balances USD EURO TL .
- you can add new currencies by increazing the array size.
- one function that do all the mining choose the amount and the currency 
`mint(uint amount,uint currencyID)`
- one function that do all the sending also just choose the amount and the currency 
`send(address receiver, uint amount,uint currencyID)`
- this contract could be devloped more to become financal engin for an app that have users balance 
to make sure all balance are safe and scured on the database . since no double spending and even if the main system got hacked hacker can not change the balances of the users because only them control the balance via thier private keys . 

## 5- Attack Game 
[AttackGame.sol](https://github.com/mhd-fettah/Solidity-simple-contracts/blob/main/AttackGame.sol)
- **Original** 
- based on `#4- MultiBalance ` 

## 6- Attack game V2 
[AttackGame2.sol](https://github.com/mhd-fettah/Solidity-simple-contracts/blob/main/AttackGame2.sol)
- **Original** 
- based on `#4- MultiBalance ` 

## 7- Voting 
[simpleVoting.sol](https://github.com/mhd-fettah/Solidity-simple-contracts/blob/main/simpleVoting.sol)


## 8- Voting with Delegate 
[simpleVotingWithDelgate.sol](https://github.com/mhd-fettah/Solidity-simple-contracts/blob/main/simpleVotingWithDelgate.sol)



## 9- Auction
[simpleAuction.sol](https://github.com/mhd-fettah/Solidity-simple-contracts/blob/main/simpleAuction.sol)
