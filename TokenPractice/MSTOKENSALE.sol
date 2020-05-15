// pragma solidity >=0.4.25 <0.7.0;

// // import "openzeppelin-solidity/contracts/token/ERC20/ERC20.sol";
// // import "openzeppelin-solidity/contracts/math/SafeMath.sol";

// import "./MSTOKEN.sol";
// import "./SafeMath.sol";

// contract MSTOKENSALE {
//   using SafeMath for uint256;

//   MSTOKEN public token;
//   address payable public wallet;
//   uint256 public rate;
//   uint256 public weiRaised;

//   constructor(uint256 _rate, MSTOKEN _token) public {
//     // require(_rate > 0);
//     // require(_wallet != address(0));
//     // require(_token != address(0));

//     rate = _rate;
//     // wallet = _wallet;
//     token = _token;
//   }

// //   fallback () external payable {
    
// //   }

//   function buyTokens(address _beneficiary) external payable {
//     // require(_beneficiary != address(0));
//     // require(msg.value != 0);

//     uint256 tokens = msg.value.mul(rate);
//     weiRaised = weiRaised.add(msg.value);
//     token.transfer(_beneficiary, tokens);
//     // wallet.transfer(msg.value);
//   }
  
  
  
// }


























pragma solidity >=0.4.21 <0.7.0;

import "./MSTOKEN.sol";
import "./SafeMath.sol";

contract MSTOKENSALE {
    
    
using SafeMath for uint256;
    
    address payable admin;
    MSTOKEN public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokenSold;

    event Sell(address _buyer, uint256 _amount);

    constructor(MSTOKEN _tokenContract) public {
        admin = msg.sender;
        tokenContract = _tokenContract;
        tokenPrice = 1000000000000000000;
    }

    // fallback() external payable {
    //     msg.sender.transfer(msg.value);
    // }

    function muliply(uint256 x, uint256 y) internal pure returns (uint256 z) {
        require(y == 0 || (z = x * y) / y == x, "Error");
    }

    function buyTokens(uint256 _numberOfTokens) public payable {
          uint256 amountTobuy = msg.value;
          require(
            amountTobuy == ( muliply(_numberOfTokens, tokenPrice) ).div( uint256(10**18)),
            "msg value should be equal to mul fun"
        );
        
      
        uint256 tokenBalance = tokenContract.balanceOf(address(this));
        require(amountTobuy > 0, "You need to send some Ether");
        require(amountTobuy <= tokenBalance, "Not enough tokens in the reserve");
        tokenContract.transfer(msg.sender, amountTobuy);
        // emit Bought(amountTobuy);
        
        
        
        
        // require(
        //     msg.sender == muliply(_numberOfTokens, tokenPrice),
        //     "msg value should be equal to mul fun"
        // );
        
        
        
        // require(tokenContract.balanceOf(admin) >= _numberOfTokens, "");
        // require(tokenContract.transfer(msg.sender, _numberOfTokens), "");
        // tokenSold += _numberOfTokens;
        // emit Sell(msg.sender, _numberOfTokens);
    }

   
}


























// pragma solidity ^0.6.0;

// interface IERC20 {

//     function totalSupply() external view returns (uint256);
//     function balanceOf(address account) external view returns (uint256);
//     function allowance(address owner, address spender) external view returns (uint256);

//     function transfer(address recipient, uint256 amount) external returns (bool);
//     function approve(address spender, uint256 amount) external returns (bool);
//     function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);


//     event Transfer(address indexed from, address indexed to, uint256 value);
//     event Approval(address indexed owner, address indexed spender, uint256 value);
// }


// contract ERC20Basic is IERC20 {

//     string public constant name = "ERC20Basic";
//     string public constant symbol = "ERC";
//     uint8 public constant decimals = 18;  


//     event Approval(address indexed tokenOwner, address indexed spender, uint tokens);
//     event Transfer(address indexed from, address indexed to, uint tokens);


//     mapping(address => uint256) balances;

//     mapping(address => mapping (address => uint256)) allowed;
    
//     uint256 totalSupply_ = 10 ether;

//     using SafeMath for uint256;

//   constructor() public {  
// 	balances[msg.sender] = totalSupply_;
//     }  

//     function totalSupply() public override view returns (uint256) {
// 	return totalSupply_;
//     }
    
//     function balanceOf(address tokenOwner) public override view returns (uint256) {
//         return balances[tokenOwner];
//     }

//     function transfer(address receiver, uint256 numTokens) public override returns (bool) {
//         require(numTokens <= balances[msg.sender]);
//         balances[msg.sender] = balances[msg.sender].sub(numTokens);
//         balances[receiver] = balances[receiver].add(numTokens);
//         emit Transfer(msg.sender, receiver, numTokens);
//         return true;
//     }

//     function approve(address delegate, uint256 numTokens) public override returns (bool) {
//         allowed[msg.sender][delegate] = numTokens;
//         emit Approval(msg.sender, delegate, numTokens);
//         return true;
//     }

//     function allowance(address owner, address delegate) public override view returns (uint) {
//         return allowed[owner][delegate];
//     }

//     function transferFrom(address owner, address buyer, uint256 numTokens) public override returns (bool) {
//         require(numTokens <= balances[owner]);    
//         require(numTokens <= allowed[owner][msg.sender]);
    
//         balances[owner] = balances[owner].sub(numTokens);
//         allowed[owner][msg.sender] = allowed[owner][msg.sender].sub(numTokens);
//         balances[buyer] = balances[buyer].add(numTokens);
//         emit Transfer(owner, buyer, numTokens);
//         return true;
//     }
// }

// library SafeMath { 
//     function sub(uint256 a, uint256 b) internal pure returns (uint256) {
//       assert(b <= a);
//       return a - b;
//     }
    
//     function add(uint256 a, uint256 b) internal pure returns (uint256) {
//       uint256 c = a + b;
//       assert(c >= a);
//       return c;
//     }
// }

// contract DEX {
    
//     event Bought(uint256 amount);
//     event Sold(uint256 amount);

//     IERC20 public token;

//     constructor() public {
//         token = new ERC20Basic();
//     }
    
//     function buy() payable public {
//         uint256 amountTobuy = msg.value;
//         uint256 dexBalance = token.balanceOf(address(this));
//         require(amountTobuy > 0, "You need to send some Ether");
//         require(amountTobuy <= dexBalance, "Not enough tokens in the reserve");
//         token.transfer(msg.sender, amountTobuy);
//         emit Bought(amountTobuy);
//     }
    
//     function sell(uint256 amount) public {
//         require(amount > 0, "You need to sell at least some tokens");
//         uint256 allowance = token.allowance(msg.sender, address(this));
//         require(allowance >= amount, "Check the token allowance");
//         token.transferFrom(msg.sender, address(this), amount);
//         msg.sender.transfer(amount);
//         emit Sold(amount);
//     }
    
//     function checkBalance (address _add) public view returns(uint256) {
        
//         return _add.balance;
        
//     }

// }