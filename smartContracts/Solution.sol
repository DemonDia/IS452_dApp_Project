pragma solidity ^0.4.25;

import "./TransactionManager.sol";

contract GPTCoin is TransactionManager{
    
    uint256 constant private MAX_UINT256 = 2**256 - 1;
    mapping(address => uint256) public balances;
    // mapping(address => mapping(address=>uint256)) public allowed;
    mapping(address => uint256) public orders;
    mapping(uint => address) public numAddress;
    
    uint256 public _totalOrders;
    string private employerKey;
    
    string public name;
    uint8 public decimals;
    string public symbol;
    bool public flag;
    address private owner = tx.origin;
    
    constructor(
        uint256 _initialAmount,
        string _tokenName,
        uint8 _decimalUnits,
        string _tokenSymbol
    )public{
        balances[msg.sender] = _initialAmount;
        totalSupply = _initialAmount;
        name = _tokenName;
        decimals = _decimalUnits;
        symbol = _tokenSymbol;
        flag = false;
        
        //FERNERGO should initialize and do this but we are hardcoding first
        employerKey = 'AAAAB3NzaC1yc2EAAAABJQAAAQEAp2LF9WI7J/7Gj74eNrqQGPlP9LYXyvP7xYPmEztBqlY7f2LUJ32ceaE4';
    }
    
    // Adds order into dictionary to generate tokens
    function addOrder (address _addr, uint _amount, string privateKey)public {
        require(checkKeys(privateKey) == true);
        orders[_addr] += _amount;
        numAddress[_totalOrders] = _addr;
        _totalOrders +=1;
    }
    
    // Generates Tokens based on order amount in {'address': amount}
    function generateToken() public returns (bool success){
        require(flag == true);
        uint num = _totalOrders;
        for (uint i=0; i<num; i++){
            //transfer
            //amount[]
            address account = numAddress[i];
            uint a = orders[account];
            require(balances[owner] >= a);
            if (GPTCoin.transfer(account,a)){
                orders[account] = 0;
            }
        }
        GPTCoin.amtReceived();
        return true;
    }
    
    // Changing flag when banks of our own or participating banks receive the money
    // awaits for banks API
    function amtReceived() public returns(bool success){
        // require owner or bank/ employer and employee shldnt be able to change flag
        require(msg.sender==owner);
        if (flag==true){
            flag=false;
        }else{
            flag=true;
        }
        // emit flag;
        return flag;
    }
    
    // Call this function to transafer from msg.sender address to another address
    function transfer(address _to, uint256 _value)public returns(bool success){

        require(balances[msg.sender] >= _value);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender,_to,_value);

        return true;
    }
    
    // Call this function to transfer from one address to another address
    function transferFrom(address _from, address _to, uint256 _value)public returns(bool success){
        require(flag == true);
        require(balances[_from] >= _value);
        balances[_to] += _value;
        balances[_from] -= _value;
        emit Transfer(_from, _to,_value);
        flag = false;
        return true;
    }
    
    // Returns balance amount
    function balanceOf(address _owner)public view returns(uint256 balance){
        return balances[_owner];
    }
    
    // Check with vault key
    function checkKeys(string _key) public view returns(bool success){
        if (keccak256(bytes(employerKey)) == keccak256(bytes(_key))){
            return true;
        }else{
            return false;
        }
    }
    function changeOwner(address newAddr)public{
        owner = newAddr;
    }   
    
}