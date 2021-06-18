pragma solidity ^0.5.11;

contract InheritanceModifierExample {
    mapping(address => uint) public tokenBalance;
    
    address owner;
    
    uint tokenPrice = 1 ether;
    
    // Modifier for only owner initiated transactions
    modifier onlyOwner {
        require(msg.sender == owner, "You are not authorized !");
        _;
    }
    
    constructor() public {
        owner = msg.sender;
        tokenBalance[owner] = 100;
    }
    
    function createNewToken() public onlyOwner {
        tokenBalance[owner]++;
    }
    
    
    function burnToken() public onlyOwner {
        tokenBalance[owner]--;
    }
    
    function purchaseToken() public payable {
        require((tokenBalance[owner] * tokenPrice)/msg.value > 0, "Not enough tokens");
        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }
    
    function sendTokens(address _to, uint _amount) public {
        require(tokenBalance[msg.sender] >= _amount, "Not enough tokens");
        assert(tokenBalance[_to] + _amount >= tokenBalance[_to]);
        assert(tokenBalance[msg.sender] - _amount <= tokenBalance[msg.sender]);
        
        tokenBalance[msg.sender] -= _amount;
        tokenBalance[_to] += _amount;
    }
}