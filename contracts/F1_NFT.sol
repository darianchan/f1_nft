// TODO: find correct license type to put here
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

// 0x66e833b935526DCAB7e3E2ccAb9aC7c8870501eF - this the contract address that works
contract F1_NFT is ERC721 {
    address public owner;
    string public baseURI; // https://gateway.pinata.cloud/ipfs/QmToXqD4YkZfJd8BxLq9JEhFV5zqcZKyV5pjSsfuyYqRxu/
    string public baseExtension = ".json";
    uint256 public constant MAX_WHITELIST_MINT_AMOUNT = 5;
    uint256 public constant MAX_MAIN_MINT_AMOUNT = 8;
    uint256 public whiteListPrice;
    uint256 public mainSalePrice;
    // note: we dont put a hard limit on the total nfts because want ability to create 1 of 1 for influencers
    uint256 public constant WHITELIST_NFT_LIMIT = 500; // TODO: placeholder for now
    uint256 public constant MAIN_SALE_NFT_LIMIT = 9500; // 500 nfts reserved for the team + marketing
    mapping(address => bool) public whiteListAddresses;
    mapping(uint256 => string) public uriMap;
    uint256 public tokenID;

    constructor(
        uint256 _whiteListPrice,
        uint256 _mainSalePrice,
        string memory _newBaseURI
    ) ERC721("f1_DAO", "f1") {
        owner = msg.sender;
        whiteListPrice = _whiteListPrice;
        mainSalePrice = _mainSalePrice;
        setBaseURI(_newBaseURI);
        mainSaleMint(10);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner can perform this action");
        _;
    }

    // ------------------------ //
    //  WHITELIST FUNCTIONALITY //
    // -----------------------  //

    function addToWhiteList(address[] calldata addresses) public onlyOwner {
        for (uint256 i = 0; i < addresses.length; i++) {
            whiteListAddresses[addresses[i]] = true;
        }
    }

    function whiteListMint(uint256 nftAmountToMint) public payable {
        checkWhiteListRequirements(nftAmountToMint, msg.value, msg.sender);

        for (uint256 i = 0; i < nftAmountToMint; i++) {
            _mint(msg.sender, tokenID);
            tokenID++;
        }
    }

    // ------------------------ //
    //  MAIN SALE FUNCTIONALITY //
    // -----------------------  //

    function mainSaleMint(uint256 nftAmountToMint) public payable {
        // checkWhiteListRequirements(nftAmountToMint, msg.value, msg.sender); TODO: add back in - just commented out for testing purposes
        for (uint256 i = 0; i < nftAmountToMint; i++) {
            _mint(msg.sender, tokenID);
            tokenID++;
        }
    }

    // -----------  //
    //   HELPERS   //
    // ---------- //

    function checkWhiteListRequirements(
        uint256 nftAmountToMint,
        uint256 amountETHSent,
        address user
    ) private view {
        require(
            whiteListAddresses[user] == true,
            "user address is not on whitelist"
        );

        // TODO: might have to change this if we do a batch mint instead (look into azuki erc721a standard).
        // whiteListMint would only get called once rather than called everytime 1 nft gets minted
        require(amountETHSent >= whiteListPrice, "not enought eth sent");
        require(
            nftAmountToMint <= MAX_WHITELIST_MINT_AMOUNT,
            "can't mint more than 5 nfts during pre-sale"
        );
        require(
            tokenID <= WHITELIST_NFT_LIMIT,
            "no more nfts available for pre-sale"
        );
        require(
            IERC721(address(this)).balanceOf(user) <= MAX_WHITELIST_MINT_AMOUNT,
            "max amount you can have is 5 nfts during pre-sale"
        );
    }

    function checkMainSaleRequirements(
        uint256 nftAmountToMint,
        uint256 amountETHSent,
        address user
    ) private view {
        // TODO: might have to change this if we do a batch mint instead (look into azuki erc721a standard).
        // mainSaletMint would only get called once rather than called everytime 1 nft gets minted
        require(amountETHSent >= mainSalePrice, "not enough eth sent");
        require(
            nftAmountToMint <= MAX_MAIN_MINT_AMOUNT,
            "can't mint more than 8 nfts during main sale"
        );
        require(tokenID <= MAIN_SALE_NFT_LIMIT, "all nfts are sold out!");

        // TODO: may have to change this if you are allowed 5 from the pre sale + 8 from main sale. Would change to 13
        require(
            IERC721(address(this)).balanceOf(user) <= MAX_MAIN_MINT_AMOUNT,
            "max amount you can have is 8 nfts during main sale"
        );
    }

    // useful if all 10k doesn't sell out and then you want to lower the price
    function setMainSalePrice(uint256 price) public onlyOwner {
        mainSalePrice = price;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function setBaseURI(string memory _newBaseURI) public onlyOwner {
        baseURI = _newBaseURI;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );

        string memory currentBaseURI = _baseURI();
        return
            bytes(currentBaseURI).length > 0
                ? string(
                    abi.encodePacked(
                        currentBaseURI,
                        Strings.toString(tokenId),
                        baseExtension
                    )
                )
                : "";
    }
}
