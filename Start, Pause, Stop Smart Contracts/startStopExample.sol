// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.1;

contract StartStopUpdateExample {
    
    address public owner;
    
    // false : Not paused
    // true : paused
    bool public paused;
    
    // This runs the only one time i.e. when the 
    // smart contract is deployed
    constructor() {
        owner = msg.sender;
    }
    
    function setPaused(bool _paused) public {
        require(msg.sender == owner, "You are not authorized !");
        paused = _paused;
    }
    
    function sendMoney() public payable {

    }

    function withdrawAllMoney(address payable _to) public {
        require(msg.sender == owner, "You are not authorized !");
        require(paused == false, "Contract is paused");
        _to.transfer(address(this).balance);
    }
    
    function destroySmartContract(address payable _to) public {
        require(msg.sender == owner, "You are not authorized !");
        // Transfer all the funds within the smart contract to 
        // some other account (_to)
        selfdestruct(_to);
    }
}