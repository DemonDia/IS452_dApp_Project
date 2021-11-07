pragma solidity ^0.4.18;

import "./Solution.sol";

contract Employers {
    
    bool public flag = false;
    address private owner = tx.origin;
    
    // Sends employee order amount to solution every month
    function sendAmount(address _main, address _employee, uint256 _amount, string _privateKey) public returns (bool success){
        // require their flag to be true
        require(flag==true);
        GPTCoin base = GPTCoin(_main);
        base.addOrder(_employee,_amount, _privateKey);
        flag = false;
        return true;
        // change flag back to false
    }
    
    // Paying of employee by sending employee address and amount (Don't need this)
    // function employeePayment(address _main,address _employee, uint8 _amount) public returns (bool success){
    //     GPTCoin base = GPTCoin(_main);
    //     return base.transferFrom(msg.sender,_employee, _amount);
    // }
    
    // Get balance of company remaining tokens
    function getBalance(address _main, address _owner)public view returns(uint256 balance){
        GPTCoin base = GPTCoin(_main);
        return base.balanceOf(_owner);
    }
    
    // Send amount to our bank, update their flag
    // Changing flag when banks of our own or participating banks receive the money
    function amtPaid() public returns(bool success){
        // require owner or bank/ employer and employee shldnt be able to change flag
        require(msg.sender==owner);
        if (flag==true){
            flag=false;
        }else{
            flag=true;
        }
        return flag;
    }
    function viewOwner()public returns(address){
        return owner;
    }
    function changeOwner(address newAddr)public{
        owner = newAddr;
    }    
}