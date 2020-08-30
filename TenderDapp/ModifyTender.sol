pragma solidity ^0.6.0;


contract UserAdministration{
    
    address private owner;
    address[] governments;
    address[] users;
    address police;
    
    constructor() public{
        owner = msg.sender;
        police = 0xdD870fA1b7C4700F2BD7f44238821C26f7392148;
    }
    
    modifier isOwner(){
        require(msg.sender == owner, "is not owner");
        _;
    }
    
    
    mapping(address => bool) public checkUser;
    mapping(address => bool) public checkAdmin;

    
   
    function addUser(address _user) public  {
        users.push(_user);
        checkUser[_user] = true;
    }
    
    function addAdministrater(address _admin) public  {
        governments.push(_admin);
        checkAdmin[_admin] = true;
    }
    
    function getID(address _Id) public view returns(address, string memory, bool) {
        
        if( checkUser[_Id]) {
           return(_Id, "is valid user", true);
        } else if (checkAdmin[_Id]) {
           return(_Id, "is valid goverment member", true);
        }
       else if (_Id == police) {
           return(_Id, "is valid police", true);
       }
        else {
            return(_Id,"not a valid id", false);
        }
        
    }
    
    function getAllUsers() public view returns (address[] memory) {
        return users;
    }
    
    function getAllGovernments() public view returns (address[] memory) {
        return governments;
    }
    
}





contract Tenders is UserAdministration {
  
  
    uint256 private id;
    uint256 private tenderDuration = 5;
    
    struct Tender {
         address tenderCreator;
         string tenderCreatorName;
         string tenderDescription;
         uint256 startDateTendering;
         uint256 endDateTendering;
         uint256 startDateWork;
         uint256 endDateWork;
         string tenderTitle;
        //  Bit[] bits;
        //  address[] registeredUsers;
         uint256 finalPrice;
         TenderState tenderState;
    }
    
    
     Tender[]  tenders;
    
    address[] registeredUsers;
    
    Bid[] public bids;
    
    
    //   struct Bit {
    //     address userAddress;
    //     uint256 bidDescription;
    // }
    
    struct Bid {
        uint256 index;
         address userAddress;
         string bidDescription;
    }
    
    enum TenderState { Open, Waiting, Finished }
    
    constructor() UserAdministration() public {
        
    }
    

    function setTender(
    
        string memory _tenderDescription, 
        string memory _tenderTitle, 
        string memory _tenderCreatorName, 
        uint256 _startDateWork, 
        uint256 _endDateWork, 
        uint256 _finalPrice) public {
            
            
            // Bit memory _bit = Bit(msg.sender, _finalPrice);
            // tenders.bits.push(_bit);
            
            // tenders.push(Tender(tenderCreator = msg.sender));
            
        
            
            
         tenders.push(Tender({
            tenderCreator: msg.sender,
            tenderCreatorName: _tenderCreatorName,
            tenderDescription: _tenderDescription,
            startDateTendering: block.timestamp,
            endDateTendering: block.timestamp + tenderDuration,
            startDateWork: _startDateWork,
            endDateWork: _endDateWork,
            tenderTitle: _tenderTitle,
            finalPrice: _finalPrice,
            tenderState: TenderState.Open
            // bits: Bit(msg.sender, _finalPrice);
        }));
    }
    
    function registerToTender(uint256 _index) public {
        address _Id = msg.sender;
        
        require(checkUser[_Id] == true, "You are not an authorized user");
        require(
            tenders[_index].tenderState == TenderState.Open, 
            "tender not registered"
        );
        
        registeredUsers.push(msg.sender);
    }
    
    
 
    

    function addBid(uint256 _tenderIndex, string memory _bidDescription) public {
        
        require(checkUser[msg.sender] == true, "You are not an authorized user");
        // require(_isRegisteredUser(_tenderIndex, msg.sender) == 1, "You are not registered for this tender");
        
       bids.push(Bid({
             index: _tenderIndex,
            userAddress: msg.sender,
            bidDescription: _bidDescription
        }));
        
     }
     
    function stopTender(uint256 _index) public {
        require(checkUser[msg.sender] == true, "Not police user");
        tenders[_index].tenderState = TenderState.Finished;
        
    }
     
     // private functions
     
    // function _isRegisteredUser(uint256 _index, address _user) private view returns (uint256) {
    //     for (uint i = 0; i < tenders[_index].registeredUsers.length; i++) {
    //         if (tenders[_index].registeredUsers[i] == _user) {
    //             return 1;
    //         }
    //     }
    //     return 0;
    // }

 
    
}