//SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

/* 
@title Horse Race Simulation
@license GNU GPLv3
@author Warren Dubery
@dev Simulates a betting situation, 1 player vs 4 NPCs and pays out to the winner
*/

contract HorseRaceSim {
    
    // Creates empty list of players and empty value for 'admin'
    address payable[] public players;
    address public admin;
    
    constructor() {
        // Makes contract's initializing account, 'admin'
        admin = msg.sender;
    }
    
    modifier onlyOwner() {
        // Ensure only owner can call functions with this modifier
        require(admin == msg.sender, "You are not the owner");
        _;
    }
}
