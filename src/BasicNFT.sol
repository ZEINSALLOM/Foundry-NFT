// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;
import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    uint256 private s_tokenCounter;
    mapping(uint256 => string) private s_tokenIdToURIs;

    constructor() ERC721("Dogie", "DOG") {
        s_tokenCounter = 0;
    }

    function mintNft(string memory tokenUri) public{
        uint256 tokenId = s_tokenCounter;
        s_tokenIdToURIs[tokenId] = tokenUri;
        _safeMint(msg.sender, tokenId);
        s_tokenCounter++;
    }


    function getTokenCounter() public view returns (uint256) {
        return s_tokenCounter;
    }
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return s_tokenIdToURIs[tokenId];
    }
}
