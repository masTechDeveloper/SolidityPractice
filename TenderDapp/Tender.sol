pragma solidity ^0.5.16;
pragma experimental ABIEncoderV2;

contract UserAdministration {
    address private owner;
    address[] gouverments;
    address[] users;
    address police;

    modifier isOwner() {
        require(msg.sender == owner, "Is not owner");
        _;
    }

    constructor() public {
        owner = msg.sender;

        gouverments.push(0x7aC5B183b45aFcDfDbB7118B9e9b81401db12858);

        users.push(0xDd95FF2afF341D2726f7a25b4e14b930c27A0E2e);

        police = 0xdD870fA1b7C4700F2BD7f44238821C26f7392148;
    }

    function addUser(address _user) public isOwner {
        users.push(_user);
    }

    function getUsers() public view isOwner returns (address[] memory) {
        return users;
    }

    function isAuthorizedUser(address _user) public view returns (uint256) {
        for (uint256 i = 0; i < users.length; i++) {
            if (users[i] == _user) {
                return 1;
            }
        }
        return 0;
    }

    function addGouvermentUser(address _gouvermentUser) public isOwner {
        gouverments.push(_gouvermentUser);
    }

    function getGouvermentUsers()
        public
        view
        isOwner
        returns (address[] memory)
    {
        return gouverments;
    }

    function isAuthorizedGouvernmentUser(address _gouvermentUser)
        public
        view
        returns (uint256)
    {
        for (uint256 i = 0; i < gouverments.length; i++) {
            if (gouverments[i] == _gouvermentUser) {
                return 1;
            }
        }
        return 0;
    }

    function isPoliceUser(address _policeUser) public view returns (uint256) {
        if (_policeUser == police) {
            return 1;
        } else {
            return 0;
        }
    }
}

// contract Tenders {

// }

contract Tender {
    uint256 private id;
    uint256 private tenderDuration = 5;
    Tender tender;
    UserAdministration userAdministration;

    struct Tender {
        address createrTender;
        string tenderName;
        uint256 tenderDescriptionHash;
        uint256 startDateTendering;
        uint256 endDateTendering;
        uint256 startDateWork;
        uint256 endDateWork;
        string tenderTitle;
        Bit[] bits;
        address[] registeredUsers;
        uint256 finalPrice;
        TenderState tenderState;
    }

    enum TenderState {
        Published,
        Open,
        Waiting,
        Evaluate,
        Evaluated,
        Finished,
        Canceled
    }

    struct Bit {
        address companyAddress;
        uint256 bitDescriptionHash;
    }

    modifier isOverdue() {
        require(tender.endDateWork > block.timestamp, "Time is overdue");
        _;
    }

    constructor(
        uint256 tenderDescriptionhash,
        address _userAdminAddress,
        string memory _tenderTitle
    ) public {
        tender.createrTender = msg.sender;
        tender.tenderDescriptionHash = tenderDescriptionhash;
        tender.startDateTendering = getTime();
        tender.endDateTendering = getTime() + tenderDuration;
        tender.tenderState = TenderState.Open;
        tender.tenderTitle = _tenderTitle;
        userAdministration = UserAdministration(_userAdminAddress);
    }

    // Step 1: Registierung für einen Tender

    function registerToTender() public {
        require(
            userAdministration.isAuthorizedUser(msg.sender) == 1,
            "You are not an authorized user"
        );
        require(
            tender.tenderState == TenderState.Published ||
                tender.tenderState == TenderState.Open,
            "not good"
        );
        tender.registeredUsers.push(msg.sender);
    }

    function getTenderTitle() public view returns (string memory) {
        return tender.tenderTitle;
    }

    function getTenderDescription() public view returns (uint256) {
        require(
            userAdministration.isAuthorizedUser(msg.sender) == 1,
            "You are not an authorized user"
        );
        require(
            isRegisteredUser(msg.sender) == 1,
            "You are not registered User"
        );
        return tender.tenderDescriptionHash;
    }

    function addABit(uint256 _hashBitDocument) public {
        require(
            userAdministration.isAuthorizedUser(msg.sender) == 1,
            "You are not an authorized user"
        );
        require(
            isRegisteredUser(msg.sender) == 1,
            "You are not registered for this tender"
        );
        Bit memory _bit = Bit(msg.sender, _hashBitDocument);
        // _bit.companyAddress = msg.sender;
        // _bit.hashBitDocument = _hashBitDocument;
        tender.bits.push(_bit);
    }

    function stopTender() public {
        require(
            userAdministration.isPoliceUser(msg.sender) == 1,
            "Not police user"
        );
        tender.tenderState = TenderState.Waiting;
    }

    function addTender() public view {
        // Bits[] memory _bits;
        Tender memory _tender;
        // = Tender(msg.sender, "Test", 0, 1, 2, _bits, null);
        _tender.createrTender = msg.sender;
        _tender.tenderName = "Test";
    }

    function getTender() public view returns (Tender memory) {
        return tender;
    }

    function isRegisteredUser(address _user) private view returns (uint256) {
        for (uint256 i = 0; i < tender.registeredUsers.length; i++) {
            if (tender.registeredUsers[i] == _user) {
                return 1;
            }
        }
        return 0;
    }

    function getTime() private view returns (uint256) {
        return block.timestamp;
    }
}