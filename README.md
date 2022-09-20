# Solidity simple contracts
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
- simple game I (fettah) created 
- any one can join the game . when joining you select a name 
- you get 5-10 ATK power at random 
- you get 5-10 DEF power at random
- you get 100 HP 
- you can attack other players . as long as your HP over 0
- in each attack if your attack is more that the def of the victim 
- you get more ATK points and loss some HP and victim losses lots of HP
- if your ATK is lower than def HP 
- you get more damage the victim gets small damage and gets extra def points and you get not ATK extra points . 
- when your HP reaches 0 you are out of the game .

## 6- Attack game V2
[AttackGame2.sol](https://github.com/mhd-fettah/Solidity-simple-contracts/blob/main/AttackGame2.sol)
- **Original**  
- based on `#5- Attack Game` 
- **TODO**
	- [ ] improve the game to be a full project .
	- [ ] when joining player pays BNB fee that added to prize pool.
	- [ ] each round have a time limit. at the end of the time limit the prizes distributed to the top players . 
	- [ ] share of the prizes go to devloper . 
	- [ ] share of the prize pool goes to the next stage . 
	- [ ] image of each player generated using AI in use of the player name they will choose . 

## 7- Voting 
[simpleVoting.sol](https://github.com/mhd-fettah/Solidity-simple-contracts/blob/main/simpleVoting.sol)
- `chair person` the one initiating the contract 
- chair person put afew suggestion to vote 
- chair person give the right to vote to some adresses he chooses and add them via `giveRightToVote(address voter)` function.
- users vote using `vote(uint proposal)` function
- at the end you can get the final result via `getWinnerName()` function 

## 8- Voting with Delegate 
[simpleVotingWithDelgate.sol](https://github.com/mhd-fettah/Solidity-simple-contracts/blob/main/simpleVotingWithDelgate.sol)
- based on `#7- Voting` 
- with ability to delegate voting rights .
- users can delegate thier voting rights to other users via `delegate(address to)` function.
- code have some optimization to reduce processing usage and gas .

## 9- Auction
[simpleAuction.sol](https://github.com/mhd-fettah/Solidity-simple-contracts/blob/main/simpleAuction.sol)
- with contract creation you choose the duration of the bidding (time in seconds since 1970-01-01 ie : UNIX time) and the beneficiary
- any one can join and bid by sending Eth (or the native coin of the network if the contract was lunched on other network)
- bidding done via sending native coin to the function . `bid()`
- if the highest bid changed the other bids owners can withdraw thier coins via `withdraw()` function .
- auction ends on time then you can call `auctionEnd()` to send the final bid to the `beneficiary`
