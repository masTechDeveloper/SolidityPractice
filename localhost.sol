pragma solidity ^0.6.0;

contract testLocalHost {
    
    string public name = "Local Host";
    
    function get() public view returns(string memory) {
        
        return name;
    }
}