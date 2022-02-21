//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
 
/// @title Horse Race Simulation
/// @dev Simulates a betting situation, 1 player vs 4 NPCs and pays out to the winner

contract HorseRaceSim {
    
    // Creates empty list of players and empty value for 'admin'
    address payable[] public players;
    address public owner;
    
    constructor() {
        // Makes contract's initializing account, 'admin'
        owner = msg.sender;
        //Add owner (the house) to list of payable players
        players.push(payable(owner));
    }
    
    modifier onlyOwner() {
        // Ensure only owner can call functions with this modifier
        require(owner == msg.sender, "Only the owner can call that function!");
        _;
    }
    
    /// Receive function allows contract to accept 'bets' of 0.1 Ether
    function enter() external payable {
        require(msg.value == 0.01 ether , "Bets placed must be of size 0.01 ETH");
        
        // Add sender's address to players list
        players.push(payable(msg.sender));
    }

     // Allows owner to query balance of contract
    function getBalance() public view returns(uint){ 
        return address(this).balance;
    }

    // Allows owner to query number of players in game
    function getPlayers() public view returns(uint){
        return (players.length);
    }

    function getRandomNumber() internal view returns(uint){
        return uint(keccak256(abi.encodePacked(owner, block.timestamp)))
    }

    function pickWinner() public onlyOwner {
 
        require(players.length == 6 , "This is a 6 horse race. More players needed");
        
        address payable winner;
        winner = players[getRandomNumber() % players.length];

        // 95% balance to winner
        uint winnings = getBalance() * 95 / 100;
        // 5% admin fee for owner
        uint adminFee = getBalance() * 5 / 100;

        winner.transfer(winnings);
        payable(owner).transfer( adminFee);
        
        resetPlayers();
    }

    function resetPlayers() internal {
        players = new address payable[](0);
    }
}