// We will be using Solidity version 0.5.3
pragma solidity 0.5.3;

// Importing OpenZeppelin's SafeMath Implementation
library SafeMath {

    function add(uint a, uint b) internal pure returns (uint) {
        uint c = a + b;
        assert(c >= a && c >= b);
        return c;
    }
}

contract AuctionBox{
    
    Auction[] public auctions;  
    
    mapping(uint=>list) public mine;
    
    Auction[] public myAuctions;
    
    function show(address m) public returns(Auction[] memory){
        delete myAuctions;
        for(uint i=0;i<count;i++)
        {
            if(mine[i].a == m)
            {
                myAuctions.push(mine[i].b);
            }
        }
        return myAuctions;
    }
    
    uint public count;
    
    struct list{
        address a;
        Auction b;
        uint c;
    }
   
    function createAuction (
        string memory _title,
        uint _startPrice,
        string memory _description
        ) public{
        // set the new instance
        Auction newAuction = new Auction(msg.sender, _title, _startPrice, _description);
        // push the auction address to auctions array
        mine[count] = list(msg.sender,newAuction,now);
        count++;
        auctions.push(newAuction);
    }
    
    
    function returnAllAuctions() public view returns(Auction[] memory){
        return auctions;
    }
}

contract Auction {
    
    using SafeMath for uint256;
    
    address payable public owner; 
    string title;
    uint startPrice;
    string description;
    uint time;
    uint public bidderCount;
    mapping (address=>list) public bidlists;
    
    struct list{
        uint a;
        uint b;
        uint c;
    }
    
    mapping(uint=>address) Bidders;
    
    enum State{Default, Running, Finalized}
    State public auctionState;
    
    enum paidstatus{paid,notpaid}
    paidstatus public paystate;

    uint highestPrice;
    address payable public highestBidder;
    mapping(address => uint) public bids;
    
    /** @dev constructor to creat an auction
      * @param _owner who call createAuction() in AuctionBox contract
      * @param _title the title of the auction
      * @param _startPrice the start price of the auction
      * @param _description the description of the auction
      */
      
    constructor(
        address payable _owner,
        string memory _title,
        uint _startPrice,
        string memory _description
        
        ) public {
        // initialize auction
        owner = _owner;
        title = _title;
        startPrice = _startPrice;
        description = _description;
        auctionState = State.Running;
        time = now;
    }
    
    modifier notOwner(){
        require(msg.sender != owner);
        _;
    }
    
    modifier isOwner(){
        require(msg.sender == owner);
        _;
    }
    
    
    /** @dev Function to place a bid
      * @return true
      */
    
    function placeBid(uint money) public notOwner{
        require(auctionState == State.Running);
        require(money > startPrice);
        // update the current bid
        // uint currentBid = bids[msg.sender] + msg.value;
        uint currentBid = bids[msg.sender].add(money);
        require(currentBid > highestPrice);
        // set the currentBid links with msg.sender
        bids[msg.sender] = currentBid;
        // update the highest price
        highestPrice = currentBid;
        highestBidder = msg.sender;
        uint x = bidlists[msg.sender].b;
        bidlists[msg.sender] = list(currentBid,x+1,now);
        Bidders[bidderCount] = msg.sender;
        if(x==0){bidderCount++;}
    }
    
    function pay(uint amt) public payable{
        uint currentBid = bids[msg.sender].add(amt);
        require(currentBid > highestPrice);
        bids[msg.sender] = currentBid;
        highestPrice = currentBid;
        highestBidder = msg.sender;
    }
    
    
    function getAll() public view returns (address[] memory){
        address[] memory ret = new address[](bidderCount);
        for (uint i = 0; i < bidderCount; i++) {
            ret[i] = Bidders[i];
        }
        return ret;
    }
    
    function isParticipated(address adr) public view returns(bool){
        bool yes;
        for(uint i=0;i<bidderCount;i++){
            if(adr == Bidders[i])
            {
                yes=true;
            }
            else{
                yes=false;
            }
        }
        return yes;
    }
    
    function finalizeAuction() isOwner public returns(address,uint){
        auctionState  = State.Finalized;
       return(
           highestBidder,
           highestPrice
           );
    }
    
    function showHighestPrice() public view returns(uint){
        return highestPrice;
    }
    /** @dev Function to return the contents od the auction
      * @return the title of the auction
      * @return the start price of the auction
      * @return the description of the auction
      * @return the state of the auction 
      */    
      
    
    function returnContents() public view returns(  
        address,
        string memory,
        uint,
        State,
        uint
        ) {
        return (
            owner,
            title,
            startPrice,
            auctionState,
            time
        );
    }
    
    function getName() public view returns(string memory){
        return title;
    }
    
    function getprice() public view returns(uint){
        return startPrice;
    }
    
    function getdesc() public view returns(string memory){
        return description;
    }
    
    function getstate() public view returns(State){
        return auctionState;
    }
}