pragma solidity  >= 0.4.25 < 0.7.0;

import "./SafeMath.sol";

interface IERC20 {
  
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract MSTOKEN is IERC20{
    
using SafeMath for uint256;
    
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    
    uint256 private _totalSupply;
    address  payable owner;
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public FIXED_PRICE = 1 ether;

    constructor () public {
        name = "MSTOKEN";
        symbol = "MST";
        decimals = 2;
        owner = msg.sender;
    
        _totalSupply = 1000 * 10**uint256(decimals);
 
        _balances[owner] = _totalSupply;
        
        emit Transfer(address(this),owner,_totalSupply);
     }

    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }
    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        address sender = msg.sender;
        // require(sender != address(0), "BCC1: transfer from the zero address");
        // require(recipient != address(0), "BCC1: transfer to the zero address");
        // require(_balances[sender] > amount,"BCC1: transfer amount exceeds balance");

        _balances[sender] = _balances[sender] - amount;

        _balances[recipient] = _balances[recipient] + amount;

        emit Transfer(sender, recipient, amount);
        return true;
    }
 
    function allowance(address tokenOwner, address spender) public view virtual override returns (uint256) {
        return _allowances[tokenOwner][spender];
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address tokenOwner = msg.sender;
        require(tokenOwner != address(0), "BCC1: approve from the zero address");
        require(spender != address(0), "BCC1: approve to the zero address");
        
        _allowances[tokenOwner][spender] = amount;
        
        emit Approval(tokenOwner, spender, amount);
        return true;
    }

    function transferFrom(address tokenOwner, address recipient, uint256 amount) public virtual override returns (bool) {
        address spender = msg.sender;
        uint256 _allowance = _allowances[tokenOwner][spender];
        // require(_allowance > amount, "BCC1: transfer amount exceeds allowance");
        _allowance = _allowance - amount;
        _balances[tokenOwner] =_balances[tokenOwner] - amount; 
        _balances[recipient] = _balances[recipient] + amount;
        emit Transfer(tokenOwner, recipient, amount);
        _allowances[tokenOwner][spender] = _allowance;
        emit Approval(tokenOwner, spender, amount);
        return true;
    }
    
    
    receive () external payable{
        
    }
    

    fallback() payable external {
    // uint256 tokens_to_credit = msg.value/FIXED_PRICE; //use SafeMath's div eventually
    // //Credit the user and emit a transfer event
    
    // transferFrom(owner, msg.sender, tokens_to_credit  );
    
            uint256 _value = msg.value;
    
            uint256 tokens_to_credit = _value/FIXED_PRICE;
            // payable(owner).transfer(msg.value);
    
    // msg.sender.transfer(msg.value);        
            // approve(msg.sender, tokens_to_credit);
            
            transferFrom(owner,msg.sender, tokens_to_credit  );
}
    
    
    
    function getBalance(address _add) public view returns (uint256) {
        return _add.balance;
    }
    
    
    
    //     function PayEther () external payable returns (bool success) {
    //         uint256 tokens_to_credit = msg.value/FIXED_PRICE;
    //         payable(owner).transfer(msg.value);
            
    //         approve(msg.sender, tokens_to_credit);
            
    //         transfer(msg.sender, tokens_to_credit  );
        
    //     return true;
    // }
    
    //       fallback() external payable {
    //     msg.sender.transfer(msg.value);
    // }
        
    // function CheckBalance( address _address) public view returns(uint256){
    //     return _address.balance;
    // }


    // fallback () external payable {
        
        
    //         uint256 tokens;
    //         tokens = msg.value.mul(500);
    //         _balances[msg.sender] = _balances[msg.sender].add(tokens);
    //         _totalSupply = _totalSupply.add(tokens);
    //         emit Transfer(address(0), msg.sender, tokens);
    //         owner.transfer(msg.value);
   // }
    

    // function transferAnyERC20Token(address payable tokenAddress, uint256 tokens) public payable onlyOwner() returns (bool success) {
    //     return PIAICBCCToken(tokenAddress).transfer(owner, tokens);
    // }

    // function transferReserveToken(address tokenAddress, uint256 tokens) public onlyOwner returns (bool success) {
    //     return this.transferFrom(owner,tokenAddress, tokens);
    // }
    
    //fallback function can be used to buy tokens
//   fallback () external payable {
//     buyTokens(msg.sender);
//   }

//   // low level token purchase function
//   function buyTokens(address beneficiary) public payable {
//     require(beneficiary != address(0));
//     // require(validPurchase());

//     uint256 weiAmount = msg.value;

//     // calculate token amount to be created
//     uint256 tokens = weiAmount.mul(rate);

//     // update state
//     weiRaised = weiRaised.add(weiAmount);

//     token.mint(beneficiary, tokens);
//     TokenPurchase(msg.sender, beneficiary, weiAmount, tokens);

//     forwardFunds();
//   }


}




contract Sale {
    
        // uint256 public FIXED_PRICE = 1 ether;
    
     function buyTokens (address payable _address) public payable{
            // uint256 tokens_to_credit = msg.value/FIXED_PRICE;
           ( _address).transfer(msg.value);
            
            // approve(msg.sender, tokens_to_credit);
            
            // transfer(msg.sender, tokens_to_credit  );
        
        // return true;
    }
    
    
}