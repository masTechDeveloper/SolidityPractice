// pragma solidity ^0.6.0;



// contract check {
    
    
//     struct Purchase {
//         uint product_id;
//         address[] payment;
//     }
    
//     struct Payment {
//         address maker;
//         uint amount;
//     }

//     Purchase[] purchases;
    
//     // Payment[] payment;

    
//     function makePayment(uint _id, uint _amount) public  {
        
//         Payment[] storage ar;
        
//         ar.push(msg.sender);
        
//         Payment memory p = Payment(msg.sender, _amount);
        
//         // purchases.push({product_id: _id});
       
//     }
// }








pragma solidity ^0.4.18;

contract StructArrayInitWrong {
    
    
     struct Purchase {
        uint product_id;
        Payment[] payment;
    }
    
    struct Payment {
        address maker;
        uint amount;
    }

    Purchase[] pur;
    
   
    
  function createRoom(uint _amount) public {
       Payment[] storage  pay;
  pay.push(Payment(msg.sender, _amount));
      
      Purchase memory p = Purchase(_amount, pay);
      
      pur.push(Purchase(_amount, pay));
      
                                    // <=== note gaping hole
    // adr.push(msg.sender);
    // Room memory room = Room(adr);   
    // rooms.push(room);
  }
  
  function get() public view returns(Purchase[]) {
      return pur;
  }


}