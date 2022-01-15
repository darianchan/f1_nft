// TODO: find correct license type to put here
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract F1_NFT is ERC721 {
    address public owner;
    uint constant public MAX_WHITELIST_MINT_AMOUNT = 5;
    uint constant public MAX_MAIN_MINT_AMOUNT = 8;
    uint public whiteListPrice;
    uint public mainSalePrice;
    // note: we dont put a hard limit on the total nfts because want ability to create 1 of 1 for influencers
    uint constant public WHITELIST_NFT_LIMIT = 1000; // TODO: placeholder for now  
    uint constant public MAIN_SALE_NFT_LIMIT = 9500; // 500 nfts reserved for the team + marketing
    mapping(address => bool) whiteListAddresses;
    uint public tokenID;


    // TODO: can you put numbers in as the symbol name?
    constructor(uint _whiteListPrice, uint _mainSalePrice) ERC721("f1", "f1") {
      owner = msg.sender; // owner will most likely be the multisig wallet that deploys this contract
      whiteListPrice = _whiteListPrice;
      mainSalePrice = _mainSalePrice;
    }

    modifier onlyOwner() {
      require(msg.sender == owner, "only owner can perform this action");
      _;
    }

    // ------------------------ //
    //  WHITELIST FUNCTIONALITY // 
    // -----------------------  //
  
    function addToWhiteList(address[] calldata addresses) public onlyOwner {
      for (uint i=0; i<addresses.length; i++) {
        whiteListAddresses[addresses[i]] = true;
      }
    }

    function whiteListMint(uint nftAmountToMint) public payable {
      checkWhiteListRequirements(nftAmountToMint, msg.value, msg.sender);
      tokenID++;
      _mint(msg.sender, tokenID); // look into using safemint here
    }

    // ------------------------ //
    //  MAIN SALE FUNCTIONALITY // 
    // -----------------------  //

    function mainSaleMint(uint nftAmountToMint) public payable {
      checkWhiteListRequirements(nftAmountToMint, msg.value, msg.sender);
      tokenID++;
      _mint(msg.sender, tokenID);
    }

    // -----------  //
    //   HELPERS   // 
    // ---------- //

    function checkWhiteListRequirements(uint nftAmountToMint, uint amountETHSent, address user) private view {
      require(whiteListAddresses[user] == true, "user address is not on whitelist");

      // TODO: might have to change this if we do a batch mint instead (look into azuki erc721a standard).
      // whiteListMint would only get called once rather than called everytime 1 nft gets minted
      require(amountETHSent >= whiteListPrice, "not enought eth sent");
      require(nftAmountToMint <= MAX_WHITELIST_MINT_AMOUNT, "can't mint more than 5 nfts during pre-sale");
      require(tokenID <= WHITELIST_NFT_LIMIT, "no more nfts available for pre-sale");
      require(IERC721(address(this)).balanceOf(user) <= MAX_WHITELIST_MINT_AMOUNT, "max amount you can have is 5 nfts during pre-sale");
    }

    function checkMainSaleRequirements(uint nftAmountToMint, uint amountETHSent, address user) private view {
      // TODO: might have to change this if we do a batch mint instead (look into azuki erc721a standard).
      // mainSaletMint would only get called once rather than called everytime 1 nft gets minted
      require(amountETHSent >= mainSalePrice, "not enough eth sent");
      require(nftAmountToMint <= MAX_MAIN_MINT_AMOUNT, "can't mint more than 8 nfts during main sale");
      require(tokenID <= MAIN_SALE_NFT_LIMIT, "all nfts are sold out!");

      // TODO: may have to change this if you are allowed 5 from the pre sale + 8 from main sale. Would change to 13
      require(IERC721(address(this)).balanceOf(user) <= MAX_MAIN_MINT_AMOUNT, "max amount you can have is 8 nfts during main sale");
    }

    // in case you want to change the price of the whitelist - would rather just have it set in constructor and get rid of this
    function setWhiteListPrice(uint price) public onlyOwner {
      whiteListPrice = price;
    }

    // useful if all 10k doesn't sell out and then you want to lower the price
    function setMainSalePrice(uint price) public onlyOwner {
      mainSalePrice = price;
    }
}