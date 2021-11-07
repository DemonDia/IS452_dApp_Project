pragma solidity ^0.4.10;

contract TransactionManager{
    uint public totalSupply;
    // get address of specific node
    function balanceOf(address _owner) public view returns (uint256 balance);
    
    // msg.sender sends amt to receipent "_to" and returns xfer status (successful or not)
    function transfer(address _to, uint _value)public returns (bool success);
    
    // sends amt to receipent "_to" from sender "_from" if approved
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
    
    // approve token transaction 
    // function approve(address _spender, uint256 value)public returns (bool success);
    
    // function allowance(address _owner, address _spender)public view returns (uint256 remaining);
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}