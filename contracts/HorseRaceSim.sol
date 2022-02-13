//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
 
/// @title Horse Race Simulation
/// @dev Simulates a betting situation, 1 player vs 4 NPCs and pays out to the winner

contract HorseRaceSim {
    
    // Creates empty list of players and empty value for 'admin'
    address payable[] public players;
    address public admin;
    
    constructor() {
        // Makes contract's initializing account, 'admin'
        admin = msg.sender;
        //Add admin (the house) to list of payable players
        players.push(payable(admin));
    }
    
    modifier onlyOwner() {
        // Ensure only owner can call functions with this modifier
        require(admin == msg.sender, "Only the owner can call that function!");
        _;
    }
    
    /// Receive function allows contract to accept 'bets' of 0.1 Ether
    receive() external payable {
        require(msg.value == 0.1 ether , "Bets placed must be of size 0.1 ETH");
        
        // Add sender's address to players list
        players.push(payable(msg.sender));
    }

     // Allows owner to query balance of contract
    function getBalance() public view onlyOwner returns(uint){ 
        return address(this).balance;
    }

    // Allows owner to query number of players in game
    function getPlayers() public view onlyOwner returns(uint){
        return (players.length);
    }
}